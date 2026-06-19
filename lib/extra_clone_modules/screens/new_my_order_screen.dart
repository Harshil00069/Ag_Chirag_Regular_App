// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:treding/Screens/all_order_update_screen.dart';
// import 'package:treding/Screens/order_update_screen.dart';
// import 'package:treding/Utils/app_font.dart';
// import 'package:treding/Utils/helper.dart';
// import 'package:treding/Utils/material_color_generator.dart';
// import 'package:treding/extra_clone_modules/controllers/new_order_controller.dart';
// import 'package:treding/model/order_list_model.dart';
//
// import '../../Api/api_implementor.dart';
// import 'package:dio/dio.dart' as dio;
//
// class NewMyOrderScreen extends StatefulWidget {
//
//   const NewMyOrderScreen({super.key});
//
//   @override
//   State<NewMyOrderScreen> createState() => _NewMyOrderScreenState();
// }
//
// class _NewMyOrderScreenState extends State<NewMyOrderScreen> {
//
//   NewOrderController orderController = Get.put(NewOrderController());
//   final ScrollController controller = ScrollController();
//
//   @override
//   void initState() {
//     print("init==> ");
//     // TODO: implement initState
//     orderController.getOrderList();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
//       iconTheme: const IconThemeData(
//         color: Colors.white,
//       ),
//       backgroundColor: AppColor.purple,
//       title: Text('My Orders', style: Font.bodyText1(),),
//     ),
//       body: RefreshIndicator(onRefresh: ()async{
//         await orderController.getOrderList();
//       },
//         child: Obx(() =>
//         orderController.isDataLoading.value ? const Align(alignment: Alignment.center,
//             child: CircularProgressIndicator()) :
//         orderController.orderList.isNotEmpty ? ListView.builder(
//             itemCount: orderController.orderList.length,
//             itemBuilder: (ctx, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(
//                     left: 8.0, right: 8.0, bottom: 4.0),
//                 child: Container(margin: const EdgeInsets.only(top: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         //color of shadow
//                         spreadRadius: 0.5,
//                         blurRadius: 5,
//                         // blur radius
//                         // offset: const Offset(
//                         //     1, 2), // changes position of shadow
//                       )
//                     ],
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 15, vertical: 5),
//                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//
//                           TextButton(
//                               style: ButtonStyle(
//                                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                         color: Colors.red, // your color here
//                                         width: 1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10)))),
//                               onPressed: () async {
//                                 orderController.commonOrderList.clear();
//                                 String symbole = orderController.orderList[index].tradingsymbol.toString();
//                                 String status = orderController.orderList[index].status.toString();
//
//                                 if(status =="rejected" || status == "cancelled after market order" || status == "cancelled" || status =="complete"){
//
//                                   Helper().showMessage(message: "Please Check Status...");
//                                 }else{
//
//                                   for(int i=0; i< orderController.orderList.length;i++){
//                                     if(symbole == orderController.orderList[i].tradingsymbol){
//                                       if(orderController.orderList[i].status.toString() == "complete"|| orderController.orderList[i].status.toString() == "rejected" || orderController.orderList[i].status.toString() == "cancelled after market order"){
//
//
//                                       }else{
//                                         orderController.commonOrderList.add(OrderListModel(unicID: 0,
//                                           quantity: orderController.orderList[i].quantity,
//                                           userModel: orderController.orderList[i].userModel,
//                                           price: orderController.orderList[i].price,
//                                           orderid: orderController.orderList[i].orderid,
//                                         ));
//                                       }
//                                     }
//
//                                   }
//                                   print("Lee=> ${  orderController.commonOrderList.length}");
//
//                                   var come =  await   Get.to( AllOrderUpdateScreen(transactionType: orderController.orderList[index].transactiontype.toString(),
//                                     allOrderList: orderController.commonOrderList,orderType: 0,
//                                     symboleToken: orderController.orderList[index].symboltoken.toString(),
//                                     productType: selectedProductType(index: index),
//                                     variety:  selectedVariety(index: index),
//                                     lotSize: orderController.orderList[index].lotsize.toString(),
//                                     tradingsymbol: orderController.orderList[index].tradingsymbol.toString(),
//                                     ltp: orderController.orderList[index].price.toString(),
//                                     exchange: orderController.orderList[index].exchange.toString(),));
//
//
//                                   if(come != null){
//                                     orderController.getOrderList();
//                                   }
//                                 }
//
//
//                               },
//                               child: const Text(
//                                 "Bulk Edit",
//                                 style: TextStyle(color: Colors.red),
//                               )),
//                           TextButton.icon(
//                             style: ButtonStyle(
//                                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                       color: Colors.red, // your color here
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10)))),
//                             icon: const Icon(Icons.edit),label: const Text("Edit"),
//                             onPressed: () async {
//                               String status = orderController.orderList[index].status.toString();
//                               if(status =="rejected" || status == "cancelled after market order" || status == "cancelled" || status == "complete"){
//
//                                 Helper().showMessage(message: "Please Check Status....");
//                               }else{
//                                 var come =  await Get.to( OrderUpdateScreen(isRatioOrder: true,
//                                   symboleToken: orderController.orderList[index].symboltoken.toString(),
//                                   orderid: orderController.orderList[index].orderid.toString(),
//                                   productType: orderController.orderList[index].producttype.toString(),
//                                   userName: orderController.orderList[index].userModel!.username.toString(),
//                                   variety:  selectedVariety(index: index),
//                                   lotSize: orderController.orderList[index].lotsize.toString(),
//                                   qty: orderController.orderList[index].quantity.toString(),
//                                   tradingsymbol: orderController.orderList[index].tradingsymbol.toString(),
//                                   ltp: orderController.orderList[index].price.toString(),
//                                   exchange: orderController.orderList[index].exchange.toString(),));
//
//                                 if(come != null){
//                                   orderController.getOrderList();
//                                 }
//                               }
//                             },
//
//                           ),
//                           TextButton.icon(
//                             style: ButtonStyle(
//                                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                       color: Colors.red, // your color here
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10)))),
//                             icon:const Icon(Icons.delete,color: Colors.red,) ,
//                             onPressed: ()async{
//                               String status = orderController.orderList[index].status.toString();
//                               String symbole = orderController.orderList[index].tradingsymbol.toString();
//
//                               if(status =="rejected" || status == "cancelled after market order" || status == "cancelled" || status =="complete"){
//
//                                 Helper().showMessage(message: "Please Check Status....");
//                               }else{
//
//                                 for(int i=0; i< orderController.orderList.length;i++){
//
//                                   String allstatus = orderController.orderList[i].status.toString();
//
//                                   if(symbole == orderController.orderList[i].tradingsymbol){
//
//                                     print("Element=> ${orderController.orderList[i].tradingsymbol} == $i");
//                                     if(allstatus =="rejected" || allstatus == "cancelled after market order" || allstatus == "cancelled" || allstatus == "rejected" || allstatus == "complete"){
//
//                                     }else{
//                                       try {
//                                         EasyLoading.show();
//                                         dio.Response? responce =
//                                         await ApiImplementor.cancleOrderApiImplementer(PrivateKey: orderController.orderList[i].userModel!.privateKey.toString(),
//                                             token: orderController.orderList[i].userModel!.jwtToken.toString(),
//                                             orderid: orderController
//                                                 .orderList[i].orderid.toString(),variety: orderController
//                                                 .orderList[i].variety.toString());
//                                         EasyLoading.dismiss();
//
//                                         if (responce != null &&
//                                             responce.data != null &&
//                                             responce.statusCode == 200) {
//                                           print("Cancle order=> ${responce.data}");
//                                           Helper().showMessage(
//                                               message:
//                                               "Order Cancel for ${ orderController.orderList[index].userModel?.username}");
//
//                                         }
//                                       } catch (e) {
//                                         print("${e}");
//                                       }
//                                     }
//                                   }
//                                 }
//
//                                 orderController.getOrderList();
//                               }
//
//                             }, label: const Text("Delete"),
//                           ),
//
//                           /*IconButton(
//                         onPressed: ()async{
//                       // print("print=> ${orderController.orderList[index].tradingsymbol}");
//                       String status = orderController.orderList[index].status.toString();
//                       String symbole = orderController.orderList[index].tradingsymbol.toString();
//
//                       if(status =="rejected" || status == "cancelled after market order" || status == "cancelled" || status =="complete"){
//
//                         Helper().showMessage(message: "Please Check Status....");
//                       }else{
//
//                         for(int i=0; i< orderController.orderList.length;i++){
//
//                           String allstatus = orderController.orderList[i].status.toString();
//
//                           if(symbole == orderController.orderList[i].tradingsymbol){
//
//                             print("Element=> ${orderController.orderList[i].tradingsymbol} == $i");
//                             if(allstatus =="rejected" || allstatus == "cancelled after market order" || allstatus == "cancelled" || allstatus == "rejected" || allstatus == "complete"){
//
//                             }else{
//                               try {
//                                 EasyLoading.show();
//                                 dio.Response? responce =
//                                 await ApiImplementor.cancleOrderApiImplementer(PrivateKey: orderController.orderList[i].userModel!.privateKey.toString(),
//                                     token: orderController.orderList[i].userModel!.jwtToken.toString(),
//                                     orderid: orderController
//                                         .orderList[i].orderid.toString(),variety: orderController
//                                         .orderList[i].variety.toString());
//                                 EasyLoading.dismiss();
//
//                                 if (responce != null &&
//                                     responce.data != null &&
//                                     responce.statusCode == 200) {
//                                   print("Cancle order=> ${responce.data}");
//                                   Helper().showMessage(
//                                       message:
//                                       "Order Cancel for ${ orderController.orderList[index].userModel?.username}");
//
//                                 }
//                               } catch (e) {
//                                 print("${e}");
//                               }
//                             }
//                           }
//                         }
//
//                         orderController.getOrderList();
//                       }
//
//
//                     }, icon: const Icon(Icons.delete,color: Colors.red,)),*/
//                         ],),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Row(
//                           children: [
//                             SizedBox(width: Get.width * 0.25,
//                                 child: const Text("Status :",style: TextStyle(fontSize: 14),)),
//                             Container(padding: const EdgeInsets.all(6.0),decoration: BoxDecoration(color: myChangeColor(i: index),borderRadius: BorderRadius.circular(10)),
//                               width: Get.width*0.60,
//                               margin: const EdgeInsets.only(right: 3,bottom: 5),
//                               child: Center(
//                                 child: Text(
//                                   orderController.orderList[index].status ?? "-",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ],),
//                       ),
//                       commanUi(title: "Client Name :", value: orderController.orderList[index]
//                           .userModel!.username ??
//                           "-", color: Colors.black),
//                       commanUi(title: "ProductType :", value: orderController.orderList[index].producttype??
//                           "-", color: Colors.black),
//                       commanUi(title: "Symbol :", value: orderController.orderList[index] .tradingsymbol??
//                           "-", color: Colors.black),
//                       commanUi(title: "Time :", value: orderController.orderList[index] .timeOnly??
//                           "-", color: Colors.black),
//
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0),
//                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(children: [
//                               const Text("Order Type"),
//                               Text(orderController.orderList[index] .ordertype??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//                             Column(children: [
//                               const Text("Price"),
//                               Text( orderController.orderList[index] .price.toString()??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//                             Column(children: [
//                               const Text("Trigger Price"),
//                               Text( orderController.orderList[index] .triggerprice.toString()??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//
//                           ],),
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0),
//                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(children: [
//                               const Text("Quantity"),
//                               Text(orderController.orderList[index] .quantity??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//                             Column(children: [
//                               const Text("TXN"),
//                               Text( orderController.orderList[index] .transactiontype.toString()??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//                             Column(children: [
//                               const Text("Exchanges"),
//                               Text( orderController.orderList[index] .exchange.toString()??
//                                   "-",style: const TextStyle(fontSize: 16),)
//                             ],),
//
//                           ],),
//                       ),
//
//                       // commanUi(title: "Order Type :", value: orderController.orderList[index] .ordertype??
//                       //     "-", color: Colors.black),
//                       //
//                       // commanUi(title: "Price :", value: orderController.orderList[index] .price.toString()??
//                       //     "-", color: Colors.black),
//                       // commanUi(title: "Trigger Price :", value: orderController.orderList[index] .triggerprice.toString()??
//                       //     "-", color: Colors.black),
//
//                       // commanUi(title: "Quantity :", value: orderController.orderList[index] .quantity??
//                       //     "-", color: Colors.black),
//                       //
//                       // commanUi(title: "TXN :", value: orderController.orderList[index] .transactiontype??
//                       //     "-", color: Colors.black),
//                       // commanUi(title: "Exchanges :",
//                       //     value: orderController.orderList[index].exchange ??
//                       //         "-",
//                       //     color: Colors.black),
//
//
//
//                     ],
//                   ),
//                 ),
//               );
//             }) : const Center(child: SizedBox(child: Text("Data Not Available"),))),
//       ),
//     );
//   }
//
//   Widget commanUi(
//       {required String title, required String value, required Color color}) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: SizedBox(width: Get.width * 0.25,
//               child: Text(title,style: const TextStyle(fontSize: 14),)),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: SizedBox(width: Get.width*0.60,
//               child: Text(overflow: TextOverflow.clip,maxLines: 2,value,style: TextStyle(color: color,fontSize: 16),)),
//         )
//
//       ],);
//   }
//
//   myChangeColor({required int i}) {
//     if(orderController.orderList[i].status == "rejected"){
//       Color c = Colors.red.shade100;
//       return c;
//     }else if(orderController.orderList[i].status == "cancelled"){
//       Color c = Colors.red.shade100;
//       return c;
//     }else if(orderController.orderList[i].status == "after market order req received"){
//       Color c = Colors.blue.shade100;
//       return c;
//     }
//     else if(orderController.orderList[i].status == "cancelled after market order"){
//       Color c = Colors.red.shade100;
//       return c;
//     }
//     else if(orderController.orderList[i].status == "complete"){
//       Color c = Colors.green.shade100;
//       return c;
//     }
//     else if(orderController.orderList[i].status == "open"){
//       Color c = Colors.yellow.shade100;
//       return c;
//     }
//   }
//
//   int selectedVariety({required int index}){
//     int a=0;
//     if(orderController.orderList[index].variety == "AMO"){
//       a =2;
//     }else if(orderController.orderList[index].variety == "STOPLOSS"){
//       a=1;
//     }else{
//       a=0;
//     }
//     return a;
//   }
//
//   int selectedProductType({required int index}){
//     int a=0;
//     if(orderController.orderList[index].producttype == "INTRADAY"){
//       a =2;
//     }else if(orderController.orderList[index].producttype == "CARRYFORWARD"){
//       a=1;
//     } else{
//       a=0;
//     }
//     return a;
//   }
// }
