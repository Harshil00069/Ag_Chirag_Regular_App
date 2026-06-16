import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/model/all_position_model.dart';
import 'package:treding/model/user_model.dart';
import 'package:dio/dio.dart' as dio;
import 'all_order_update_screen.dart';

class HoldingSellScreen extends StatefulWidget {
  final String tradingsymbol;
  final String exchange;
  final String ltp;
  final int  productType;
  final int  netqty;
  final String  symboleToken;
  final String  username;
  final String  jwtToken;
  final String  privateKey;
  const HoldingSellScreen({super.key,required this.tradingsymbol, required this.exchange, required this.ltp, required this.productType, required this.netqty, required this.symboleToken, required this.positionList, required this.username, required this.jwtToken, required this.privateKey});
  final  List<Position> positionList;

  @override
  State<HoldingSellScreen> createState() => _HoldingSellScreenState();
}

class _HoldingSellScreenState extends State<HoldingSellScreen> {

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
  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    tradingSymbolCtr.text = widget.tradingsymbol ?? "-";
    tradingExchangeCtr.text = widget.exchange ?? "-";

    priceCtr.text = widget.ltp.toString() ?? "-";
    triggerPriceCtr.text = widget.ltp.toString() ?? "-";
    productTypeNotifier.value = widget.productType;


    for(int i=0;i< widget.positionList.length;i++){
      userListWithQty.add(GetUserListForOrder(username: widget.username,
        jwtToken: widget.jwtToken ,
        privateKey: widget.privateKey,
        price: widget.positionList[i].netprice.toString(),
        qty: widget.positionList[i].netqty.toString(),
      ));
    }


    if(widget.netqty <0){
      buySellSwitch.value = true;
    }
    else{
      buySellSwitch.value = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.primaryColor,
      title: Text('Sell Old Holdings', style: Font.bodyText1(),),
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
/*
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
                        )*/

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
                  Expanded(child: Center(child: Text("price"))),
                  Expanded(child: Center(child: Text("qty"))),
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
                              "/-*/-*/-*/-*/-*/-*/-*  ORDER Update Start  -*-*/-*/*-/-*/-*/-*/-*\n\n");

                          String price = "";
                          if (triggerPriceCtr.value.text.isNotEmpty) {
                            price = triggerPriceCtr.value.text;
                          } else {
                            price = priceCtr.value.text;
                          }
                          for (int i = 0; i < widget.positionList.length; i++) {
                            if (int.parse(userListWithQty[i].qtyCtr.value.text) > 0) {
                              var data = {
                                "variety": varityList[varietyNotifier.value],
                                "tradingsymbol": widget.tradingsymbol,
                                "symboltoken": widget.symboleToken,
                                "transactiontype": buySellSwitch.value == false ? "SELL":"BUY",
                                "exchange": widget.exchange,
                                "ordertype": ordertypeList[ordertypeNotifier.value],
                                "producttype": productTypeList[productTypeNotifier.value],
                                "duration": "DAY",
                                "price": price,
                                "quantity": userListWithQty[i].qtyCtr.text,
                                "squareoff": "0",
                                "stoploss": "0",
                              };
                              // print("name :- ${userListWithQty[i].userModel.toJson()} => \n""$data");

                              try {
                                EasyLoading.show();
                                dio.Response? responce =
                                await ApiImplementor.placeOrderApiImplementer(
                                    PrivateKey:
                                    '${userListWithQty[i].privateKey}',
                                    data: data,
                                    token: '${userListWithQty[i].jwtToken}');
                                EasyLoading.dismiss();

                                if (responce != null &&
                                    responce.data['data'] != null) {
                                  print(responce.data);
                                  Helper().showMessage(
                                      message:
                                      "Order Update for ${userListWithQty[i].username}");

                                }else{
                                  Helper().showMessage(
                                      message: "${ responce!.data["message"]}");
                                }
                              } catch (e) {

                                print("${e}");
                              }
                            }
                          }
                          Get.back();

                          print("/-*/-*/-*/-*/-*/-*/-*/  ORDER Update END */-*-*/-*/*-/-*/-*/-*/-*");
                        },
                        text: "SELL");
                  }),

            ],
          ),
        ));
  }
}

class GetUserListForOrder extends StatelessWidget {
  // UserModel userModel;
  // TextEditingController qtyCtr = TextEditingController(text: "0");
  // // TextEditingController lotSizeCtr = TextEditingController(text: "0");
  // TextEditingController totalCtr = TextEditingController(text: "0");
  // String lotSize;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  TextEditingController priceCtr = TextEditingController(text: "0");
  // String lotSize;
  String qty;
  String price;
  String username;
  String privateKey;
  String jwtToken;

  GetUserListForOrder({super.key, required this.username,required this.qty,required this.price , required this.jwtToken, required this.privateKey});

  @override
  Widget build(BuildContext context) {
    qtyCtr.text = qty;
    priceCtr.text = price;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text(username))),
            // Expanded(
            //     child: Center(child: Text("${userModel.currentBalance ?? 0}"))),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(width: Get.width*0.30,
                child: Center(
                  child: RegTxtField(
                    ctr: qtyCtr,
                    onChanged: (val) {
              /*        try {
                        totalCtr.text =
                            ((int.parse(lotSize ?? "0")) * int.parse(val))
                                .toString();

                        print(totalCtr.text);
                      } catch (e) {
                        print(e);
                      }*/
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(width: Get.width*0.30,
                child: Center(
                  child: RegTxtField(
                    ctr: priceCtr,
                    onChanged: (val) {
              /*        try {
                        totalCtr.text =
                            ((int.parse(lotSize ?? "0")) * int.parse(val))
                                .toString();

                        print(totalCtr.text);
                      } catch (e) {
                        print(e);
                      }*/
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
        const Divider()
      ],
    );
  }
}
