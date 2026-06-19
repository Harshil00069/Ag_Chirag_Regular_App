import 'dart:convert';
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/search_share_ctr.dart';
import 'package:treding/Controllers/watchlist_ctr.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/model/exchange_list_model.dart';
import 'package:treding/model/search_data_model.dart';
import 'package:treding/model/watch_list_model.dart';

import '../Database/pref_data.dart';
import '../Utils/app_font.dart';
import '../Utils/material_color_generator.dart';

class SearchShare extends StatefulWidget {
  const SearchShare({super.key});

  @override
  State<SearchShare> createState() => _SearchShareState();
}

class _SearchShareState extends State<SearchShare> {
  ValueNotifier selectedSharePrice = ValueNotifier<double>(0.0);
  ValueNotifier reFreshStart = ValueNotifier<int>(0);
  SearchShareController searchShareController =
      Get.put(SearchShareController());
  WatchListController watchListController = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Search',
          style: Font.bodyText1(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text("Exchange",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              ),
              Card(color: Colors.white,
                child: DropdownSearch<ExchangeListData>(
                    popupProps: const PopupProps.menu(),
                    items: searchShareController.exchangeList,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Type",
                      ),
                    ),
                    itemAsString: (sharelistdata) {
                      return sharelistdata.exchangeName;
                    },
                    onChanged: (val) async {
                      if (val!.shortName != "") {
                        await searchShareController.getSearchScriptApi(
                            type: val.shortName);
                      }
                    }),
              ),
            ],),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text("Script",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              ),
              Obx(() => searchShareController.isLoadingNewSearch.value
                  ? const LinearProgressIndicator()
                  : Card(color: Colors.white,
                    child: DropdownSearch<SearchData>(
                    popupProps: const PopupProps.menu(showSearchBox: true),
                    items: searchShareController.newShareList,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration:
                        InputDecoration(hintText: "Search",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,)),
                    itemAsString: (shareModel) {
                      return shareModel.symbol!;
                    },
                    onChanged: (val) async {
                      if (val != null) {
                        searchShareController.selectedShare = val;
                        searchShareController.SelectedShareLotSizes.value =
                        val.lotsize!;
                      }
                      reFreshStart.value = Random().nextInt(999999);
                    }),
                  )),
            ],),
          ),
          SizedBox(height: 20,),
          Obx(() => AppButton(
            isLoading: searchShareController.isScriptLoading.value,
            text: "Load New Data",
            onPress: () {
              searchShareController.getLoadSearchScriptApi();
            },
          )),
          SizedBox(height: 20,),
          ValueListenableBuilder(
              valueListenable: reFreshStart,
              builder: (ctx, val, _) {
                return searchShareController.selectedShare != null
                    ? AppButton(
                        onPress: () async {
                          List<WatchListModel> watchList =
                              watchListController.watchlist
                                  .where((element) {
                            // print(
                            //     "${element.tradingsymbol} = ${searchShareController.selectedShare!.symbol}");

                            return element.tradingsymbol ==
                                searchShareController.selectedShare!.symbol;
                          }).toList();

                          if (watchList.isNotEmpty) {
                            Helper().showMessage(message: "Already added");
                          } else {
                            WatchListModel watchListModel = WatchListModel(
                                exchange: searchShareController
                                    .selectedShare!.exchSeg,
                                symboltoken: searchShareController
                                    .selectedShare!.token,
                                tradingsymbol: searchShareController
                                    .selectedShare!.symbol,
                                ltp: selectedSharePrice.value,
                                lotsize: searchShareController
                                    .SelectedShareLotSizes.value
                                    .toString());
                            watchListController
                                .addToWatchList(watchListModel);

                            List<WatchListModel> watchListLocal =
                                await PrefData.getWatchListData();

                            watchListLocal.add(watchListModel);
                            List<String> userListForSp = [];

                            for (var item in watchListLocal) {
                              userListForSp.add(json.encode(item.toJson()));
                            }

                            PrefData.setWatchData(userListForSp);
                          }
                        },
                        customView: true,
                        widget: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Add to watch list"),
                            SizedBox(width: 5),
                            Icon(Icons.star_border_outlined)
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              })

          //   Row(
          //     children: [
          //       GetBuilder(
          //           init: searchShareController,
          //           builder: (ctr) {
          //             print("i am rebuild");
          //             return Expanded(
          //               child:  Obx(()=> searchShareController.isSearchLoading.value ? const LinearProgressIndicator()
          //                   : DropdownSearch<ShareModel>(
          //                   popupProps: const PopupProps.menu(showSearchBox: true),
          //                   items: searchShareController.filterdShareList ?? [],
          //                   dropdownDecoratorProps: const DropDownDecoratorProps(
          //                       dropdownSearchDecoration:
          //                       InputDecoration(hintText: "Search")),
          //                   itemAsString: (shareModel) {
          //                     return shareModel.symbol!;
          //                   },
          //                   onChanged: (val) async {
          //                     print(val?.toJson());
          //                     if (val != null) {
          //                       searchShareController.selectedShare = val;
          //                       num mySharePrice =
          //                       await searchShareController.getSharePrice(
          //                           tradingsymbol: val.symbol ?? "",
          //                           symboltoken: val.token ?? "",
          //                           exchange: val.exchSeg ?? "");
          //                       selectedSharePrice.value = mySharePrice;
          //                     }
          //
          //                     reFreshStart.value = Random().nextInt(999999);
          //                   })),
          //             );
          //           }),
          //
          //     ],
          //   ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //
          //     const SizedBox(width: 10),
          //     SizedBox(
          //       width: 100,
          //       child: DropdownSearch<String>(
          //           popupProps: PopupProps.menu(),
          //           items: Helper.typeList,
          //           dropdownDecoratorProps: const DropDownDecoratorProps(
          //             dropdownSearchDecoration: InputDecoration(
          //               hintText: "Type",
          //             ),
          //           ),
          //           selectedItem: searchShareController.selectedType,
          //           onChanged: (val) {
          //             print("On dp change call");
          //             searchShareController.selectedType = val ?? "";
          //             searchShareController.filterShareData();
          //           }),
          //     ),
          //     const SizedBox(width: 10),
          //     // AppButton(
          //     //   text: "Load New Data",
          //     //   onPress: ()  {
          //     //     searchShareController.getAllShareData();
          //     //   },
          //     // )
          //   ],),
          // ),
          //   SizedBox(height: 30),
          //   const Text(
          //     "Price",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          //   ),
          //   SizedBox(height: 10),
          //   Card(
          //     child: Container(
          //         padding: EdgeInsets.all(10),
          //         child: ValueListenableBuilder(
          //             valueListenable: selectedSharePrice,
          //             builder: (ctx, val, _) {
          //               return Text(selectedSharePrice.value.toString());
          //             })),
          //   ),
          //   SizedBox(height: 10),
          //   ValueListenableBuilder(
          //       valueListenable: reFreshStart,
          //       builder: (ctx, val, _) {
          //         return searchShareController.selectedShare != null
          //             ? AppButton(
          //           onPress: () async {
          //             List<WatchListModel> watchList =
          //             watchListController.watchlist
          //                 .where((element) {
          //               print("${element
          //                   .tradingsymbol} = ${searchShareController
          //                   .selectedShare!.symbol}");
          //
          //               return element.tradingsymbol ==
          //                   searchShareController.selectedShare!.symbol;
          //             }).toList();
          //
          //             print("wlist " + watchList.toString());
          //
          //             if (watchList != null && watchList.isNotEmpty) {
          //               Helper().showMessage(message: "Already added");
          //             } else {
          //               WatchListModel watchListModel = WatchListModel(
          //                   exchange:searchShareController.selectedShare!.exchSeg,
          //                   symboltoken:searchShareController.selectedShare!.token,
          //                   tradingsymbol:searchShareController.selectedShare!.symbol,
          //                   ltp:selectedSharePrice.value,
          //                 lotsize: searchShareController.selectedShare!.lotsize
          //               );
          //               watchListController.addToWatchList(watchListModel);
          //
          //               List<WatchListModel> watchListLocal = await PrefData.getWatchListData();
          //
          //               watchListLocal.add(watchListModel);
          //               List<String> userListForSp = [];
          //
          //               for (var item in watchListLocal) {
          //                 userListForSp.add(json.encode(item.toJson()));
          //               }
          //
          //               PrefData.setWatchData(userListForSp);
          //
          //
          //
          //
          //             }
          //           },
          //           customView: true,
          //           widget: const Row(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Text("Add to watch list"),
          //               SizedBox(width: 5),
          //               Icon(Icons.star_border_outlined)
          //             ],
          //           ),
          //         )
          //             : SizedBox.shrink();
          //       })
        ],
      ),
    );
  }
}
