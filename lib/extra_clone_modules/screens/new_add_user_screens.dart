import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:treding/Database/database_service.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import 'package:treding/custom_widgets/app_text_field.dart';
import 'package:treding/extra_clone_modules/controllers/new_home_controller.dart';
import 'package:treding/model/user_model.dart';

class NewAddUserScreens extends StatefulWidget {
  bool forEdit;
  UserModel? userModel;
  int? index;
   NewAddUserScreens({super.key, this.forEdit = false,
    this.userModel,
    this.index,});

  @override
  State<NewAddUserScreens> createState() => _NewAddUserScreensState();
}

class _NewAddUserScreensState extends State<NewAddUserScreens> {

  TextEditingController privateKeyCtr = TextEditingController();

  TextEditingController clientcodeCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();

  TextEditingController secretKeyCtr = TextEditingController();

  TextEditingController usernameCtr = TextEditingController();
  TextEditingController lotsizeCtr = TextEditingController();

  NewHomepageCtr homepageCtr = Get.find();
  final databaseref = FirebaseDatabase.instance.ref("Users2");

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

    if (widget.forEdit && widget.userModel != null) {
      privateKeyCtr.text = widget.userModel!.privateKey ?? "";
      clientcodeCtr.text = widget.userModel!.clientcode ?? "";
      passwordCtr.text = widget.userModel!.password ?? "";
      secretKeyCtr.text = widget.userModel!.secretKey ?? "";
      usernameCtr.text = widget.userModel!.username ?? "";
      lotsizeCtr.text = widget.userModel!.userLotSize??"";
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PrefData.getUserData2().then((value) {
      for (var item in value) {
        print("My dat :-${item.username}");
      }
    });

    UserModel userModel;
    return Scaffold(appBar: AppBar(backgroundColor:  AppColor.purple,iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
        title:  Text(widget.forEdit ? "Edit user" : "Add User",
          style: Font.bodyText1())),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("PrivateKey"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "privateKey",
                        ctr: privateKeyCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("client code"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "client code",
                        ctr: clientcodeCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("password"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "password",
                        ctr: passwordCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("secret Key"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "secret Key",
                        ctr: secretKeyCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("user name"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "user name",
                        ctr: usernameCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("user lot Size"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "user lot Size",
                        ctr: lotsizeCtr,
                      ),
                    ],
                  )),
              AppButton(
                text: widget.forEdit ? "Edit User" : "Add User",
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    DatabaseService databaseService = DatabaseService();
                    if (widget.forEdit) {
                      ///Edit User
          
                      List<UserModel> userList = await PrefData.getUserData2();
                      userList[widget.index!] = UserModel(
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text,
                        userLotSize: lotsizeCtr.value.text
                            );
          
                      homepageCtr.newuserList[widget.index!] = UserModel(
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text,
                          userLotSize: lotsizeCtr.value.text);
          
                      List<String> userListForSp = [];
                      for (var item in userList) {
                        userListForSp.add(json.encode(item.toJson()));
                      }
          
                      var now = DateTime.now();
                      var dateFormatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(now);
                      await Firebase.initializeApp();
          
                      databaseref.child(clientcodeCtr.value.text).update({
                        "clientcode" : clientcodeCtr.value.text,
                        "secretKey" : secretKeyCtr.value.text,
                        "privateKey" :privateKeyCtr.value.text,
                        "password": passwordCtr.value.text,
                        "username": usernameCtr.value.text,
                        "dateTime":dateFormatted,
                        "lotsize": lotsizeCtr.value.text,
                      });
          
                      PrefData.setUserData2(userListForSp);
                      Helper().showMessage(message: "User updated.");
                      Get.back();
                      homepageCtr.update();
                    }
                    else {
                      ///Add New User
                      var now = DateTime.now();
                      var dateFormatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(now);
                      await Firebase.initializeApp();
          
                      databaseref.child(clientcodeCtr.value.text).set({
                        "clientcode" : clientcodeCtr.value.text,
                        "secretKey" : secretKeyCtr.value.text,
                        "privateKey" :privateKeyCtr.value.text,
                        "password": passwordCtr.value.text,
                        "username": usernameCtr.value.text,
                        "dateTime":dateFormatted,
                        "lotsize": lotsizeCtr.value.text,
                      });
          
                      List<UserModel> userList = await PrefData.getUserData2();
                      print("List=> ${userList.length}");
                      userList.add(UserModel(
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text));
          
                      List<String> userListForSp = [];
                      for (var item in userList) {
                        userListForSp.add(json.encode(item.toJson()));
                      }
          
                      PrefData.setUserData2(userListForSp);
          
          
                      Helper().showMessage(message: "New User Added.");
                      Get.back();
                      homepageCtr.freshData();
                      homepageCtr.update();
          
          
          
                      // databaseService
                      //     .insertUser(UserModel(
                      //         clientcode: clientcodeCtr.value.text,
                      //         secretKey: secretKeyCtr.value.text,
                      //         privateKey: privateKeyCtr.value.text,
                      //         password: passwordCtr.value.text,
                      //         username: usernameCtr.value.text))
                      //     .then((value) {
                      //   Helper().showMessage(message: "User Added.");
                      //   Get.back();
                      // });
                    }
                  }
                },
              ),
          
              //Test
              // AppButton(
              //   text: "Test",
              //   onPress: () async {
              //     if (formKey.currentState!.validate()) {
              //       DatabaseService databaseService = DatabaseService();
              //       if (widget.forEdit) {
              //       } else {
              //         ///Add New User
              //
              //         List<UserModel> userList = await PrefData.getUserData2();
              //         userList.add(UserModel(
              //             clientcode: "K57124074",
              //             password: "2297",
              //             privateKey: "sEmu1HWp",
              //             username: "Krupal",
              //             secretKey: "NDSLNN7WBTZGNX75GS7WMBJIDE"));
              //
              //         userList.add(UserModel(
              //             clientcode: "H54980091",
              //             password: "2724",
              //             privateKey: "9aYX9ZH2",
              //             username: "Harshil",
              //             secretKey: "44YEC4CXXCKAVX3AK3MBK3WMAQ"));
              //
              //         List<String> userListForSp = [];
              //         for (var item in userList) {
              //           userListForSp.add(json.encode(item.toJson()));
              //         }
              //
              //         PrefData.setUserData(userListForSp);
              //
              //         // databaseService
              //         //     .insertUser(UserModel(
              //         //         clientcode: clientcodeCtr.value.text,
              //         //         secretKey: secretKeyCtr.value.text,
              //         //         privateKey: privateKeyCtr.value.text,
              //         //         password: passwordCtr.value.text,
              //         //         username: usernameCtr.value.text))
              //         //     .then((value) {
              //         //   Helper().showMessage(message: "User Added.");
              //         //   Get.back();
              //         // });
              //       }
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
  TextFrfHeading(String txt) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          txt,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ));
  }
}
