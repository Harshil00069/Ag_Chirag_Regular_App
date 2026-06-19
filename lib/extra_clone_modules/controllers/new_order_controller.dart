// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:treding/Api/api_implementor.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:treding/Controllers/homepage_controller.dart';
// import 'package:treding/model/order_list_model.dart';
//
// import 'new_home_controller.dart';
//
//
// class NewOrderController extends GetxController {
//   NewHomepageCtr homepageCtr = Get.find();
//   List<OrderListModel> orderList = [];
//   List<OrderListModel> commonOrderList = [];
//   List<OrderListModel> letestorderList = [];
//   List <String?> commandata =[];
//   RxBool isDataLoading = false.obs;
//   List <String> statusList= ["open","after market order req received","cancelled after market order","cancelled","rejected"];
//
//   getOrderList() async {
//     orderList.clear();
//     letestorderList.clear();
//     isDataLoading.value = true;
//     for (var item in homepageCtr.newuserList) {
//       dio.Response? response = await ApiImplementor.getOrderListApiImplementer(
//           PrivateKey: item.privateKey ?? "", token: item.jwtToken ?? "");
//
//
//       if (response != null && response.statusCode == 200 && response.data['data'] != null&& response.data["status"]) {
//
//         for (var orderItem in response.data['data']){
//           print(orderItem.toString());
//           OrderListModel orderListModel=OrderListModel.fromJson(orderItem);
//           orderListModel.userModel=item;
//           orderList.add(orderListModel);
//         }
//
//       }
//     }
//     isDataLoading.value = false;
//     commandata =  orderList.map((e) => e.status).toSet().toList();
//
//     print("commandata=> ${commandata.length}");
//     /*for(int j =0;j<statusList.length;j++){
//
//       for(int i=0;i<orderList.length;i++){
//
//         if(statusList[j] == orderList[i].status){
//           letestorderList.add(OrderListModel(status: orderList[i].status,producttype: orderList[i].producttype,ordertype: orderList[i].ordertype,variety: orderList[i].variety,
//           symboltoken: orderList[i].symboltoken,exchange: orderList[i].exchange,tradingsymbol: orderList[i].tradingsymbol,lotsize: orderList[i].lotsize,averageprice: orderList[i].averageprice,
//           cancelsize: orderList[i].cancelsize,disclosedquantity: orderList[i].disclosedquantity,updatetime: orderList[i].updatetime,duration: orderList[i].duration,
//           exchorderupdatetime: orderList[i].exchorderupdatetime,exchtime: orderList[i].exchtime,expirydate: orderList[i].expirydate,filledshares: orderList[i].filledshares,
//           fillid: orderList[i].fillid,filltime: orderList[i].filltime,instrumenttype: orderList[i].instrumenttype,optiontype: orderList[i].optiontype,orderid: orderList[i].orderid,
//           orderstatus: orderList[i].orderstatus,ordertag: orderList[i].ordertag,parentorderid: orderList[i].orderid,price: orderList[i].price,
//           quantity: orderList[i].quantity,text: orderList[i].text,squareoff: orderList[i].squareoff,stoploss: orderList[i].stoploss,strikeprice: orderList[i].strikeprice,
//           trailingstoploss: orderList[i].trailingstoploss,transactiontype: orderList[i].transactiontype,triggerprice: orderList[i].triggerprice,unfilledshares: orderList[i].unfilledshares,
//           uniqueorderid: orderList[i].uniqueorderid,unicID: 0,userModel: orderList[i].userModel));
//
//         }
//       }
//     }*/
//     // orderList.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
//
//
//     for(int i=0; i<orderList.length;i++){
//       DateFormat format = DateFormat("dd-MMM-yyyy HH:mm:ss");
//       DateTime parsedDate = format.parse(orderList[i].updatetime.toString());
//       // DateTime dateTime = DateTime.parse(parsedDate);
//       String formattedTime = DateFormat('HH:mm:ss').format(parsedDate);
//       orderList[i].timeOnly = formattedTime;
//       }
//
//     orderList.sort((a, b) => b.timeOnly.toString().compareTo(a.timeOnly.toString()));
//     update();
//   }
// }