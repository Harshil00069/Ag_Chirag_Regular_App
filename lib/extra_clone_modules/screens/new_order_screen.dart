import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/extra_clone_modules/controllers/new_dashboard_cantroller.dart';
import 'package:treding/extra_clone_modules/controllers/new_home_controller.dart';
import 'package:treding/model/CheckVersionInfoModel.dart';
import 'package:treding/model/user_model.dart';
import 'package:treding/model/watch_list_model.dart';

import '../../Api/api_implementor.dart';
import 'package:dio/dio.dart' as dio;

class NewOrderScreen extends StatefulWidget {
  WatchListModel watchListModel;
   NewOrderScreen({super.key,required this.watchListModel});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {

  List<String> varityList = ["NORMAL", "STOPLOSS", "AMO"];
  List<String> ordertypeList = [
    "LIMIT",
    "MARKET",
    "STOPLOSS_LIMIT",
    "STOPLOSS_MARKET"
  ];

  List<String> productTypeList = ["CARRYFORWARD","DELIVERY", "INTRADAY"];

  ValueNotifier varietyNotifier = ValueNotifier(0);
  ValueNotifier ordertypeNotifier = ValueNotifier(0);
  ValueNotifier productTypeNotifier = ValueNotifier(0);

  TextEditingController tradingSymbolCtr = TextEditingController();
  TextEditingController tradingExchangeCtr = TextEditingController();

  TextEditingController priceCtr = TextEditingController();
  TextEditingController TriggerPriceCtr = TextEditingController();
  TextEditingController customLotSizeCtr = TextEditingController();
  TextEditingController lotSizeCtr = TextEditingController();

  //True == Buy
  //false == sell
  ValueNotifier buySellSwitch = ValueNotifier(true);

  NewHomepageCtr homepageCtr = Get.find();
  List<GetUserListForOrderss> userListWithQty = [];
  NewDashboardCtr ctrl = Get.put(NewDashboardCtr());

  Timer? timer;


  @override
  @override
  void initState() {
    // TODO: implement initState

    tradingSymbolCtr.text = widget.watchListModel.tradingsymbol ?? "-";
    tradingExchangeCtr.text = widget.watchListModel.exchange ?? "-";

    priceCtr.text = widget.watchListModel.ltp.toString() ?? "-";
    lotSizeCtr.text =  widget.watchListModel.lotsize ?? "0";
    for (var item in homepageCtr.newuserList) {

      userListWithQty.add(GetUserListForOrderss(
        qty: "0",
        userModel: item,
        lotSize: widget.watchListModel.lotsize ?? "0",
      ));
    }

    currentLtp().then((value) {
      timer = Timer.periodic(const Duration(seconds: 7 ), (Timer t){

        currentLtp();
      });
    });
    super.initState();
  }

  Future<void>currentLtp()async {
    num mySharePrice =
    await getSharePrice(
        tradingsymbol: widget.watchListModel.tradingsymbol ?? "",
        symboltoken: widget.watchListModel.symboltoken ?? "",
        exchange: widget.watchListModel.exchange ?? "");


    priceCtr.text = mySharePrice.toString();
  }

  Future<num> getSharePrice(
      {required String exchange,
        required String tradingsymbol,
        required String symboltoken}) async {

    num sharePrice = 0;

    String jwtTocken = "";
    String PrivateKey = "";

    // EasyLoading.show(status: "loaing");

    if (homepageCtr.newuserList == null || homepageCtr.newuserList.isEmpty) {
      print("I am in ");
      Helper().showMessage(title: "Error",message:  "No User Found!\nPlease Add user and Try Later.");
      // EasyLoading.dismiss();
      return 0;
    }

    // for(int i = 0;i<homepageCtr.userList.length;i++){
    //   print("I am in $i");
    //   if (homepageCtr.userList[i].jwtToken != null && homepageCtr.userList[i].jwtToken!.isNotEmpty) {
    //     jwtTocken = homepageCtr.userList[i].jwtToken ?? "";
    //     PrivateKey = homepageCtr.userList[i].privateKey ?? "";
    //     print("I am in Match");
    //     return 0;
    //   }
    // }

    for (var item in homepageCtr.newuserList) {
      print("I am in ");

      if (item.jwtToken != null && item.jwtToken!.isNotEmpty) {
        jwtTocken = item.jwtToken ?? "";
        PrivateKey = item.privateKey ?? "";
        print("I am in Match");
        break;
      }
    }


    if (jwtTocken.isEmpty) {
      Helper().showMessage(title: "Error",message:  "No User Login!\nPlease Login at least One User");
      EasyLoading.dismiss();
      return 0;
    }

    dio.Response? response = await ApiImplementor.getLtpData(
        exchange: exchange,
        symboltoken: symboltoken,
        tradingsymbol: tradingsymbol,
        jwtTkn: jwtTocken,
        PrivateKey: PrivateKey
    );
    // EasyLoading.dismiss();

    if (response != null && response.statusCode == 200) {
      print("Ltp Res " + response.data.toString());
      if (response.data["data"] != null && response.data["data"] != []) {
        CheckVersionInfoModel version =
        CheckVersionInfoModel.fromJson(response.data["data"]);
        sharePrice = version.ltp ?? 0;
      }
    } else {
      Helper().showMessage(title: "Somthing Went Wrong",message:  "Error while fetching Data");
    }
    return sharePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.purple,
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
                            SizedBox(width: Get.width*0.25,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter LotSize",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    RegTxtField(
                        ctr: customLotSizeCtr,
                        onChanged: (value){
                          int  size =0;
                          if(customLotSizeCtr.text.isNotEmpty){
                            int  usersize =0;
                            size  = int.parse(value);
                            int userlot =  int.parse(homepageCtr.newuserList.first.userLotSize.toString());
                            // usersize = (size / userlot).floor();
                            usersize = size;

                            print("usersize=> ${usersize}");

                            /*        for (var item in homepageCtr.newuserList) {

                                    int lot  = int.parse(item.userLotSize.toString());
                                    int val = lot * usersize;
                                    print("Val=> ${val}");

                                    userListWithQty.add(GetUserListForOrderss(
                                      qty: "8",
                                      userModel: item,
                                      lotSize: widget.watchListModel.lotsize ?? "0",
                                    ));
                                  }*/

                            for(int k=0;k<homepageCtr.newuserList.length;k++){
                              int lot  = int.parse(homepageCtr.newuserList[k].userLotSize.toString());
                              int val = lot * usersize;
                              print("Val=> ${val}");
                              setState(() {
                                userListWithQty[k].qtyCtr.text = val.toString();

                                userListWithQty[k].totalCtr.text = ((int.parse( widget.watchListModel.lotsize ?? "0")) * int.parse(val.toString())).toString();

                              });
                            }

                          }else{

                            for(int k=0;k<homepageCtr.newuserList.length;k++){
                              int lot  = int.parse(homepageCtr.newuserList[k].userLotSize.toString());
                              int val = lot * 0;
                              print("Val=> ${val}");
                              setState(() {
                                userListWithQty[k].qtyCtr.text = val.toString();

                                userListWithQty[k].totalCtr.text = ((int.parse( widget.watchListModel.lotsize ?? "0")) * int.parse(val.toString())).toString();

                              });
                            }
                          }


                        },
                        hintTxt: "Enter Lot size",
                        keyboardType: TextInputType.number),
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
                                  print("Place new=> ${responce.data}");

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
class GetUserListForOrderss extends StatelessWidget {
  UserModel userModel;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  String lotSize;
  String qty;


  GetUserListForOrderss({required this.userModel, required this.lotSize,required this.qty});

  @override
  Widget build(BuildContext context) {
    lotSizeCtr.text = lotSize;
    qtyCtr.text = qty;
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