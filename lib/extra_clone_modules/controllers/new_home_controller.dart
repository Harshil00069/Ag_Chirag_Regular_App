import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/model/all_holdings_model.dart';
import 'package:treding/model/all_position_model.dart';
import 'package:treding/model/user_model.dart';
import 'package:dio/dio.dart' as dio;

class NewHomepageCtr extends GetxController{


  List<UserModel> newuserList = [
    // UserModel(
    //     clientcode: "K57124074",
    //     password: "2297",
    //     privateKey: "sEmu1HWp",
    //     username: "Krupal",
    //     secretKey: "NDSLNN7WBTZGNX75GS7WMBJIDE"),
    // UserModel(
    //     clientcode: "H54980091",
    //     password: "2724",
    //     privateKey: "9aYX9ZH2",
    //     username: "Harshil",
    //     secretKey: "44YEC4CXXCKAVX3AK3MBK3WMAQ")
  ];

  List<Holdings> holdings =[];
  List<Totalholding> totalholdingList =[];
  Totalholding? totalholdings = Totalholding();
  RxBool isholdingloading = false.obs;

  List<Position> positionList = [];
  RxBool isDataLoading = false.obs;
  List <String?> commandata =[];


  addUser(UserModel user) {
    newuserList.add(user);
    print("Len=> ${newuserList.length}");
  }

  addJwtToUserList({required String clientcode, required String jwtTkn}) async {
    int pos =
    newuserList.indexWhere((element) => element.clientcode == clientcode);

    newuserList[pos].jwtToken = jwtTkn;
    await GetSingleUserData(pos);
    update();
  }

  @override
  void onInit() {
    PrefData.getUserData2().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }


  fetchDataOnly(){
    PrefData.getUserData2().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

  freshData(){
    newuserList.clear();
    PrefData.getUserData2().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

  Future<void> GetUserData2() async {
    for (int i = 0; i < newuserList.length; i++) {
      await ApiImplementor.getUserDetail(
          PrivateKey: newuserList[i].privateKey ?? "",
          authKey: newuserList[i].jwtToken ?? "")
          .then((value) {
        if (value != null && value.statusCode == 200) {
          dio.Response response = value;
          // print("Case :- ${response.data["data"]["availablecash"]}");
          newuserList[i].currentBalance = response.data["data"]["availablecash"].toString();
          // userList[i].PNL = response.data["data"]["net"];
        }
      });
    }
    update();
  }

  Future<void> getAllUserHoldingsData() async {
    holdings.clear();
    for (int i = 0; i < newuserList.length; i++) {
      await ApiImplementor.getAllHoldingsApi(
          PrivateKey: newuserList[i].privateKey ?? "",
          authKey: newuserList[i].jwtToken ?? "")
          .then((value) {
        print("check condition=> ${value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null }");
        if (value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null ) {
          newuserList[i].PNL = value.data!.totalholding!.totalprofitandloss.toString();
        }
      });
    }
    update();
  }

  // Future<void> getUserHoldingsData ({required int i}) async {
  //   isholdingloading.value = true;
  //   holdings.clear();
  //   await ApiImplementor.getAllHoldingsApi(
  //       PrivateKey: newuserList[i].privateKey ?? "",
  //       authKey: newuserList[i].jwtToken ?? "")
  //       .then((value) {
  //     if (value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null ) {
  //
  //       holdings.addAll(value.data!.holdings ??[]);
  //       totalholdings = value.data!.totalholding;
  //
  //
  //       isholdingloading.value = false;
  //     }else{
  //       isholdingloading.value = false;
  //     }
  //   });
  //   update();
  // }

  Future<void> GetSingleUserData(int index) async {

    await ApiImplementor.getUserDetail(
        PrivateKey: newuserList[index].privateKey ?? "",
        authKey: newuserList[index].jwtToken ?? "")
        .then((value) {
      if (value != null && value.statusCode == 200) {
        dio.Response response = value;
        print("Case :- ${response.data["data"]["availablecash"]}");
        newuserList[index].currentBalance = response.data["data"]["availablecash"];
        // userList[index].PNL = response.data["data"]["net"];
      }
    });

    print("My index $index userlist length ${newuserList.length}");

  }


  deleteUser(UserModel userModel,int index) async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData2();

    for (int i = 0; i < newuserList.length; i++) {
      if (userListLocal[i].privateKey == userModel.privateKey && userListLocal[i].clientcode == userModel.clientcode && userListLocal[i].password == userModel.password) {
        userListLocal.removeAt(i);
        newuserList.removeAt(index);
      }
    }

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }

    PrefData.setUserData2(userListForSp);
    update();
  }


  Future<void> deleteAllUser() async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData2();
    userListLocal.clear();
    print("LL))) ${userListLocal.length}");

    // for (int i = 0; i < userListLocal.length; i++) {
    //   print("PP=> ${userListLocal[i].username}");
    //
    //   // userListLocal.removeAt(i);
    // }

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }
    print("LL22=> ${userListForSp.length}");

    PrefData.setUserData2(userListForSp);
    update();
  }


  Future<void> getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    for (var item in newuserList) {
      dio.Response? response = await ApiImplementor.getPositionListApiImplementer(
          PrivateKey: item.privateKey ?? "", token: item.jwtToken ?? "");


      if (response!.data != null && response.statusCode == 200 && response.data['data'] != null&& response.data["status"]) {

        for (var orderItem in response.data['data']){
          print(orderItem.toString());

          Position orderListModel=Position.fromJson(orderItem);
          orderListModel.userModel=item;
          positionList.add(orderListModel );
        }

        isDataLoading.value = false;
      }else{

      }
    }
    commandata =  positionList.map((e) => e.userModel!.clientcode).toSet().toList();
    isDataLoading.value = false;
    print(" positionList=> ${positionList.length}");
    // print("positionList=> ${positionList[0].userModel}");
    // orderList.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
    // orderList.sort((a, b) => b.tradingsymbol.toString().compareTo(a.tradingsymbol.toString()));

    update();
  }

  String calculate() {
    String value = "";


    for(int k=0;k<newuserList.length;k++){

      for(int j =0;j<commandata.length;j++){
        if(newuserList[k].clientcode ==  commandata[j]){
          double total = 0.0;
          for (int i = 0; i < positionList.length; i++) {
            if(commandata[j] == positionList[i].userModel!.clientcode){
              total += double.parse(positionList[i].pnl.toString());
              newuserList[k].positionPNL = total.toPrecision(2).toString();
              // print("pnl=> ${newuserList[k].positionPNL.toString()}");
              print("PositionPnl=> ${commandata[j]}");
              print("PositionPnl=> ${positionList[i].userModel!.username}==$i");
            }
          }
          value = total.toPrecision(2).toString();
        }
      }
    }
    return value;
  }

}






