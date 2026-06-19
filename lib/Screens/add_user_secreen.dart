import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treding/Controllers/homepage_controller.dart';
import 'package:treding/Database/pref_data.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/custom_widgets/app_burron.dart';
import '../custom_widgets/app_text_field.dart';
import '../model/user_model.dart';

class AddUserScreen extends StatefulWidget {
  final bool forEdit;
  final UserModel? userModel;
  final int index;

  const AddUserScreen({
    super.key,
     this.forEdit = false,
    this.userModel,
     this.index =0,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  // final DatabaseService _databaseService = DatabaseService();

  TextEditingController privateKeyCtr = TextEditingController();

  TextEditingController clientcodeCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();

  TextEditingController secretKeyCtr = TextEditingController();

  TextEditingController usernameCtr = TextEditingController();

  TextEditingController ipNameCtr = TextEditingController();
  TextEditingController ipPwdCtr = TextEditingController();
  TextEditingController portCtr = TextEditingController();
  TextEditingController publicIPCtr = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ValueNotifier buySellSwitch = ValueNotifier(true);
  HomepageCtr homepageCtr = Get.put(HomepageCtr());
  final databaseref = FirebaseDatabase.instance.ref("Users");

  @override
  void initState() {

    if (widget.forEdit && widget.userModel != null) {
      privateKeyCtr.text = widget.userModel!.privateKey ?? "";
      clientcodeCtr.text = widget.userModel!.clientcode ?? "";
      passwordCtr.text = widget.userModel!.password ?? "";
      secretKeyCtr.text = widget.userModel!.secretKey ?? "";
      usernameCtr.text = widget.userModel!.username ?? "";
      ipNameCtr.text = widget.userModel!.ipName ?? "";
      ipPwdCtr.text = widget.userModel!.ipPwd ?? "";
      portCtr.text = widget.userModel!.port ?? "";
      publicIPCtr.text = widget.userModel!.publicIP ?? "";
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // PrefData.getUserData().then((value) {
    //   for (var item in value) {
    //     print("My dat :-${item.username}");
    //   }
    // });

    return Scaffold(appBar: AppBar(backgroundColor:  AppColor.primaryColor,iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
        title:  Text(widget.forEdit ? "Edit user" : "Add User",
          style: Font.bodyText1(),)),
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
                  margin:
                  EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("ip Name"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "ip Name",
                        ctr: ipNameCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("ip Password"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "ip Password",
                        ctr: ipPwdCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("ip Port"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "ip Port",
                        ctr: portCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
                  child: Column(
                    children: [
                      TextFrfHeading("Public IP"),
                      const SizedBox(height: 5),
                      RegTxtField(
                        hintTxt: "Public IP",
                        ctr: publicIPCtr,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
          
              // Container(
              //     margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.10),
              //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         TextFrfHeading("User Enable"),
              //         const SizedBox(height: 5),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: ValueListenableBuilder(
              //               valueListenable: buySellSwitch,
              //               builder: (ctx, val, _) {
              //                 return Switch(inactiveTrackColor: Colors.red.shade100,
              //                   value: buySellSwitch.value,
              //                   onChanged: (val) {
              //                     buySellSwitch.value = val;
              //                   },
              //                   activeThumbColor: Colors.green,
              //                   inactiveThumbColor: Colors.red,
              //                 );
              //               }),
              //         ),
              //       ],
              //     )),
              const SizedBox(height: 10),
              AppButton(
                text: widget.forEdit ? "Edit User" : "Add User",
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    // DatabaseService databaseService = DatabaseService();
                    if (widget.forEdit) {
                      ///Edit User
          
                      List<UserModel> userList = await PrefData.getUserData();
                      userList[widget.index] = UserModel(
                          ipName: ipNameCtr.value.text,
                          ipPwd: ipPwdCtr.value.text,
                          port: portCtr.value.text,
                          publicIP: publicIPCtr.value.text,
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text);
          
          
                      homepageCtr.userList[widget.index] = UserModel(
                          ipName: ipNameCtr.value.text,
                          ipPwd: ipPwdCtr.value.text,
                          port: portCtr.value.text,
                          publicIP: publicIPCtr.value.text,
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text);
          
          
                      List<String> userListForSp = [];
                      for (var item in userList) {
                        userListForSp.add(json.encode(item.toJson()));
                      }
          
                      var now = DateTime.now();
                      var dateFormatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(now);
                      await Firebase.initializeApp();
          
                      databaseref.child(clientcodeCtr.value.text).update({
                        "clientcode": clientcodeCtr.value.text,
                        "secretKey": secretKeyCtr.value.text,
                        "privateKey": privateKeyCtr.value.text,
                        "password": passwordCtr.value.text,
                        "username": usernameCtr.value.text,
                        "ipName": ipNameCtr.value.text,
                        "ipPwd": ipPwdCtr.value.text,
                        "port": portCtr.value.text,
                        "publicIP": publicIPCtr.value.text,
                        "dateTime": dateFormatted,
                      });
          
          
                      PrefData.setUserData(userListForSp);
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
                        "clientcode": clientcodeCtr.value.text,
                        "secretKey": secretKeyCtr.value.text,
                        "privateKey": privateKeyCtr.value.text,
                        "password": passwordCtr.value.text,
                        "username": usernameCtr.value.text,
                        "ipName": ipNameCtr.value.text,
                        "ipPwd": ipPwdCtr.value.text,
                        "port": portCtr.value.text,
                        "publicIP": publicIPCtr.value.text,
                        "dateTime": dateFormatted,
                      });
          
          
                      List<UserModel> userList = await PrefData.getUserData();
                      print("List=> ${userList.length}");
                      userList.add(UserModel(
                          ipName: ipNameCtr.value.text,
                          ipPwd: ipPwdCtr.value.text,
                          port: portCtr.value.text,
                          publicIP: publicIPCtr.value.text,
                          clientcode: clientcodeCtr.value.text,
                          secretKey: secretKeyCtr.value.text,
                          privateKey: privateKeyCtr.value.text,
                          password: passwordCtr.value.text,
                          username: usernameCtr.value.text));
          
          
                      List<String> userListForSp = [];
                      for (var item in userList) {
                        userListForSp.add(json.encode(item.toJson()));
                      }
          
                      PrefData.setUserData(userListForSp);
          
          
                      Helper().showMessage(message: "New User Added.");
                      Get.back();
                      homepageCtr.fetchDataOnly();
                      homepageCtr.update();
          
                    }
                  }
                },
              ),
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
