import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Api/api_implementor.dart';
import 'package:treding/Screens/add_user_secreen.dart';
import 'package:treding/Screens/order_screen.dart';

import '../Controllers/homepage_controller.dart';
import '../Utils/app_font.dart';
import '../Utils/material_color_generator.dart';
import '../custom_widgets/app_burron.dart';
import 'package:dio/dio.dart' as dio;

class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({Key? key}) : super(key: key);
  HomepageCtr homepageCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    homepageCtr.GetUserData();
    return Scaffold(  appBar:AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryColor,
        title:  Text('All User List',style: Font.bodyText1()),
      actions: [
        IconButton(onPressed: (){
          Get.to(() => AddUserScreen());
        }, icon: const Icon(Icons.person_add))
      ],
    ),
      body: GetBuilder(
          init: homepageCtr,
          builder: (ctr) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: homepageCtr.userList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: Get.width*0.80,
                                child: Column(children: [
                                  Row(children: [
                                    const Text("Client Code : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .userList[index].clientcode ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("User Name : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .userList[index].username ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("PNL :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .userList[index].PNL ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("Current balance : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .userList[index].currentBalance ??
                                        "-")
                                  ],),
                                ],),
                              ),
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:     InkWell(
                                      onTap: () {
                                        homepageCtr.deleteUser(
                                            homepageCtr.userList[index], index);
                                        // deletedata(keyvalue: homepageCtr.userList[index].clientcode.toString());
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:     InkWell(
                                      onTap: () {
                                        Get.to(() => AddUserScreen(
                                          forEdit: true,
                                          userModel:
                                          homepageCtr.userList[index],
                                          index: index,
                                        ));
                                      },
                                      child: const Icon(Icons.edit)),
                                ),
                              ],)

                            ],),
                        ],),),
                  );
                });
          }),
    );
  }
  Future<void> deletedata({required String keyvalue})async {
    FirebaseDatabase.instance.ref("Users").child(keyvalue).remove();

  }
}
