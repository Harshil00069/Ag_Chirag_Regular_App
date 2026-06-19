import 'dart:async';

import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/model/exchange_list_model.dart';
import 'package:treding/model/search_data_model.dart';

class SearchShareController extends GetxController {
  SearchData? selectedShare;
  RxInt SelectedShareLotSize = 0.obs;
  RxString SelectedShareLotSizes = "".obs;

  RxList<ExchangeListData> exchangeList = <ExchangeListData>[
    ExchangeListData.fromJson({
      "exchangeName": "Select",
      "shortName": "",
    }),
    ExchangeListData.fromJson({
      "exchangeName": "NFO",
      "shortName": "1",
    }),
    ExchangeListData.fromJson({
      "exchangeName": "BSE",
      "shortName": "2",
    }),
    ExchangeListData.fromJson({
      "exchangeName": "NSE",
      "shortName": "3",
    }),
    ExchangeListData.fromJson({
      "exchangeName": "MCX",
      "shortName": "4",
    }),
  ].obs;

  List<SearchData> newShareList = [];
  RxBool isLoadingNewSearch = false.obs;
  RxBool isScriptLoading = false.obs;

  Future<void> getLoadSearchScriptApi() async {
    newShareList.clear();
    isScriptLoading.value = true;
    try {
      final response = await ApiImplementor.loadScriptApiImplementer();
      if (response.success == true) {
        Helper().showMessage(
          title: "",
          message: "Data Loaded Successfully",
        );
      }

      isScriptLoading.value = false;
    } catch (e) {
      print("EE=> ${e}");
      isScriptLoading.value = false;
    }
  }

  Future<void> getSearchScriptApi({required String type}) async {
    newShareList.clear();
    isLoadingNewSearch.value = true;
    try {
      final response =
          await ApiImplementor.searchScriptApiImplementer(type: type);
      if (response.data!.isNotEmpty) {
        newShareList.addAll(response.data ?? []);
      }

      isLoadingNewSearch.value = false;
    } catch (e) {
      print("EE=> ${e}");
      isLoadingNewSearch.value = false;
    }
  }
}
