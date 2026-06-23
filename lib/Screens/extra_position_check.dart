import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/position_controller.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/material_color_generator.dart';

import 'all_position_update.dart';

class ExtraPositionScreen extends StatefulWidget {
  const ExtraPositionScreen({super.key});

  @override
  State<ExtraPositionScreen> createState() => _ExtraPositionScreenState();
}

class _ExtraPositionScreenState extends State<ExtraPositionScreen> {
  final PositionController ctrl = Get.isRegistered<PositionController>()
      ? Get.find<PositionController>()
      : Get.put(PositionController());

  @override
  void initState() {
    super.initState();
    ctrl.getPositionList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
          IconButton(onPressed: () async {
            await ctrl.getPositionList();
          }, icon: Icon(Icons.refresh))
          ],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'All Positions',
            style: Font.bodyText1(),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ctrl.getPositionList();
          },
          child: Obx(() => ctrl.isDataLoading.value
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : ctrl.positionList.isNotEmpty
                  ? ListView.builder(
                      itemCount: ctrl.positionList.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 4.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
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
                                commanUi(
                                    title: "Client Name :",
                                    value: ctrl.positionList[index].client,
                                    color: Colors.black),
                                commanUi(
                                    title: "product type :",
                                    value: ctrl.positionList[index].producttype,
                                    color: Colors.black),
                                commanUi(
                                    title: "Symbol :",
                                    value:
                                        ctrl.positionList[index].tradingsymbol,
                                    color: Colors.black),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          const Text("Exchanges"),
                                          Text(
                                            ctrl.positionList[index].exchange,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("Option Type"),
                                          Text(
                                            ctrl.positionList[index].optiontype,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ctrl.positionList[index]
                                                            .optiontype ==
                                                        "PE"
                                                    ? Colors.red
                                                    : Colors.green),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("AvgNetPrice"),
                                          Text(
                                            ctrl.positionList[index]
                                                .avgnetprice,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          const Text("Net Qty"),
                                          Text(
                                            ctrl.positionList[index].netqty,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("NetPrice"),
                                          Text(
                                            ctrl.positionList[index].netprice,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("ltp"),
                                          Text(
                                            ctrl.positionList[index].ltp,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Pnl : "),
                                          Text(
                                            ctrl.positionList[index].pnl,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: myChangeColor(
                                                    value: ctrl
                                                        .positionList[index]
                                                        .pnl)),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                          color: Colors.red,
                                                          // your color here
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)))),
                                            onPressed: () {
                                              Get.to(AllPositionUpdate(
                                                netqty: int.parse(ctrl
                                                    .positionList[index].netqty
                                                    .toString()),
                                                exchange: ctrl.positionList[index].exchange
                                                    .toString(),
                                                ltp:
                                                ctrl.positionList[index].ltp.toString(),
                                                symboleToken: ctrl
                                                    .positionList[index].symboltoken
                                                    .toString(),
                                                tradingsymbol: ctrl
                                                    .positionList[index].tradingsymbol
                                                    .toString(),
                                                productType: selectedVariety(index: index),
                                              ));
                                            },
                                            child: const Text(
                                              "Bulk Edit",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: SizedBox(
                      child: Text("Data Not Available"),
                    ))),
        ));
  }

  int selectedVariety({required int index}) {
    int a = 0;
    if (ctrl.positionList[index].producttype == "DELIVERY") {
      a = 2;
    } else if (ctrl.positionList[index].producttype == "CARRYFORWARD") {
      a = 1;
    } else {
      a = 0;
    }
    return a;
  }

  String selectedQty({required int index}) {
    int qty = int.parse(ctrl.positionList[index].netqty.toString());
    String a = "";
    if (qty < 0) {
      int val = qty * -1;
      a = val.toString();
    } else {
      a = qty.toString();
    }
    return a;
  }

  Widget commanUi(
      {required String title, required String value, required Color color}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
              width: Get.width * 0.25,
              child: Text(
                title,
                style: const TextStyle(fontSize: 14),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
              width: Get.width * 0.60,
              child: Text(
                overflow: TextOverflow.clip,
                maxLines: 2,
                value,
                style: TextStyle(color: color, fontSize: 16),
              )),
        )
      ],
    );
  }

  myChangeColor({required String value}) {
    double pnlvalue = 0.0;
    pnlvalue = double.parse(value);
    if (pnlvalue > 0) {
      Color c = Colors.green;
      return c;
    } else {
      Color c = Colors.red;
      return c;
    }
  }
}
