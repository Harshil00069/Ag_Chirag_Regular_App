import 'dart:async';
import 'dart:convert';

import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Method/Methods.dart';
import 'package:treding/Screens/user_holding_screen.dart';
import 'package:treding/Screens/user_management_screen.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/extra_clone_modules/screens/new_dash_board_screen.dart';
import 'package:treding/model/user_model.dart';

import '../Api/api_implementor.dart';
import 'package:dio/dio.dart' as dio;

import '../Controllers/dashboard_controller.dart';
import '../Controllers/search_share_ctr.dart';
import '../Controllers/watchlist_ctr.dart';
import '../Database/pref_data.dart';
import '../Utils/app_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomepageCtr homepageCtr = Get.put(HomepageCtr());
  DashboardCtr ctrl = Get.put(DashboardCtr());

  WatchListController watchListController = Get.put(WatchListController());

  SearchShareController searchShareController =
      Get.put(SearchShareController());
  Timer? timer;

  var props;
  final databaseReference = FirebaseDatabase.instance.ref("Users");
  final databaseReference2 = FirebaseDatabase.instance.ref("Date");

  List<UserModel> userdatalist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("working");
    checkdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColor.primaryColor,
          title: Text('Algo Trading', style: Font.bodyText1()),
          actions: [
            // IconButton(onPressed: (){
            //   Get.to(const NewDashboardScreens());
            // }, icon: const Icon(Icons.percent_outlined),),
            IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () async {
                homepageCtr.userList.clear();
                await homepageCtr.deleteAllUser();
                List<UserModel> userListLocal = await PrefData.getUserData();

                print("Length=> ${userListLocal.length}");

                databaseReference.once().then((value) {
                  if (value.snapshot.value == null) {}
                  print("${value.snapshot.value}");
                  value.snapshot.children.forEach((element) async {
                    props = element.value as Map;

                    userListLocal.add(UserModel(
                        isUserEnable: props['isUserEnable'],
                        clientcode: props['clientcode'].toString(),
                        secretKey: props['secretKey'].toString(),
                        privateKey: props['privateKey'].toString(),
                        password: props['password'].toString(),
                        username: props['username'].toString()));

                    print("Lenght=> ${userListLocal.length}");

                    List<String> userListForSp = [];
                    for (var item in userListLocal) {
                      userListForSp.add(json.encode(item.toJson()));
                    }
                    PrefData.setUserData(userListForSp);
                  });
                  homepageCtr.update();
                  homepageCtr.fetchDataOnly();
                });
              },
              icon: const Icon(Icons.cloud_download),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => UserManagementScreen());
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () async {
                //Login All Users
                EasyLoading.show();
                for (var item in homepageCtr.userList) {
                  if (item.isUserEnable == true) {
                    TOTP totp = TOTP(secret: item.secretKey ?? "", digits: 6);

                    dio.Response? response =
                        await ApiImplementor.getVersionInfoApiImplementer(
                            PrivateKey: item.privateKey ?? "",
                            clientcode: item.clientcode ?? "",
                            password: item.password ?? "",
                            totp: totp.now());

                    if (response != null && response.statusCode == 200) {
                      print("Data => new  ${response.data}");

                      homepageCtr.addJwtToUserList(
                          clientcode: item.clientcode ?? "",
                          jwtTkn: response.data["data"]["jwtToken"]);
                    } else {
                      return;
                    }
                  }
                }
                await homepageCtr.getAllUserHoldingsData();
                await homepageCtr.getPositionList().then((value) {
                  homepageCtr.calculate();
                });
                EasyLoading.dismiss();
                timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
                  homepageCtr.getAllUserHoldingsData();
                  homepageCtr.getPositionList().then((value) {
                    homepageCtr.calculate();
                  });
                });
              },
              icon: const Icon(Icons.power_settings_new),
            ),
          ]),
      body: GetBuilder(
          init: homepageCtr,
          builder: (ctr) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: homepageCtr.userList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(UserHoldingScreen(
                          index: index,
                          privatekey:
                              homepageCtr.userList[index].privateKey.toString(),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              //color of shadow
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              // blur radius
                              // offset: const Offset(
                              //     1, 2), // changes position of shadow
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.80,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Client Code : ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(homepageCtr
                                                  .userList[index].clientcode ??
                                              "-")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("User Name : ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            homepageCtr
                                                    .userList[index].username ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Holding PNL :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            homepageCtr.userList[index].PNL ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Position PNL :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            homepageCtr.userList[index]
                                                    .positionPNL ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: myChangeColor(
                                                    value: homepageCtr
                                                            .userList[index]
                                                            .positionPNL ??
                                                        "0.0")),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Current balance : ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            homepageCtr.userList[index]
                                                    .currentBalance ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: homepageCtr
                                                    .userList[index].jwtToken !=
                                                null
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  myChangeColor({required String value}) {
    double pnlvalue = 0.0;
    pnlvalue = double.parse(value);
    if (pnlvalue > 0) {
      Color c = Colors.green;
      return c;
    } else {
      Color c = Colors.red;
      return c;
    }
  }

  void checkdate() {
    databaseReference2.once().then((value) {
      if (value.snapshot.value == null) {}
      print("${value.snapshot.value}");
      value.snapshot.children.forEach((element) async {
        props = element.value;
        print("props=> ${props}");
        var now = DateTime.now();
        var formatter = DateFormat('dd/MM/yyyy');
        String formattedDate = formatter.format(now);
        print("formattedDate=> ${formattedDate}");
        DateTime dt = DateFormat("dd/MM/yyyy").parse(props);
        DateTime dt2 = DateFormat("dd/MM/yyyy").parse(formattedDate);
        if (dt2.isAfter(dt)) {
          print("Is After");
          SystemNavigator.pop();
        } else {
          print("is not");
        }
      });
    });
  }
}
