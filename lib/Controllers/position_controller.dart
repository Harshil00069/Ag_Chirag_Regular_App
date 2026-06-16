
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:treding/model/all_position_model.dart';

import '../Api/api_implementor.dart';
import 'package:dio/dio.dart' as dio;

import 'homepage_controller.dart';

class PositionController extends GetxController {
  HomepageCtr homepageCtr = Get.find();

  List<Position> positionList = [];
  List<Position> positionList2 = [];
  List<Position> commonOrderList = [];
  List<Position> commonOrderList2 = [];
  RxBool isDataLoading = false.obs;

  getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    for (var item in homepageCtr.userList) {
      if(item.isUserEnable == true){
        dio.Response? response = await ApiImplementor.getPositionListApiImplementer(
            PrivateKey: item.privateKey ?? "", token: item.jwtToken ?? "");


        if (response!.statusCode == 200 && response.data['data'] != null) {

          for (var orderItem in response.data['data']){
            print(orderItem.toString());

            Position orderListModel=Position.fromJson(orderItem);
            orderListModel.userModel=item;
            positionList.add(orderListModel );
          }

        }
      }
    }
    isDataLoading.value = false;
    print("positionList=> ${positionList.length}");
    // print("positionList=> ${positionList[0].userModel}");
    // orderList.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
    // orderList.sort((a, b) => b.tradingsymbol.toString().compareTo(a.tradingsymbol.toString()));

    update();
  }

  Future<void> getPositionList2({required bool check}) async {
    print("check=>  ${check}");
    print("CallApi=> ");
    positionList2.clear();
    // isDataLoading.value = true;
    for (var item in homepageCtr.userList) {
      dio.Response? response = await ApiImplementor.getPositionListApiImplementer(
          PrivateKey: item.privateKey ?? "", token: item.jwtToken ?? "");


      if (response!.statusCode == 200 && response.data['data'] != null&& response.data["status"]) {

        for (var orderItem in response.data['data']){
          print(orderItem.toString());
          print("DDD=> ${response.data['data']}");

          Position orderListModel=Position.fromJson(orderItem);
          orderListModel.userModel=item;
          positionList2.add(orderListModel );
        }


        isDataLoading.value = false;
      }else{

      }
    }

    for(int k=0; k< positionList2.length;k++){
      if(positionList[k].userModel?.clientcode == positionList2[k].userModel?.clientcode){
        if(positionList[k].optiontype == positionList2[k].optiontype && positionList[k].tradingsymbol == positionList2[k].tradingsymbol){

          double onlyPnl =0.0;

          onlyPnl  = double.parse(positionList2[k].pnl.toString());

          positionList[k].netprice =  positionList2[k].netprice;
          positionList[k].ltp = positionList2[k].ltp;
          positionList[k].pnl =  positionList2[k].pnl;
          print("xxx=> ${onlyPnl++}");
        }else{

          positionList.add(positionList2[k]);
        }
      }

    }
    // isDataLoading.toggle();
    isDataLoading.value = true;
    isDataLoading.value = false;
    print("positionList=> ${positionList.length}");
    // print("positionList=> ${positionList[0].userModel}");
    // orderList.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
    // orderList.sort((a, b) => b.tradingsymbol.toString().compareTo(a.tradingsymbol.toString()));

    update();
  }
}
