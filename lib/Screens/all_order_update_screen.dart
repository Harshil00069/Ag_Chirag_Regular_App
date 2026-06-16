import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/model/order_list_model.dart';
import 'package:treding/model/user_model.dart';

import '../Api/api_implementor.dart';
import '../Controllers/dashboard_controller.dart';
import '../Utils/helper.dart';
import '../Utils/material_color_generator.dart';
import '../custom_widgets/app_burron.dart';
import '../custom_widgets/app_text_field.dart';
import 'package:dio/dio.dart' as dio;

import 'my_order.dart';

class AllOrderUpdateScreen extends StatefulWidget {

  final String tradingsymbol;
  final String exchange;
  final String ltp;
  final String lotSize;
  final int  productType;
  final int  variety;
  final int  orderType;
  final String  symboleToken;
  final String  transactionType;
   const AllOrderUpdateScreen({super.key, required this.tradingsymbol, required this.exchange, required this.ltp, required this.lotSize, required this.productType, required this.variety, required this.symboleToken, required this.allOrderList, required this.orderType, required this.transactionType});
  final List<OrderListModel> allOrderList;
  @override
  State<AllOrderUpdateScreen> createState() => _AllOrderUpdateScreenState();
}

class _AllOrderUpdateScreenState extends State<AllOrderUpdateScreen> {

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
  TextEditingController lotSizeCtr = TextEditingController();

  // HomepageCtr homepageCtr = Get.find();
  List<GetUserListForOrder> userListWithQty = [];

  // DashboardCtr ctrl = Get.put(DashboardCtr());

  final DashboardCtr ctrl = Get.isRegistered<DashboardCtr>()
      ? Get.find<DashboardCtr>()
      : Get.put(DashboardCtr());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tradingSymbolCtr.text = widget.tradingsymbol ?? "-";
    tradingExchangeCtr.text = widget.exchange ?? "-";

    priceCtr.text = widget.ltp.toString() ?? "-";
    triggerPriceCtr.text = widget.ltp.toString() ?? "-";
    varietyNotifier.value = widget.variety;
    productTypeNotifier.value = widget.productType;
    lotSizeCtr.text = widget.lotSize.toString() ?? "-";

/*    for (var item in widget.allOrderList) {
      userListWithQty.add(GetUserListForOrder(
        userModel: item,
        lotSize: widget.lotSize,
        qty: item.quantity,
      ));

    }*/
    if(widget.transactionType == "BUY"){

      buySellSwitch.value = true;
    }
    else{
      buySellSwitch.value = false;
    }


  for(int i=0;i< widget.allOrderList.length;i++){

    int qty  = int.parse(widget.allOrderList[i].quantity.toString());
    int lot  = int.parse(widget.lotSize);

    int kk = (qty / lot).floor();
    int tt = (kk * lot).floor();

    print("11=> ${qty} == ${lot} ");

    userListWithQty.add(GetUserListForOrder(total: tt.toString(),
      price: widget.allOrderList[i].price.toString(),
      userModel: widget.allOrderList[i].userModel!,
      lotSize: widget.lotSize,
      qty: kk.toString(),
    ));
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:  Text("Bulk Order Update",style:  Font.bodyText1(),),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.primaryColor,),
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Text(
                              "Lot Size",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(width: Get.width*0.30,
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
                              ctr: triggerPriceCtr,
                              hintTxt: "Enter Amount",
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

           /*   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Trading Symbol",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: RegTxtField(
                          isReadOnly: true,
                          ctr: tradingSymbolCtr,
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 200,
                        child: RegTxtField(
                          isReadOnly: true,
                          ctr: tradingExchangeCtr,
                        ),
                      )
                    ],
                  ),
                ],
              ),*/
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
                  // Expanded(child: Center(child: Text("Price"))),
                  // Expanded(child: Center(child: Text("Lot Size"))),
                  Expanded(child: Center(child: Text("qty"))),
                  Expanded(child: Center(child: Text("Total"))),
                ],
              ),
              const Divider(),
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
                          for (int i = 0; i < widget.allOrderList.length; i++) {
                            if (int.parse(userListWithQty[i].qtyCtr.value.text) > 0) {
                              var data = {
                                "variety": varityList[varietyNotifier.value],
                                "orderid": widget.allOrderList[i].orderid,
                                "ordertype": ordertypeList[ordertypeNotifier.value],
                                "producttype": productTypeList[productTypeNotifier.value],
                                "duration": "DAY",
                                "price": price,
                                "quantity": userListWithQty[i].totalCtr.text,
                                "tradingsymbol": widget.tradingsymbol,
                                "symboltoken": widget.symboleToken,
                                "exchange": widget.exchange,

                              };
                              print("name :- ${userListWithQty[i].userModel.toJson()} => \n""$data");

                              try {
                                EasyLoading.show();
                                dio.Response? responce =
                                await ApiImplementor.singleOrderUpdateApiImplementer(
                                    PrivateKey:
                                    '${userListWithQty[i].userModel.privateKey}',
                                    data: data,
                                    token: '${userListWithQty[i].userModel.jwtToken}');
                                EasyLoading.dismiss();

                                if (responce != null && responce.data['data'] != null) {
                                  print(responce.data);
                                  Helper().showMessage(
                                      message:
                                      "Order Update for ${userListWithQty[i].userModel.username}");

                                }else{
                                  Helper().showMessage(
                                      message: "${ responce!.data["message"]}");
                                }
                              } catch (e) {
                                print("${e}");
                              }
                            }
                          }
                          Navigator.of(context).pop(true);
                          // Get.back();
                          ctrl.controller.animateTo(3);
                          print("/-*/-*/-*/-*/-*/-*/-*/  ORDER Update END */-*-*/-*/*-/-*/-*/-*/-*");
                        },
                        text: "Update Order");
                  }),

              // ListView.builder(
              //
              //     itemCount: userListWithQty.length,
              //     itemBuilder: (ctx, index) {
              //       return userListWithQty[index];
              //     })
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
  TextEditingController priceCtr = TextEditingController(text: "0");
  String lotSize;
  String qty;
  String price;
  String total;

  GetUserListForOrder({required this.userModel, required this.lotSize,required this.qty,required this.price,required this.total});

  @override
  Widget build(BuildContext context) {
    // lotSizeCtr.text = lotSize;
    qtyCtr.text = qty;
    priceCtr.text = price;
    totalCtr.text = total;
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
            // Expanded(
            //   child: Center(
            //     child: RegTxtField(isReadOnly: true,
            //       ctr: priceCtr,
            //     ),
            //   ),
            // ),

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