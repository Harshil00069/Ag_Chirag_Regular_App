import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/watchlist_ctr.dart';
import 'package:treding/Screens/order_screen.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import '../Utils/app_font.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  WatchListController watchListController = Get.put(WatchListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          watchListController.getSharePriceApi();
        }, icon: Icon(Icons.refresh))
      ],
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Watch List',
          style: Font.bodyText1(),
        ),
      ),
      body: GetBuilder(
        init: watchListController,
        builder: (GetxController controller) {
          return Obx(() => watchListController.watchListDataLoad.value
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : watchListController.watchlist.isNotEmpty
                  ? ListView.builder(
                      itemCount: watchListController.watchlist.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 4.0),
                          child: InkWell(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        style: const TextStyle(fontSize: 16),
                                        "Remove ${watchListController.watchlist[index].tradingsymbol} from Watch List?",
                                      ),
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
                                                        .watchlist[index],
                                                    index);
                                            Navigator.pop(context);
                                          },
                                          text: "Yes",
                                        ),
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Get.to(() => OrderScreen(
                                  watchListModel:
                                      watchListController.watchlist[index]));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.5),
                                    //color of shadow
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    // blur radius
                                    // offset: const Offset(
                                    //     1, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.65,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                watchListController
                                                        .watchlist[index]
                                                        .tradingsymbol ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            Text(
                                                watchListController
                                                        .watchlist[index]
                                                        .exchange ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          watchListController
                                                  .watchlist[index].ltp
                                                  .toString(),
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),

                                  // Divider()
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const SizedBox(
                      child: Text("Data Not Available"),
                    ));
        },
      ),
    );
  }

// GetSharePrice() async {
//   print("I am Call");
//   // watchListController.watchListDataLoad.value = true;
//   for (int i = 0; i < watchListController.watchlist.length; i++) {
//
//     num mySharePrice =
//         await searchShareController.getSharePrice(
//         tradingsymbol: watchListController.watchlist[i].tradingsymbol ?? "",
//         symboltoken: watchListController.watchlist[i].symboltoken ?? "",
//         exchange: watchListController.watchlist[i].exchange ?? "");
//
//     watchListController.refreshSharePrice(i,mySharePrice);
//   }
//   watchListController.watchListDataLoad.value = false;
// }
}
