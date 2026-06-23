import 'package:get/get.dart';
import 'package:treding/model/place_order_model.dart';
import 'package:treding/model/position_data_model.dart';

import '../Api/api_implementor.dart';
import 'homepage_controller.dart';

class PositionController extends GetxController {
  HomepageCtr homeScreenController = Get.put(HomepageCtr());

  List<PositionData> commonOrderList = [];
  RxList<PositionData> positionList = <PositionData>[].obs;
  List<String?> commandata = [];
  RxBool isDataLoading = false.obs;
  RxBool isPlaceOrderLoading = false.obs;
  List<PlaceOrderModel> placeOrderList = [];

  Future<void> getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    try {
      var response = await ApiImplementor.getPositionApiImplementer(
          userList: homeScreenController.commonClientJsonDataList);
      if (response.results.isNotEmpty) {
        for (int i = 0; i < response.results.length; i++) {
          positionList.addAll(response.results[i].data);
        }
        update();
      }
    } catch (e) {
      print("${e}");
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> getPlaceOrdersApi(
      {required List placeOderList, required bool isBasketOrder}) async {
    isPlaceOrderLoading.value = true;
    try {
      var response = await ApiImplementor.getOrderPlaceApiImplementer(
          userList: homeScreenController.commonClientJsonDataList,
          orderList: placeOderList.map((e) => e.toJson()).toList());
      if (response.results.isNotEmpty) {
        if (!isBasketOrder) {
          Get.back();
        }
      }
    } catch (e) {
      print("${e}");
    } finally {
      isPlaceOrderLoading.value = false;
    }
  }
}
