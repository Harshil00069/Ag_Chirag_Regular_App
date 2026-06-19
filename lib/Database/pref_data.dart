import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:treding/model/user_model.dart';
import 'package:treding/model/watch_list_model.dart';

class PrefData {
  static String myUserList = "myUserList";
  static String myUserList2 = "myUserList2";
  static String myWatchList = "myWatchList";


  /*User List Data operations Start*/

  static setUserData(List<String> userModelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(myUserList, userModelList);
  }

  static setUserData2(List<String> userModelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(myUserList2, userModelList);
  }
  static Future<List<UserModel>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserModel> userList = [];
    List<String>? lst = prefs.getStringList(myUserList);

    if (lst != null) {
      for (var item in lst) {
        UserModel userModel = UserModel.fromJson(json.decode(item));
        userList.add(userModel);
      }
    }
    return userList;
  }


  static Future<List<UserModel>> getUserData2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserModel> userList = [];
    List<String>? lst = prefs.getStringList(myUserList2);

    if (lst != null) {
      for (var item in lst) {
        UserModel userModel = UserModel.fromJson(json.decode(item));
        userList.add(userModel);
      }
    }
    return userList;
  }

/*User List Data operations End*/


/*Watch List Data operations Start*/

  static setWatchData(List<String> watchModelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(myWatchList, watchModelList);
  }


  static Future<List<WatchListModel>> getWatchListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<WatchListModel> watchList = [];
    List<String>? lst = prefs.getStringList(myWatchList);

    if (lst != null) {
      for (var item in lst) {
        WatchListModel watchListModel = WatchListModel.fromJson(json.decode(item));
        watchList.add(watchListModel);
      }
    }
    return watchList;
  }


/*Watch List Data operations End*/



}