import 'dart:convert';

import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/model/watch_list_model.dart';

class WatchListController extends GetxController {
  List<WatchListModel> watchlist = [];
  List<WatchListModel> watchListJsonData = [];
  List<WatchListModel> basketWatchlist = [];
  RxBool watchListDataLoad = false.obs;
  RxInt countdownValue = 0.obs;
  HomepageCtr homeScreenController = Get.put(HomepageCtr());

  @override
  void onInit() {
    getWatchListData();
    super.onInit();
  }

  void addToWatchList(WatchListModel watchListModel) {
    List<WatchListModel> watchLst = watchlist
        .where(
            (element) => element.tradingsymbol == watchListModel.tradingsymbol)
        .toList();
    if (watchLst.isEmpty) {
      watchlist.add(watchListModel);
      basketWatchlist.add(watchListModel);
      print("LL=> ${basketWatchlist.length}");
      for (int i = 1; i < basketWatchlist.length; i++) {
        basketWatchlist[i].position = i;
        print("LTT=> ${basketWatchlist[i].lotsize}");
      }
      Helper().showMessage(message: "Added Successfully");
      update();
    } else {
      print("Already present");
    }
  }

  void removeFromWatchList(WatchListModel watchListModel, int pos) async {
    List<WatchListModel> watchListLocal = await PrefData.getWatchListData();

    for (int i = 0; i < watchlist.length; i++) {
      if (watchListLocal[i].tradingsymbol == watchListModel.tradingsymbol) {
        watchListLocal.removeAt(i);
        watchlist.removeAt(pos);
        basketWatchlist.removeAt(pos + 1);
      }
    }

    List<String> watchListForSp = [];

    for (var item in watchListLocal) {
      watchListForSp.add(json.encode(item.toJson()));
    }

    print("wlist sp :-${watchListForSp}");
    PrefData.setWatchData(watchListForSp);
    update();

    Helper().showMessage(message: "Remove Successfully");
  }

  void getWatchListData() {
    watchlist.clear();
    basketWatchlist.clear();
    basketWatchlist.add(WatchListModel(ltp: 0.0,
      lotsize: "0",
      position: 0,
      tradingsymbol: "Select Symbol",
    ));
    PrefData.getWatchListData().then((value) {
      for (var item in value) {
        addToWatchList(item);
      }
      update();
    });
  }

  void addWatchListJson() {
    watchListJsonData = watchlist.map((e) {
      return WatchListModel(ltp: 0.0,
          exchange: e.exchange,
          tradingsymbol: e.tradingsymbol,
          symboltoken: e.symboltoken);
    }).toList();
  }

  Future<void> getSharePriceApi() async {
    watchListDataLoad.value = true;

    if (homeScreenController.commonClientJsonDataList.isEmpty) {
      Helper().showMessage(message: "User Not Login");
      return;
    }
    addWatchListJson();
    try {
      final response = await ApiImplementor.getLtpApiImplementer(
          userList: homeScreenController.commonClientJsonDataList,
          ltpList: watchListJsonData);
      if (response.results.isNotEmpty) {
        for (var item in response.results) {
          int pos = watchlist
              .indexWhere((element) => element.symboltoken == item.symboltoken);
          if (pos != -1) {
            watchlist[pos].ltp = item.ltp;
          }
        }
      }
      watchListDataLoad.value = false;
      update();
    } catch (e) {
      print("EE=> ${e}");
      watchListDataLoad.value = false;
    }
  }

}
