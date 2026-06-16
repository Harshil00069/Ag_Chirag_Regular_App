import 'dart:convert';

import 'package:get/get.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/model/watch_list_model.dart';

class WatchListController extends GetxController {
  List<WatchListModel> watchlist = [];
  List<WatchListModel> basketWatchlist = [];
  RxBool watchListDataLoad = false.obs;


  addToWatchList(WatchListModel watchListModel) {
    List<WatchListModel> watchLst = watchlist
        .where(
            (element) => element.tradingsymbol == watchListModel.tradingsymbol)
        .toList();
    if (watchLst.isEmpty) {

      watchlist.add(watchListModel);
      basketWatchlist.add(watchListModel);
      for (int i = 1; i < basketWatchlist.length; i++) {
        basketWatchlist[i].position = i;
      }
      Helper().showMessage(message: "Added Successfully");
      update();
    } else {
      print("Already present");
    }
  }

  removeFromWatchList(WatchListModel watchListModel, int pos) async {
    print("Ps==> ${pos}");
    List<WatchListModel> watchListLocal = await PrefData.getWatchListData();

    for (int i = 0; i < watchlist.length; i++) {
      if (watchListLocal[i].tradingsymbol == watchListModel.tradingsymbol) {
        watchListLocal.removeAt(i);
        watchlist.removeAt(pos);
        basketWatchlist.removeAt(pos+1);
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

    // watchlist.removeAt(pos);
    // update();
  }

  getWatchListData() {
    watchlist.clear();
    basketWatchlist.clear();
    basketWatchlist.add(WatchListModel(lotsize: "0",position: 0,tradingsymbol: "Select Symbole",));
    PrefData.getWatchListData().then((value) {
      for (var item in value) {
        addToWatchList(item);
      }
      update();
    });

  }

  deleteWatchlistData(WatchListModel watchListModel, int index) async {
    ///Delete user from list and Sp also

    List<WatchListModel> watchListLocal = await PrefData.getWatchListData();

    for (int i = 0; i < watchlist.length; i++) {
      if (watchListLocal[i].tradingsymbol == watchListModel.tradingsymbol) {
        watchListLocal.removeAt(i);
        watchlist.removeAt(index);
        basketWatchlist.removeAt(index);
      }
    }

    List<String> watchListForSp = [];

    for (var item in watchListLocal) {
      watchListForSp.add(json.encode(item.toJson()));
    }

    PrefData.setWatchData(watchListForSp);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getWatchListData();
    super.onInit();
  }

  refreshSharePrice(int pos, num newPrice) {
    watchlist[pos].ltp = newPrice;
    update();
  }
}
