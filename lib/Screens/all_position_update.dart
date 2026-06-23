import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/position_controller.dart';
import 'package:treding/Utils/app_dialogs.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/model/place_order_model.dart';
import 'package:treding/model/user_model.dart';

import '../Controllers/homepage_controller.dart';
import '../Utils/app_font.dart';
import '../Utils/material_color_generator.dart';

class AllPositionUpdate extends StatefulWidget {
  final String tradingsymbol;
  final String exchange;
  final String ltp;
  final int productType;
  final int netqty;
  final String symboleToken;

  const AllPositionUpdate(
      {super.key,
      required this.tradingsymbol,
      required this.exchange,
      required this.ltp,
      required this.productType,
      required this.symboleToken,
      required this.netqty});

  @override
  State<AllPositionUpdate> createState() => _AllPositionUpdateState();
}

class _AllPositionUpdateState extends State<AllPositionUpdate> {
  List<String> varityList = ["NORMAL", "STOPLOSS", "AMO"];
  List<String> ordertypeList = [
    "LIMIT",
    "MARKET",
    "STOPLOSS_LIMIT",
    "STOPLOSS_MARKET"
  ];

  List<String> productTypeList = ["DELIVERY", "CARRYFORWARD", "INTRADAY"];
  ValueNotifier varietyNotifier = ValueNotifier(0);
  ValueNotifier ordertypeNotifier = ValueNotifier(0);
  ValueNotifier productTypeNotifier = ValueNotifier(0);

  TextEditingController tradingSymbolCtr = TextEditingController();
  TextEditingController tradingExchangeCtr = TextEditingController();

  TextEditingController priceCtr = TextEditingController();
  TextEditingController triggerPriceCtr = TextEditingController();
  ValueNotifier buySellSwitch = ValueNotifier(true);

  List<GetUserListForOrder> userListWithQty = [];

  HomepageCtr homeScreenController = Get.put(HomepageCtr());
  final PositionController ctrl = Get.isRegistered<PositionController>()
      ? Get.find<PositionController>()
      : Get.put(PositionController());

