import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/model/basket_order_model.dart';
import 'package:treding/model/watch_list_model.dart';

import '../Api/api_implementor.dart';
import '../Controllers/dashboard_controller.dart';
import '../Controllers/homepage_controller.dart';
import '../Controllers/order_controller.dart';
import '../Utils/helper.dart';
import '../custom_widgets/app_burron.dart';
import '../model/user_model.dart';
import 'dash_board.dart';
import 'my_order.dart';
import 'package:dio/dio.dart' as dio;
import 'order_screen.dart';

class BasketOrderScreen extends StatefulWidget {
  WatchListModel watchListModel;
  BasketOrderScreen({required this.watchListModel});

  @override
  State<BasketOrderScreen> createState() => _BasketOrderScreenState();
}

class _BasketOrderScreenState extends State<BasketOrderScreen> {

  // OrderController orderController = Get.put(OrderController());
  final ScrollController controller = ScrollController();

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
  TextEditingController TriggerPriceCtr = TextEditingController();

  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");

  //True == Buy
  //false == sell
  ValueNotifier buySellSwitch = ValueNotifier(true);

  HomepageCtr homepageCtr = Get.find();
  List<GetUserListForOrder> userListWithQty = [];
  List<BasketListModel> basketList = [];
  List<BasketListModel> basketList2 = [];
  DashboardCtr ctrl = Get.find();

