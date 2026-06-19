import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/model/modify_order_model.dart';
import 'package:treding/model/order_book_data_model.dart';
import 'package:treding/model/place_order_model.dart';
import 'dashboard_controller.dart';

class OrderController extends GetxController {
  HomepageCtr homeScreenController = Get.put(HomepageCtr());
  DashboardCtr ctrl = Get.put(DashboardCtr());
  List<OrderBookData> commonOrderList = [];
  List<OrderBookData> orderList = [];
  List<PlaceOrderModel> placeOrderList = [];
  List<ModifyOrderModel> orderModifyList = [];

  RxBool isOrderLoading = false.obs;
  RxBool isPlaceOrderLoading = false.obs;
  RxBool isOrderModifyLoading = false.obs;

  List<String> statusList = [
    "open",
    "after market order req received",
    "cancelled after market order",
    "cancelled",
    "rejected"
  ];

  Future<void> getOrdersListApi() async {
    orderList.clear();
    isOrderLoading.value = true;
    try {
      var response = await ApiImplementor.getOrdersListApiImplementer(
          userList: homeScreenController.commonClientJsonDataList);

      if (response.results.isNotEmpty) {
        for (int i = 0; i < response.results.length; i++) {
          orderList.addAll(response.results[i].data);
        }
        if (orderList.isNotEmpty) {
          for (int k = 0; k < orderList.length; k++) {
            orderList[k].variety = "NORMAL";
            int index = homeScreenController.userList.indexWhere(
                (data) => data.clientcode == orderList[k].clientcode);

            if (index != -1) {
              // 3. Extract the name from your user object
              orderList[k].clientName = homeScreenController
                      .userList[index].username ??
                  ""; // Change '.name' to whatever your property is called (e.g., clientName)
              // print("Found Client Name: ${orderList[k].clientName}");
            }
          }
          orderList.sort((a, b) => a.tradingsymbol.compareTo(b.tradingsymbol));

          orderList.sort((a, b) {
            // Pending first
            if (a.status == "open" && b.status != "open") {
              return -1;
            }
            if (a.status != "open" && b.status == "open") {
              return 1;
            }

            // Cancelled last
            if (a.status == "cancelled" && b.status != "cancelled") {
              return 1;
            }
            if (a.status != "cancelled" && b.status == "cancelled") {
              return -1;
            }

            // Then sort by symbol
            return a.tradingsymbol.compareTo(b.tradingsymbol);
          });
        }
        update();
      }
    } catch (e) {
      print("Err=> ${e}");
    } finally {
      isOrderLoading.value = false;
    }
  }

  Future<void> getCancelOrdersApi({required int position}) async {
    isOrderLoading.value = true;
    commonOrderList.clear();
    var symbolToken = orderList[position].symboltoken;
    commonOrderList =
        orderList.where((e) => e.symboltoken == symbolToken).toList();
    try {
      var response = await ApiImplementor.cancelOrdersApiImplementer(
          userList: homeScreenController.commonClientJsonDataList,
          cancelOrderList: commonOrderList.map((e) => e.toJson()).toList());
      if (response.results.isNotEmpty) {
        await getOrdersListApi();
      }
    } catch (e) {
    } finally {
      isOrderLoading.value = false;
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
        } else {
          ctrl.controller.animateTo(3);
        }
      }
    } catch (e) {
    } finally {
      isPlaceOrderLoading.value = false;
    }
  }

  Future<void> getOrdersModifyApi({required List oderModifyList}) async {
    isOrderModifyLoading.value = true;
    try {
      var response = await ApiImplementor.getModifyOrderPlaceApiImplementer(
          userList: homeScreenController.commonClientJsonDataList,
          orderList: oderModifyList.map((e) => e.toJson()).toList());
      if (response.results.isNotEmpty) {
        await getOrdersListApi();
        Get.back();
      }
    } catch (e) {
    } finally {
      isOrderModifyLoading.value = false;
    }
  }
}
