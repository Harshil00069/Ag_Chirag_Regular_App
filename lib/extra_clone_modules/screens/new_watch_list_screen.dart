import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Controllers/watchlist_ctr.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/extra_clone_modules/controllers/new_search_controller.dart';

import 'new_order_screen.dart';

class NewWatchListScreen extends StatefulWidget {
  const NewWatchListScreen({super.key});

  @override
  State<NewWatchListScreen> createState() => _NewWatchListScreenState();
}

class _NewWatchListScreenState extends State<NewWatchListScreen> {

  WatchListController watchListController = Get.find();
  Timer? timer;

  final NewSearchShareController searchShareController = Get.isRegistered<NewSearchShareController>()
      ? Get.find<NewSearchShareController>()
      : Get.put(NewSearchShareController());
  Duration duration1 = const Duration();
  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(const Duration(seconds: 15 ), (Timer t){

      GetSharePrice();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.purple,
      title:  Text('Watch List',style: Font.bodyText1(),),
    ),
      body: GetBuilder(
        init: watchListController,
        builder: (GetxController controller) {
          print("Watchlist rebuild ${watchListController.watchlist}");

          return Obx(() => watchListController.watchListDataLoad.value? const Align(alignment: Alignment.center,
              child: CircularProgressIndicator()):
          watchListController.watchlist.isNotEmpty?ListView.builder(
              itemCount: watchListController.watchlist.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4.0),
                  child: InkWell(onLongPress: (){
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text(style: const TextStyle(fontSize: 16),
                              "Remove ${watchListController.watchlist[index].tradingsymbol} from Watch List?",),
                            actions: [
                              AppButton(
                                onPress: () {
                                  Navigator.pop(context);
                                },
                                text: "No",
                              ),
                              AppButton(
                                onPress: () {
                                  watchListController
                                      .removeFromWatchList(
                                      watchListController
                                          .watchlist[
                                      index],
                                      index);
                                  Navigator.pop(context);
                                },
                                text: "Yes",
                              ),
                            ],
                          );
                        });
                  },onTap: (){
                    Get.to(() => NewOrderScreen(
                        watchListModel: watchListController
                            .watchlist[index]));
                  },
                    child: Container(margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            //color of shadow
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            // blur radius
                            // offset: const Offset(
                            //     1, 2), // changes position of shadow
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: Get.width*0.65,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(watchListController
                                        .watchlist[index]
                                        .tradingsymbol ??
                                        "",style: const TextStyle(fontSize: 16)),
                                    Text(watchListController
                                        .watchlist[index].exchange ??
                                        "",style: const TextStyle(fontSize: 16)),
                                  ],),
                              ),
                              Text(watchListController.watchlist[index].ltp
                                  .toString() ?? "",style: const TextStyle(fontSize: 16)),
                            ],),


                          // Divider()
                        ],
                      ),
                    ),
                  ),
                );

              }):const SizedBox(child: Text("Data Not Available"),));
        },
      ),
    );
  }

  GetSharePrice() async {
    print("I am Call");
    // watchListController.watchListDataLoad.value = true;
    for (int i = 0; i < watchListController.watchlist.length; i++) {

      num mySharePrice =
      await searchShareController.getSharePrice(
          tradingsymbol: watchListController.watchlist[i].tradingsymbol ?? "",
          symboltoken: watchListController.watchlist[i].symboltoken ?? "",
          exchange: watchListController.watchlist[i].exchange ?? "");

      watchListController.refreshSharePrice(i,mySharePrice);


    }
    watchListController.watchListDataLoad.value = false;
  }
}
