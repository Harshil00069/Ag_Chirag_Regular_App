import 'dart:convert';

import 'package:get/get.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/model/client_json_data.dart';
import 'package:treding/model/position_data_model.dart';
import 'package:treding/model/user_model.dart';

import '../Api/api_implementor.dart';

class HomepageCtr extends GetxController {
  List<UserModel> userList = [];
  List<ClientJsonDataModel> clientJsonDataList = [];
  List<ClientJsonDataModel> commonClientJsonDataList = [];
  RxBool isLoginApiLoading = false.obs;

  RxList<PositionData> positionList = <PositionData>[].obs;
  RxBool isDataLoading = false.obs;
  List<String?> commonData = [];

  @override
  void onInit() {
    super.onInit();
    fetchDataOnly();
  }

  Future<void> initializeData() async {
    print("1 Start");
    isLoginApiLoading.value = true;

    await userLoginApi();
    print("2 Login Done");

    await getPositionList();
    print("3 Position Done");

    await calculate();
    print("4 Calculate Done");

    await userAccountDetailApi();
    print("5 Account Done");

    isLoginApiLoading.value = false;
    print("6 Loader Off");
  }

  Future<void> refreshData() async {
    print("1 Start");
    isLoginApiLoading.value = true;

    await getPositionList();
    print("2 Position Done");

    await calculate();
    print("2 Calculate Done");

    await userAccountDetailApi();
    print("3 Account Done");

    isLoginApiLoading.value = false;
    print("6 Loader Off");
  }

  fetchDataOnly() {
    PrefData.getUserData().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

  addUser(UserModel user) {
    userList.add(user);

    clientJsonDataList = userList.map((e) {
      return ClientJsonDataModel(
        ipName: e.ipName,
        ipPwd: e.ipPwd,
        port: e.port,
        clientcode: e.clientcode,
        password: e.password,
        totpSecret: e.secretKey,
        publicIP: e.publicIP,
        apiKey: e.privateKey,
      );
    }).toList();
  }

  Future<void> deleteAllUser() async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData();
    userListLocal.clear();
    print("LL))) ${userListLocal.length}");

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }
    print("LL22=> ${userListForSp.length}");

    PrefData.setUserData(userListForSp);
    update();
  }

  deleteUser(UserModel userModel, int index) async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await PrefData.getUserData();

    for (int i = 0; i < userList.length; i++) {
      if (userListLocal[i].privateKey == userModel.privateKey &&
          userListLocal[i].clientcode == userModel.clientcode &&
          userListLocal[i].password == userModel.password) {
        userListLocal.removeAt(i);
        userList.removeAt(index);
        clientJsonDataList.removeAt(index);
      }
    }

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }

    PrefData.setUserData(userListForSp);
    update();
  }

  Future<void> userLoginApi() async {
    isLoginApiLoading.value = true;
    try {
      var response = await ApiImplementor.userLoginApiImplementer(
          userList: clientJsonDataList);
      if (response.results.isNotEmpty) {
        for (int i = 0; i < response.results.length; i++) {
          if (response.results[i].jwt.isNotEmpty) {
            userList[i].jwtToken = response.results[i].jwt;
          }
        }
        commonClientJsonDataList =
            userList.where((e) => e.jwtToken.isNotEmpty).map((e) {
          return ClientJsonDataModel(
              ipName: e.ipName,
              ipPwd: e.ipPwd,
              port: e.port,
              clientcode: e.clientcode,
              password: e.password,
              totpSecret: e.secretKey,
              publicIP: e.publicIP,
              apiKey: e.privateKey,
              jwtToken: e.jwtToken);
        }).toList();

        update();
      }
    } catch (e) {
      print("${e}");
    } finally {
      // isLoginApiLoading.value = false;
    }
  }

  Future<void> userAccountDetailApi() async {
    isLoginApiLoading.value = true;
    try {
      var response = await ApiImplementor.userAccountDetailApiImplementer(
          userList: commonClientJsonDataList);
      if (response.results.isNotEmpty) {
        for (int i = 0; i < response.results.length; i++) {
          int pos = userList.indexWhere(
              (element) => element.clientcode == response.results[i].client);
          userList[pos].currentBalance =
              response.results[i].data!.availablecash;
        }
        update();
      }
    } catch (e) {
      print("${e}");
    } finally {
      // isLoginApiLoading.value = false;
    }
  }

  Future<void> getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    try {
      var response = await ApiImplementor.getPositionApiImplementer(
          userList: commonClientJsonDataList);
      if (response.results.isNotEmpty) {
        for (int i = 0; i < response.results.length; i++) {
          positionList.addAll(response.results[i].data);
        }
        commonData = positionList.map((e) => e.client).toSet().toList();
        // update();
      }
    } catch (e) {
      print("${e}");
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> calculate() async {
    String value = "";
    for (int k = 0; k < userList.length; k++) {
      for (int j = 0; j < commonData.length; j++) {
        if (userList[k].clientcode == commonData[j]) {
          double total = 0.0;
          for (int i = 0; i < positionList.length; i++) {
            if (commonData[j] == positionList[i].client) {
              total += double.parse(positionList[i].pnl.toString());
              userList[k].positionPNL = total.toPrecision(2).toString();
              print("pnl=> ${positionList[i].pnl.toString()}");

              // print("PositionPnl=> ${commandata[j]}");
              print("PositionPnl=> ${positionList[i].client}==$i");
            }
          }
          update();
          value = total.toPrecision(2).toString();
          print("Vak=> ${value}");
        }
      }
    }
    // return value;
  }
}
