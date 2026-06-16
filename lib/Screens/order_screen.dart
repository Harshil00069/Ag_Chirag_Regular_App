import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Controllers/dashboard_controller.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Screens/my_order.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/model/user_model.dart';

import '../Utils/app_font.dart';
import '../Utils/material_color_generator.dart';
import '../model/watch_list_model.dart';

import 'package:dio/dio.dart' as dio;

class OrderScreen extends StatefulWidget {
  WatchListModel watchListModel;

  OrderScreen({required this.watchListModel});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<String> varityList = ["NORMAL", "STOPLOSS", "AMO"];
  List<String> ordertypeList = [
    "LIMIT",
    "MARKET",
    "STOPLOSS_LIMIT",
    "STOPLOSS_MARKET"
  ];

  List<String> productTypeList = ["CARRYFORWARD","DELIVERY","INTRADAY"];

  ValueNotifier varietyNotifier = ValueNotifier(0);
  ValueNotifier ordertypeNotifier = ValueNotifier(0);
  ValueNotifier productTypeNotifier = ValueNotifier(0);

  TextEditingController tradingSymbolCtr = TextEditingController();
  TextEditingController tradingExchangeCtr = TextEditingController();
  TextEditingController lotSizeCtr = TextEditingController();

  TextEditingController priceCtr = TextEditingController();
  TextEditingController TriggerPriceCtr = TextEditingController();

  //True == Buy
  //false == sell
  ValueNotifier buySellSwitch = ValueNotifier(true);

