import 'dart:convert';
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Controllers/watchlist_ctr.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/extra_clone_modules/controllers/new_search_controller.dart';
import 'package:treding/model/share_model.dart';
import 'package:treding/model/watch_list_model.dart';

class NewSearchShare extends StatefulWidget {
  const NewSearchShare({super.key});

  @override
  State<NewSearchShare> createState() => _NewSearchShareState();
}

class _NewSearchShareState extends State<NewSearchShare> {

  ValueNotifier selectedSharePrice = ValueNotifier<num>(0);
  ValueNotifier reFreshStart = ValueNotifier<int>(0);

  WatchListController watchListController = Get.find();
  //
  // final NewSearchShareController searchShareController = Get.isRegistered<NewSearchShareController>()
  //     ? Get.find<NewSearchShareController>()
  //     : Get.put(NewSearchShareController());

  NewSearchShareController searchShareController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.purple,
      title:  Text('Search',style: Font.bodyText1(),),
    ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  GetBuilder(
                      init: searchShareController,
                      builder: (ctr) {
                        print("i am rebuild");
                        return Expanded(
                          child:  Obx(()=> searchShareController.isSearchLoading.value ? const LinearProgressIndicator() : DropdownSearch<ShareModel>(
                              popupProps: const PopupProps.menu(showSearchBox: true),
                              items:
                              searchShareController.filterdShareList ?? [],
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration:
                                  InputDecoration(hintText: "Search")),
                              itemAsString: (shareModel) {
                                return shareModel.symbol!;
                              },
                              onChanged: (val) async {
                                print(val?.toJson());
                                if (val != null) {
                                  searchShareController.selectedShare = val;
                                  num mySharePrice =
                                  await searchShareController.getSharePrice(
                                      tradingsymbol: val.symbol ?? "",
                                      symboltoken: val.token ?? "",
                                      exchange: val.exchSeg ?? "");
                                  selectedSharePrice.value = mySharePrice;
                                }

                                reFreshStart.value = Random().nextInt(999999);
                              })),
                        );
                      }),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(),
                          items: Helper.typeList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Type",
                            ),
                          ),
                          selectedItem: searchShareController.selectedType,
                          onChanged: (val) {
                            print("On dp change call");
                            searchShareController.selectedType = val ?? "";
                            searchShareController.filterShareData();
                          }),
                    ),
                    const SizedBox(width: 10),
                    // AppButton(
                    //   text: "Load New Data",
                    //   onPress: () {
                    //     searchShareController.getAllShareData();
                    //   },
                    // )
                  ],),
              ),
              SizedBox(height: 30),
              const Text(
                "Price",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              Card(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: ValueListenableBuilder(
                        valueListenable: selectedSharePrice,
                        builder: (ctx, val, _) {
                          return Text(selectedSharePrice.value.toString());
                        })),
              ),
              SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: reFreshStart,
                  builder: (ctx, val, _) {
                    return searchShareController.selectedShare != null
                        ? AppButton(
                      onPress: () async {
                        List<WatchListModel> watchList =
                        watchListController.watchlist
                            .where((element) {
                          print("${element
                              .tradingsymbol} = ${searchShareController
                              .selectedShare!.symbol}");

                          return element.tradingsymbol ==
                              searchShareController.selectedShare!.symbol;
                        }).toList();

                        print("wlist " + watchList.toString());

                        if (watchList != null && watchList.isNotEmpty) {
                          Helper().showMessage(message: "Already added");
                        } else {
                          WatchListModel watchListModel = WatchListModel(
                              exchange:searchShareController.selectedShare!.exchSeg,
                              symboltoken:searchShareController.selectedShare!.token,
                              tradingsymbol:searchShareController.selectedShare!.symbol,
                              ltp:selectedSharePrice.value,
                              lotsize: searchShareController.selectedShare!.lotsize
                          );
                          watchListController.addToWatchList(watchListModel);

                          List<WatchListModel> watchListLocal = await PrefData.getWatchListData();

                          watchListLocal.add(watchListModel);
                          List<String> userListForSp = [];

                          for (var item in watchListLocal) {
                            userListForSp.add(json.encode(item.toJson()));
                          }

                          PrefData.setWatchData(userListForSp);
                        }
                      },
                      customView: true,
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Add to watch list"),
                          SizedBox(width: 5),
                          Icon(Icons.star_border_outlined)
                        ],
                      ),
                    )
                        : SizedBox.shrink();
                  })
            ],
          )),
    );
  }
}
