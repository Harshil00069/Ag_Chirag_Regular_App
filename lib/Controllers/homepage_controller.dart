import 'dart:convert';

import 'package:get/get.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/model/all_position_model.dart';
import 'package:treding/model/user_model.dart';

import '../Api/api_implementor.dart';
import 'package:dio/dio.dart' as dio;

import '../model/all_holdings_model.dart';

class HomepageCtr extends GetxController {
  List<UserModel> userList = [
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
  List<Holdings> holdingScreenList =[];
  List<Totalholding> totalholdingList =[];
  Totalholding? totalholdings = Totalholding();
  RxBool isholdingloading = false.obs;
  List<Position> positionList = [];
  List <String?> commandata =[];
  RxBool isDataLoading = false.obs;
  addUser(UserModel user) {
    userList.add(user);
  }

  addJwtToUserList({required String clientcode, required String jwtTkn}) async {
    int pos =
        userList.indexWhere((element) => element.clientcode == clientcode);

    userList[pos].jwtToken = jwtTkn;
    await GetSingleUserData(pos);
    update();
  }

  @override
  void onInit() {
    PrefData.getUserData().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }


  fetchDataOnly(){
    PrefData.getUserData().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

  freshData(){
    userList.clear();
    PrefData.getUserData().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

  Future<void> GetUserData() async {
    for (int i = 0; i < userList.length; i++) {
      if(userList[i].isUserEnable == true){
        await ApiImplementor.getUserDetail(
            PrivateKey: userList[i].privateKey ?? "",
            authKey: userList[i].jwtToken ?? "")
            .then((value) {
          if (value != null && value.statusCode == 200) {
            dio.Response response = value;
            // print("Case :- ${response.data["data"]["availablecash"]}");
            userList[i].currentBalance = response.data["data"]["availablecash"].toString();
            // userList[i].PNL = response.data["data"]["net"];
          }
        });
      }
    }
    update();
  }

  Future<void> getAllUserHoldingsData() async {
    holdings.clear();
    for (int i = 0; i < userList.length; i++) {

      if(userList[i].isUserEnable == true){
        await ApiImplementor.getAllHoldingsApi(
            PrivateKey: userList[i].privateKey ?? "",
            authKey: userList[i].jwtToken ?? "")
            .then((value) {
          print("check condition=> ${value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null }");
          if (value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null ) {
            userList[i].PNL = value.data!.totalholding!.totalprofitandloss.toString();
          }
        });
      }
    }
    update();
  }

  Future<void> getUserHoldingsData({required int i}) async {
    isholdingloading.value = true;
    holdingScreenList.clear();
    await ApiImplementor.getAllHoldingsApi(
        PrivateKey: userList[i].privateKey ?? "",
        authKey: userList[i].jwtToken ?? "")
        .then((value) {
      if (value != null && value.data!.holdings!.isNotEmpty && value.data!.totalholding != null ) {
        holdingScreenList.addAll(value.data!.holdings ??[]);
        totalholdings = value.data!.totalholding;
        isholdingloading.value = false;
      }else{
        isholdingloading.value = false;
      }
    });
    update();
  }

  Future<void> GetSingleUserData(int index) async {

      await ApiImplementor.getUserDetail(
          PrivateKey: userList[index].privateKey ?? "",
          authKey: userList[index].jwtToken ?? "")
          .then((value) {
        if (value != null && value.statusCode == 200) {
          dio.Response response = value;
          print("Case :- ${response.data["data"]["availablecash"]}");
          userList[index].currentBalance = response.data["data"]["availablecash"];
          // userList[index].PNL = response.data["data"]["net"];
        }
      });

      print("My index $index userlist length ${userList.length}");

  }


  deleteUser(UserModel userModel,int index) async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData();

    for (int i = 0; i < userList.length; i++) {
      if (userListLocal[i].privateKey == userModel.privateKey && userListLocal[i].clientcode == userModel.clientcode && userListLocal[i].password == userModel.password) {
        userListLocal.removeAt(i);
        userList.removeAt(index);
      }
    }

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }

    PrefData.setUserData(userListForSp);
    update();
  }


 Future<void> deleteAllUser() async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData();
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

    PrefData.setUserData(userListForSp);
    update();
  }
  Future<void> getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    for (var item in userList) {
      if(item.isUserEnable == true){
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

    }
    commandata =  positionList.map((e) => e.userModel!.clientcode).toSet().toList();
    isDataLoading.value = false;
    print("positionList=> ${positionList.length}");
    // print("positionList=> ${positionList[0].userModel}");
    // orderList.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
    // orderList.sort((a, b) => b.tradingsymbol.toString().compareTo(a.tradingsymbol.toString()));

    update();
  }

  String calculate() {
    String value = "";


    for(int k=0;k<userList.length;k++){

      for(int j =0;j<commandata.length;j++){
        if(userList[k].clientcode ==  commandata[j]){
          double total = 0.0;
          for (int i = 0; i < positionList.length; i++) {
            if(commandata[j] == positionList[i].userModel!.clientcode){
              total += double.parse(positionList[i].pnl.toString());
              userList[k].positionPNL = total.toPrecision(2).toString();
              // print("pnl=> ${positionList[i].pnl.toString()}");
              // print("PositionPnl=> ${commandata[j]}");
              // print("PositionPnl=> ${positionList[i].userModel!.username}==$i");
            }
          }
          value = total.toPrecision(3).toString();
        }
      }
    }
    return value;
  }
}