  @override
  void initState() {
    // TODO: implement initState

    tradingSymbolCtr.text = widget.watchListModel.tradingsymbol ?? "-";
    tradingExchangeCtr.text = widget.watchListModel.exchange ?? "-";

    priceCtr.text = widget.watchListModel.ltp.toString() ?? "-";

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

    return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 30,
                  spacing: 30,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          const Text(
                            "Select Variety",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder(
                              valueListenable: varietyNotifier,
                              builder: (ctx, val, _) {
                                return Wrap(
                                  children: List.generate(
                                      varityList.length,
                                          (index) => Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: ChoiceChip(
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
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          const Text(
                            "Select Order Type",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder(
                              valueListenable: ordertypeNotifier,
                              builder: (ctx, val, _) {
                                return Wrap(
                                  children: List.generate(
                                      ordertypeList.length,
                                          (index) => Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: ChoiceChip(
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          const Text(
                            "Select Product Type",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder(
                              valueListenable: productTypeNotifier,
                              builder: (ctx, val, _) {
                                return Wrap(
                                  children: List.generate(
                                      productTypeList.length,
                                          (index) => Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: ChoiceChip(
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
                  ],
                ),
                const SizedBox(height: 30),
               /*  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Trading Symbol",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Text("${widget.watchListModel.tradingsymbol}"),
                         Text("${widget.watchListModel.exchange}"),

                      *//*   SizedBox(height: 200,
                           child: TextFormField(
                             decoration: const InputDecoration(
                                 enabled: true,
                                 border: InputBorder.none,),
                             keyboardType: TextInputType.text,
                             autofocus: false,
                             enabled: true,
                             controller: tradingSymbolCtr,
                           ).paddingOnly(left: 10),
                         )*//*

                    *//*     SizedBox(width: 150,
                           child: RegTxtField(
                             isReadOnly: true,
                             ctr: tradingSymbolCtr,
                           ),
                         ),
                        SizedBox(width: 30),
                        Container(
                          child: RegTxtField(
                            isReadOnly: true,
                            ctr: tradingExchangeCtr,
                          ),
                        )*//*
                      ],
                    ),
                  ],
                ),*/

                Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Trading Symbol",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        RegTxtField(
                          isReadOnly: true,
                          ctr: tradingSymbolCtr,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Exchange",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        RegTxtField(
                          isReadOnly: true,
                          ctr: tradingExchangeCtr,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Price",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        RegTxtField(
                          isReadOnly: true,
                          ctr: priceCtr,
                        ),
                      ],
                    ),
                  ),
                ],),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Enter Amount"),
                          RegTxtField(
                              ctr: TriggerPriceCtr,
                              hintTxt: "Enter Amount",
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Enter lot"),
                          RegTxtField(
                            ctr: qtyCtr,
                            onChanged: (val) {
                              try {
                                totalCtr.text =
                                    ((int.parse(widget.watchListModel.lotsize ?? "0")) * int.parse(val))
                                        .toString();

                                print(totalCtr.text);
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total lot"),
                          RegTxtField(isReadOnly: true, ctr: totalCtr),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: buySellSwitch,
                        builder: (ctx, val, _) {
                          return Row(
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
                  ],
                ),

                const SizedBox(height: 30),
                Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  AppButton(
                    text: "Add To Bucket",
                    onPress: () {
                      setState(() {
                        basketList.add(BasketListModel(lotsize: totalCtr.text,tradingsymbol: tradingSymbolCtr.text,oderType: buySellSwitch.value ? "BUY" : "SELL",price: TriggerPriceCtr.text));
                        basketList.sort((a, b) => b.oderType
                        !.compareTo(a.oderType!));
                        print("LLeee=> ${basketList.length}");
                      });
                    },
                  ),

                  AppButton(
                      onPress: () async {
                        print(
                            "/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*-*/-*/*-/-*/-*/-*/-*\n\n");

                        String price = "";
                        if (TriggerPriceCtr.value.text.isNotEmpty) {
                          price = TriggerPriceCtr.value.text;
                        } else {
                          price = priceCtr.value.text;
                        }

                        for (int i = 0; i <  homepageCtr.userList.length; i++) {

                          if( homepageCtr.userList[i].ischecked){
                            for(int j=0;j<basketList.length;j++){

                              print("OrderType :${basketList[j].oderType}");
                              print("price ${basketList[j].price}");

                              var data = {
                                "variety": varityList[varietyNotifier.value],
                                "tradingsymbol": "${widget.watchListModel.tradingsymbol}",
                                "symboltoken": "${widget.watchListModel.symboltoken}",
                                "transactiontype": basketList[j].oderType,
                                "exchange": "${widget.watchListModel.exchange}",
                                "ordertype": ordertypeList[ordertypeNotifier.value],
                                "producttype": productTypeList[productTypeNotifier.value],
                                "duration": "DAY",
                                "price": basketList[j].price,
                                "squareoff": "0",
                                "stoploss": "0",
                                "quantity": basketList[j].lotsize
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

                                if (responce != null &&
                                    responce.data != null &&
                                    responce.statusCode == 200) {
                                  print(responce.data);
                                  Helper().showMessage(
                                      message:
                                      "Order Placed for ${userListWithQty[i].userModel.username}");
                                }
                              } catch (e) {
                                print("${e}");
                              }
                            }
                          }


                          /*    if (int.parse(userListWithQty[i].qtyCtr.value.text) > 0) {

                              }*/
                        }
                       // ctrl.animated();
                        // DefaultTabController.of(context).animateTo(4);

                        Get.to(() => const MyOrder());
                        print(
                            "/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-*-*/-*/*-/-*/-*/-*/-*");
                      },
                      text: "Confirm Order")
                ],),



                Row(children: [
                  SizedBox(width: Get.width*0.40,child: SizedBox(height: Get.height/2,
                    child: ListView.builder(itemCount: homepageCtr.userList.length,itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //color of shadow
                                spreadRadius: 1,
                                blurRadius: 5,
                                // blur radius
                                offset: const Offset(
                                    1, 2), // changes position of shadow
                              )
                            ],
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                                    Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(homepageCtr.userList[index].username.toString()),
                      FlutterSwitch( height: 28,
                        width: 50,
                        padding: 4.0,
                        value:  homepageCtr.userList[index].ischecked, onToggle: (bool value) {
                          print("Index=> ${index}");
                          setState(() {
                            homepageCtr.userList[index].ischecked = value;
                            // isSwitched =  demolist[index].ischecked;
                          });
                        },)

                    ],),
                ),
                            ],),
                        ),
                      );
                    },),
                  ),),
                  SizedBox(width: Get.width/2,child: SizedBox(height: Get.height/2,
                    child: ListView.builder(itemCount: basketList.length,itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    // blur radius
                                    offset: const Offset(
                                        1, 2), // changes position of shadow
                                  )
                                ],
                              ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text("${basketList[index].tradingsymbol}"),
                              InkWell(onTap: (){
                               setState(() {
                                 basketList.removeAt(index);
                               });
                              },child: const Icon(Icons.delete))
                              ],),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text("Oder Price : ${basketList[index].price}"),
                                Text("${basketList[index].oderType}",style: TextStyle(color: basketList[index].oderType =="BUY"?Colors.green:Colors.red),),
                              ],),
                            ),
                              Text("Lot Size : ${basketList[index].lotsize}"),
                          ],),
                        ),
                      );
                    },),
                  ),)
                ],),



                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(child: Center(child: Text("Client Name"))),
                //     Expanded(child: Center(child: Text("Net"))),
                //     Expanded(child: Center(child: Text("Lot Size"))),
                //     Expanded(child: Center(child: Text("qty"))),
                //     Expanded(child: Center(child: Text("Total"))),
                //   ],
                // ),
                // Divider(),
                // Column(
                //   children: List.generate(
                //       userListWithQty.length, (index) => userListWithQty[index]),
                // ),




              ],
            ),
          ),
        ));
  }
}
class GetUserListForOrder extends StatelessWidget {
  UserModel userModel;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  String lotSize;

  GetUserListForOrder({required this.userModel, required this.lotSize});

  @override
  Widget build(BuildContext context) {
    lotSizeCtr.text = lotSize;
    print("My Lot size :- ${lotSize}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text("${userModel.username}"))),
            Expanded(
                child: Center(child: Text("${userModel.currentBalance ?? 0}"))),
            Expanded(
              child: Center(
                child: RegTxtField(
                  isReadOnly: true,
                  ctr: lotSizeCtr,
                ),
              ),
            ),
            Expanded(
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
            Expanded(
              child: Center(
                child: RegTxtField(isReadOnly: true, ctr: totalCtr),
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