  HomepageCtr homepageCtr = Get.find();
  List<GetUserListForOrder> userListWithQty = [];
  DashboardCtr ctrl = Get.put(DashboardCtr());
  @override
  void initState() {
    // TODO: implement initState

    tradingSymbolCtr.text = widget.watchListModel.tradingsymbol ?? "-";
    tradingExchangeCtr.text = widget.watchListModel.exchange ?? "-";

    priceCtr.text = widget.watchListModel.ltp.toString() ?? "-";
    lotSizeCtr.text = widget.watchListModel.lotsize.toString() ?? "-";

    for (var item in homepageCtr.userList) {
      userListWithQty.add(GetUserListForOrder(
        userModel: item,
        lotSize: widget.watchListModel.lotsize ?? "0",
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.primaryColor,
      title: Text('PLace Order', style: Font.bodyText1(),),
    ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: Get.width,
                  decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const Text(
                        "Select Variety",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: varietyNotifier,
                          builder: (ctx, val, _) {
                            return Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: List.generate(
                                  varityList.length,
                                      (index) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ChoiceChip(
                                      padding: const EdgeInsets.all(0),
                                      onSelected: (val) {
                                        varietyNotifier.value = index;
                                      },
                                      label: Text(varityList[index]),
                                      selectedColor:
                                      varietyNotifier.value == index
                                          ? Colors.blue
                                          : Colors.transparent,
                                      showCheckmark: false,
                                      labelStyle: TextStyle(
                                          color:
                                          varietyNotifier.value == index
                                              ? Colors.white
                                              : Colors.black),
                                      selected:
                                      varietyNotifier.value == index
                                          ? true
                                          : false,
                                    ),
                                  )),
                            );
                          }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const Text(
                        "Select Order Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: ordertypeNotifier,
                          builder: (ctx, val, _) {
                            return Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: List.generate(
                                  ordertypeList.length,
                                      (index) => Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: ChoiceChip(
                                          padding: const EdgeInsets.all(0),
                                          onSelected: (val) {
                                        ordertypeNotifier.value = index;
                                        },
                                          label: Text(ordertypeList[index]),
                                          selectedColor:
                                          ordertypeNotifier.value == index
                                          ? Colors.blue
                                          : Colors.transparent,
                                          showCheckmark: false,
                                          labelStyle: TextStyle(
                                          color: ordertypeNotifier.value ==
                                              index
                                              ? Colors.white
                                              : Colors.black),
                                                                            selected:
                                                                            ordertypeNotifier.value == index
                                          ? true
                                          : false,
                                                                          ),
                                      )),
                            );
                          })
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const Text(
                        "Select Product Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: productTypeNotifier,
                          builder: (ctx, val, _) {
                            return Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: List.generate(
                                  productTypeList.length,
                                      (index) => Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: ChoiceChip(
                                      padding: const EdgeInsets.all(0),
                                      onSelected: (val) {
                                        productTypeNotifier.value = index;
                                      },
                                      label: Text(productTypeList[index]),
                                      selectedColor:
                                      productTypeNotifier.value == index
                                          ? Colors.blue
                                          : Colors.transparent,
                                      showCheckmark: false,
                                      labelStyle: TextStyle(
                                          color:
                                          productTypeNotifier.value ==
                                              index
                                              ? Colors.white
                                              : Colors.black),
                                      selected:
                                      productTypeNotifier.value == index
                                          ? true
                                          : false,
                                    ),
                                  )),
                            );
                          })
                    ],
                  ),
                ),
              ),



              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Trading Symbol",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    RegTxtField(
                      isReadOnly: true,
                      ctr: tradingSymbolCtr,
                    ),

                    Row(
                      children: [

                        Column(children: [
                          const Text(
                            "Exchanges",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(width: Get.width*0.25,
                            child: RegTxtField(
                              isReadOnly: true,
                              ctr: tradingExchangeCtr,
                            ),
                          ),
                        ],),

                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(children: [
                            const Text(
                              "Lot Size",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(width: Get.width*0.20,
                              child: RegTxtField(
                                isReadOnly: true,
                                ctr: lotSizeCtr,
                              ),
                            ),
                          ],),
                        )

                    ],)

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          SizedBox(width: Get.width*0.30,
                            child: RegTxtField(
                              isReadOnly: true,
                              ctr: priceCtr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Enter Amount",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          RegTxtField(
                              ctr: TriggerPriceCtr,
                              hintTxt: "Enter Amount",
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                  valueListenable: buySellSwitch,
                  builder: (ctx, val, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Sell",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: buySellSwitch.value,
                          onChanged: (val) {
                            buySellSwitch.value = val;
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                        ),
                        const Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Center(child: Text("Client Name"))),
                  // Expanded(child: Center(child: Text("Net"))),
                  Expanded(child: Center(child: Text("qty"))),
                  Expanded(child: Center(child: Text("Total"))),
                ],
              ),
              Divider(),
              Column(
                children: List.generate(
                    userListWithQty.length, (index) => userListWithQty[index]),
              ),

              ValueListenableBuilder(
                  valueListenable: buySellSwitch,
                  builder: (ctx, val, _) {
                    return AppButton(
                        onPress: () async {
                          print(
                              "/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*-*/-*/*-/-*/-*/-*/-*\n\n");

                          String price = "";
                          if (TriggerPriceCtr.value.text.isNotEmpty) {
                            price = TriggerPriceCtr.value.text;
                          } else {
                            price = priceCtr.value.text;
                          }

                          for (int i = 0; i < userListWithQty.length; i++) {
                            if (int.parse(userListWithQty[i].qtyCtr.value.text) > 0) {
                              var data = {
                                "variety": "${varityList[varietyNotifier.value]}",
                                "tradingsymbol":
                                    "${widget.watchListModel.tradingsymbol}",
                                "symboltoken": "${widget.watchListModel.symboltoken}",
                                "transactiontype":
                                    buySellSwitch.value ? "BUY" : "SELL",
                                "exchange": "${widget.watchListModel.exchange}",
                                "ordertype":
                                    "${ordertypeList[ordertypeNotifier.value]}",
                                "producttype":
                                    "${productTypeList[productTypeNotifier.value]}",
                                "duration": "DAY",
                                "price": "${price}",
                                "squareoff": "0",
                                "stoploss": "0",
                                "quantity": "${userListWithQty[i].totalCtr.text}"
                              };
                              print(
                                  "name :- ${userListWithQty[i].userModel.toJson()} => \n"
                                  "$data");

                              try {
                                EasyLoading.show();
                                dio.Response? responce =
                                    await ApiImplementor.placeOrderApiImplementer(
                                        PrivateKey:
                                            '${userListWithQty[i].userModel.privateKey}',
                                        data: data,
                                        token:
                                            '${userListWithQty[i].userModel.jwtToken}');
                                EasyLoading.dismiss();

                                if (responce != null && responce.data['data']  != null) {
                                  print(responce.data);

                                  Helper().showMessage(
                                      message:
                                          "Order Placed for ${userListWithQty[i].userModel.username}");
                                  // DefaultTabController.of(context).animateTo(4);
                                  // Get.to(() => const MyOrder());
                                }else{
                                  Helper().showMessage(
                                      message: "${ responce!.data["message"]}");
                                }
                              } catch (e) {
                                Helper().showMessage(
                                    message:
                                    "$e");
                                print("${e}");
                              }
                            }
                          }
                            Get.back();
                          ctrl.controller.animateTo(3);

                          print(
                              "/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*-*/-*/*-/-*/-*/-*/-*");
                        },
                        text: buySellSwitch.value ? "BUY" : "SELL");
                  }),

            ],
          ),
        ));
  }
}

class GetUserListForOrder extends StatelessWidget {
  UserModel userModel;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  // TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  String lotSize;

  GetUserListForOrder({required this.userModel, required this.lotSize});

  @override
  Widget build(BuildContext context) {
    print("My Lot size :- ${lotSize}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text("${userModel.username}"))),
            // Expanded(
            //     child: Center(child: Text("${userModel.currentBalance ?? 0}"))),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(width: Get.width*0.30,
                child: Center(
                  child: RegTxtField(
                    ctr: qtyCtr,
                    onChanged: (val) {
                      try {
                        totalCtr.text =
                            ((int.parse(lotSize ?? "0")) * int.parse(val))
                                .toString();

                        print(totalCtr.text);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(width: Get.width*0.30,
                child: Center(
                  child: RegTxtField(isReadOnly: true, ctr: totalCtr),
                ),
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}
