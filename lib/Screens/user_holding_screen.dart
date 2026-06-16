import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Controllers/position_controller.dart';
import 'package:treding/model/all_position_model.dart';

import '../Controllers/homepage_controller.dart';
import '../Utils/app_font.dart';
import '../Utils/color_const.dart';
import '../Utils/material_color_generator.dart';
import 'holding_sell_screen.dart';

class UserHoldingScreen extends StatefulWidget {
  final String privatekey;
  final int index;
  const UserHoldingScreen({super.key,  required this.privatekey, required this.index});

  @override
  State<UserHoldingScreen> createState() => _UserHoldingScreenState();
}

class _UserHoldingScreenState extends State<UserHoldingScreen> {
  HomepageCtr homepageCtr = Get.put(HomepageCtr());

  final PositionController ctrl = Get.isRegistered<PositionController>()
      ? Get.find<PositionController>()
      : Get.put(PositionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homepageCtr.getUserHoldingsData(i: widget.index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( backgroundColor: AppColor.primaryColor,iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
        title:  Text("All Holdings",
          style: Font.bodyText1(),)),
        body: Obx(()=> homepageCtr.isholdingloading.value ? const Center(child: CircularProgressIndicator()) :
    homepageCtr.holdingScreenList.isEmpty? const Center(child: Text("No Holding available")):
    SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10 ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
      
                Container(padding: const EdgeInsets.only(left: 8,bottom: 5,right: 8),
                  width: Get.width*0.45,
                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(children: [
                    const Text("Investment amount",style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10,),
                    Text(homepageCtr.totalholdings!.totalinvvalue.toString(),style: TextStyle(fontSize: 18)),
                  ],),
                ),
                Container(padding: const EdgeInsets.only(left: 8,bottom: 5,right: 8),
                  width: Get.width*0.35,
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
                  child: Column(children: [
                    const Text("Market Value",style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10,),
                    Text(homepageCtr.totalholdings!.totalholdingvalue.toString(),style: const TextStyle(fontSize: 18)),
                  ],),
                ),
              ]),
        ),
        Padding(padding: const EdgeInsets.only(top: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(padding: const EdgeInsets.only(left: 8,bottom: 5,right: 8),
              width: Get.width*0.45,
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
              child: Column(children: [
                const Text("Overall gain",style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10,),
                Text(homepageCtr.totalholdings!.totalprofitandloss.toString(),style: const TextStyle(fontSize: 18)),
              ],),
            ),
            Container(padding: const EdgeInsets.only(left: 8,bottom: 5,right: 8),
              width: Get.width*0.35,
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
              child: Column(children: [
                const Text("Today's gain",style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10,),
                Text(homepageCtr.totalholdings!.totalpnlpercentage.toString(),style: const TextStyle(fontSize: 18)),
              ],),
            ),
          ],),
        ),
      
        GetBuilder(
            init: homepageCtr,
            builder: (ctr) {
              return SizedBox(height: Get.height*0.68,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homepageCtr.holdingScreenList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8,left: 8),
                        child: Container(padding:
                        const EdgeInsets.only(left: 8),
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
                          child: Column(
                            children: [
                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                Row(
                                  children: [
                                    const Column(children: [
                                      Text("Stock :  ",style: TextStyle(fontSize: 18)),
                                      Text("Qty     :  ",style: TextStyle(fontSize: 18)),
                                      Text("LTP    :  ",style: TextStyle(fontSize: 18)),
                                      Text("ATP   :  ",style: TextStyle(fontSize: 18)),
                                    ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${homepageCtr.holdingScreenList[index].tradingsymbol}",style: const TextStyle(fontSize: 16)),
                                        Text("${homepageCtr.holdingScreenList[index].quantity}",style: const TextStyle(fontSize: 16)),
                                        Text("${homepageCtr.holdingScreenList[index].ltp}",style: const TextStyle(fontSize: 16)),
                                        Text("${homepageCtr.holdingScreenList[index].averageprice}",style: const TextStyle(fontSize: 16))
                                      ],),

                                ],),
                                   Padding(
                                     padding: const EdgeInsets.only(right: 12.0),
                                     child: TextButton(
                                         style: ButtonStyle(
                                             shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                 side: const BorderSide(
                                                   color: Colors.red, // your color here
                                                   width: 1,
                                                 ),
                                                 borderRadius: BorderRadius.circular(10)))),
                                         onPressed: () {
                                           ctrl.commonOrderList2.clear();
                                           // String symbole = ctrl.positionList[index].tradingsymbol.toString();
                                           print("index=> ${index}");

                                           for(int i=0; i< homepageCtr.holdingScreenList.length;i++){
                                             if(index == i){
                                               ctrl.commonOrderList2.add(Position(
                                                   tradingsymbol: homepageCtr.holdingScreenList[i].tradingsymbol,
                                                   exchange: homepageCtr.holdingScreenList[i].exchange,
                                                   symboltoken: homepageCtr.holdingScreenList[i].symboltoken,
                                                   userModel: homepageCtr.holdingScreenList[i].userModel,
                                                   netprice: homepageCtr.holdingScreenList[i].ltp.toString(),
                                                   netqty: selectedQty(index: i)
                                               ));
                                             }
                                             print("LLKK=> ${ctrl.commonOrderList2.length} ${i}");
                                           }

                                           Get.to( HoldingSellScreen(netqty: int.parse(homepageCtr.holdingScreenList[index].quantity.toString()),
                                             username:  homepageCtr.userList[widget.index].username ?? "",
                                             privateKey: homepageCtr.userList[widget.index].privateKey ?? "",
                                             jwtToken: homepageCtr.userList[widget.index].jwtToken ?? "",
                                             positionList:  ctrl.commonOrderList2,
                                             exchange: homepageCtr.holdingScreenList[index].exchange.toString(),
                                             ltp: homepageCtr.holdingScreenList[index].ltp.toString(),
                                             symboleToken: homepageCtr.holdingScreenList[index].symboltoken.toString(),
                                             tradingsymbol: homepageCtr.holdingScreenList[index].tradingsymbol.toString(),
                                             productType: selectedVariety(index: index),));
                                         },
                                         child: const Text(
                                           "Sell Holding",
                                           style: TextStyle(color: Colors.red),
                                         )),
                                   ),
                              ],),


                              // Row(children: [
                              //   const Text("Stock :  ",style: TextStyle(fontSize: 18)),
                              //   Text("${homepageCtr.holdings[index].tradingsymbol}",style: const TextStyle(fontSize: 16))
                              // ],),
                              // Row(children: [
                              //   const Text("Qty     :  ",style: TextStyle(fontSize: 18)),
                              //   Text("${homepageCtr.holdings[index].quantity}",style: const TextStyle(fontSize: 16))
                              // ],),
                              // Row(children: [
                              //   const Text("LTP    :  ",style: TextStyle(fontSize: 18)),
                              //   Text("${homepageCtr.holdings[index].ltp}",style: const TextStyle(fontSize: 16))
                              // ],),
                              // Row(children: [
                              //   const Text("ATP   :  ",style: TextStyle(fontSize: 18)),
                              //   Text("${homepageCtr.holdings[index].averageprice}",style: const TextStyle(fontSize: 16))
                              // ],),

                            ],),),
                      );
                    }),
              );
            })





      /*      Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(height: 50,color: Colors.grey.shade200,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeadingText("stock Name",200),
                HeadingText("Qty",100),
                HeadingText("LTP",100),
                HeadingText("ATP",100),
              ],),),
        ),
        GetBuilder(
            init: homepageCtr,
            builder: (ctr) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: homepageCtr.holdings.length,
                  itemBuilder: (ctx, index) {
      
                    //  homepageCtr.GetSingleUserData(index);
      
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 50,
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
                        child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 200,
                                child: Center(child: Text("${homepageCtr.holdings[index].tradingsymbol}"))),
                            SizedBox(width: 100,
                                child: Center(child: Text("${homepageCtr.holdings[index].quantity}"))),
                            SizedBox(width: 100,
                                child: Center(child: Text("${homepageCtr.holdings[index].ltp}"))),
                            SizedBox(width: 100,
                                child: Center(child: Text("${homepageCtr.holdings[index].averageprice}"))),
      
      
                          ],),),
                    );
                  });
            }),*/
      
      
      ]),
    ),));
  }

  String selectedQty({required int index}){

    int qty = int.parse(homepageCtr.holdingScreenList[index].quantity.toString());
    String a="";
    if( qty<0){
      int val = qty*-1;
      a = val.toString();
    }
    else{
      a= qty.toString();
    }
    return a;
  }

  int selectedVariety({required int index}){
    int a=0;
    if(homepageCtr.holdingScreenList[index].product == "DELIVERY"){
      a =2;
    }else if(homepageCtr.holdingScreenList[index].product == "CARRYFORWARD"){
      a=1;
    }else{
      a=0;
    }
    return a;
  }

  HeadingText(String ordertype, double width) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      width: width,
      child: Center(
        child: Text(
          ordertype,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
