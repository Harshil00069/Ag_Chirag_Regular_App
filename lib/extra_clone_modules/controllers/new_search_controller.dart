import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/model/share_model.dart';

import '../../model/CheckVersionInfoModel.dart';
import 'new_home_controller.dart';


class NewSearchShareController extends GetxController {

  List<ShareModel> shareList = [];
  List<ShareModel> filterdShareList = [];

  ShareModel? selectedShare;
  String selectedType = Helper.typeList.first;
  NewHomepageCtr homepageCtr = Get.find();

  RxBool isSearchLoading = false.obs;

  // getAllShareData() async {
  //   print("Loading Start");
  //   EasyLoading.show();
  //   dio.Response? response = await ApiImplementor.getAllShareData();
  //   EasyLoading.dismiss();
  //
  //   print("Loading over");
  //
  //
  //   if (response != null && response.statusCode == 200) {
  //     shareList.clear();
  //     for (var item in response.data) {
  //       shareList.add(ShareModel.fromJson(item));
  //     }
  //     print("Set Data over");
  //     filterShareData();
  //   } else {
  //     Helper().showMessage(title: "Somthing went Wrong",message: "Error while fetching");
  //   }
  // }

  // Define a pure function to fetch data
  Future<List<ShareModel>> fetchData(int value) async {
    dio.Response? response = await ApiImplementor.getAllShareData();

    if (response != null && response.statusCode == 200) {
      List<ShareModel> shareList = [];
      for (var item in response.data) {
        shareList.add(ShareModel.fromJson(item));
      }
      return shareList;
    } else {
      return shareList;
      throw Exception("Error while fetching data");
    }
  }

  Future<bool> isPrime(int value) {
    return compute(_calculate, value);
  }

  bool _calculate(int value) {
    if (value == 1) {
      return false;
    }
    for (int i = 2; i < value; ++i) {
      if (value % i == 0) {
        return false;
      }
    }
    return true;
  }

// Modify your existing function to use isolates or compute
  Future<void> getAllShareData() async {
    print("Loading Start");
    // EasyLoading.show();

    isSearchLoading.value = true;
    try {
      // Use compute to run fetchData function in a separate isolate
      List<ShareModel> result = await compute(fetchData,1);
      isSearchLoading.value = false;
      // EasyLoading.dismiss();
      print("Loading over");
      shareList.clear();
      shareList.addAll(result);
      print("Set Data over");
      filterShareData();
    } catch (error) {
      isSearchLoading.value = false;
      // EasyLoading.dismiss();
      Helper().showMessage(title: "Something went Wrong", message: error.toString());
    }
  }







  filterShareData() {
    filterdShareList.clear();
    for (var item in shareList) {
      if (item.exchSeg == selectedType) {
        filterdShareList.add(item);
      }
    }
    print("SetData over");
    update();
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
      print("I am in222222 ");
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
      print("I am in33333 ");

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
  void onInit() {
    super.onInit();
    getAllShareData();
  }

}