  @override
  void initState() {
    super.initState();

    tradingSymbolCtr.text = widget.tradingsymbol;
    tradingExchangeCtr.text = widget.exchange;

    priceCtr.text = widget.ltp.toString();
    triggerPriceCtr.text = widget.ltp.toString();
    productTypeNotifier.value = widget.productType;

    for (int i = 0; i < ctrl.positionList.length; i++) {
      if (widget.tradingsymbol == ctrl.positionList[i].tradingsymbol) {
        int index = homeScreenController.userList.indexWhere((data) {
          return data.clientcode == ctrl.positionList[i].client;
        });

        if (index != -1) {
          userListWithQty.add(GetUserListForOrder(
            price: ctrl.positionList[i].netprice.toString(),
            userModel: homeScreenController.userList[index],
            qty: ctrl.positionList[i].netqty.toString(),
          ));
        }
      }
    }

    if (widget.netqty < 0) {
      buySellSwitch.value = true;
    } else {
      buySellSwitch.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'All Position Update',
            style: Font.bodyText1(),
          ),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
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
                                                color: varietyNotifier.value ==
                                                        index
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
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
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
                                                color:
                                                    ordertypeNotifier.value ==
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
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
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
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: ChoiceChip(
                                            padding: const EdgeInsets.all(0),
                                            onSelected: (val) {
                                              productTypeNotifier.value = index;
                                            },
                                            label: Text(productTypeList[index]),
                                            selectedColor:
                                                productTypeNotifier.value ==
                                                        index
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
                                                productTypeNotifier.value ==
                                                        index
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      RegTxtField(
                        isReadOnly: true,
                        ctr: tradingSymbolCtr,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Exchanges",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: Get.width * 0.25,
                            child: RegTxtField(
                              isReadOnly: true,
                              ctr: tradingExchangeCtr,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: Get.width * 0.40,
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
                            const Text(
                              "Enter Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            RegTxtField(
                                ctr: triggerPriceCtr,
                                hintTxt: "Enter Amount",
                                keyboardType: TextInputType.number),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                IgnorePointer(
                  ignoring: true,
                  child: ValueListenableBuilder(
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
                              activeThumbColor: Colors.green,
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
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text("Client Name"))),
                    Expanded(child: Center(child: Text("Price"))),
                    Expanded(child: Center(child: Text("qty"))),
                  ],
                ),
                const Divider(),
                Column(
                  children: List.generate(userListWithQty.length,
                      (index) => userListWithQty[index]),
                ),
                SizedBox(height: 10,),
                ValueListenableBuilder(
                    valueListenable: buySellSwitch,
                    builder: (ctx, val, _) {
                      return AppButton(
                          onPress: () async {
                            ctrl.placeOrderList.clear();
                            String price = "";
                            if (triggerPriceCtr.value.text.isNotEmpty) {
                              price = triggerPriceCtr.value.text;
                            } else {
                              price = priceCtr.value.text;
                            }

                            for (int i = 0; i < userListWithQty.length; i++) {
                              ctrl.placeOrderList.add(PlaceOrderModel(
                                  clientcode: userListWithQty[i]
                                      .userModel
                                      .clientcode
                                      .toString(),
                                  variety: varityList[varietyNotifier.value],
                                  tradingsymbol: widget.tradingsymbol,
                                  symboltoken: widget.symboleToken,
                                  transactiontype:
                                      buySellSwitch.value ? "BUY" : "SELL",
                                  exchange: widget.exchange,
                                  ordertype:
                                      ordertypeList[ordertypeNotifier.value],
                                  producttype: productTypeList[
                                      productTypeNotifier.value],
                                  duration: "DAY",
                                  price: price,
                                  quantity: userListWithQty[i].qtyCtr.text));
                            }
                            var cleanList = ctrl.placeOrderList
                                .map((e) => e.toJson())
                                .toList();
                            print(jsonEncode(cleanList));
                            ctrl.getPlaceOrdersApi(
                                placeOderList: ctrl.placeOrderList,
                                isBasketOrder: false);
                          },
                          text: "Update Order");
                    }),
                SizedBox(height: 20,)
              ],
            ),
            Obx(
              () => ctrl.isPlaceOrderLoading.value
                  ? Positioned.fill(
                    child: Container(
                        color: Colors.grey.withValues(alpha: 0.3),
                        child: Center(
                          child: AppDialogs.progressWidget(),
                        ),
                      ),
                  )
                  : const SizedBox(),
            ),
          ],
        )));
  }
}

class GetUserListForOrder extends StatelessWidget {
  UserModel userModel;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  TextEditingController priceCtr = TextEditingController(text: "0");

  // String lotSize;
  String qty;
  String price;

  GetUserListForOrder(
      {required this.userModel, required this.qty, required this.price});

  @override
  Widget build(BuildContext context) {
    // lotSizeCtr.text = lotSize;
    qtyCtr.text = qty;
    priceCtr.text = price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text("${userModel.username}"))),
            Expanded(
              child: Center(
                child: RegTxtField(
                  isReadOnly: true,
                  ctr: priceCtr,
                ),
              ),
            ),
            SizedBox(width: 8,),
            // Expanded(
            //   child: Center(
            //     child: RegTxtField(
            //       isReadOnly: true,
            //       ctr: lotSizeCtr,
            //     ),
            //   ),
            // ),
            Expanded(
              child: Center(
                child: RegTxtField(
                  ctr: qtyCtr,
                  onChanged: (val) {
                    // try {
                    //   totalCtr.text =
                    //       ((int.parse(lotSize ?? "0")) * int.parse(val))
                    //           .toString();
                    //
                    //   print(totalCtr.text);
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: RegTxtField(isReadOnly: true, ctr: totalCtr),
            //   ),
            // )
          ],
        ),
        const Divider()
      ],
    );
  }
}
