import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treding/Screens/add_user_secreen.dart';
import 'package:treding/Utils/app_font.dart';
import 'package:treding/Utils/material_color_generator.dart';
import 'package:treding/extra_clone_modules/controllers/new_home_controller.dart';

import 'new_add_user_screens.dart';

class NewUserManagementScreen extends StatefulWidget {
  const NewUserManagementScreen({super.key});

  @override
  State<NewUserManagementScreen> createState() => _NewUserManagementScreenState();
}

class _NewUserManagementScreenState extends State<NewUserManagementScreen> {

  final NewHomepageCtr homepageCtr = Get.isRegistered<NewHomepageCtr>()
      ? Get.find<NewHomepageCtr>()
      : Get.put(NewHomepageCtr());

  @override
  Widget build(BuildContext context) {
    homepageCtr.GetUserData2();
    return Scaffold(  appBar:AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.purple,
      title:  Text('All User List',style: Font.bodyText1()),
      actions: [
        IconButton(onPressed: (){
          Get.to(() => NewAddUserScreens());
        }, icon: const Icon(Icons.person_add))
      ],
    ),
      body: GetBuilder(
          init: homepageCtr,
          builder: (ctr) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: homepageCtr.newuserList.length,
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
                                        .newuserList[index].clientcode ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("User Name : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .newuserList[index].username ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("PNL :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .newuserList[index].PNL ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("Current balance : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .newuserList[index].currentBalance ??
                                        "-")
                                  ],),
                                  Row(children: [
                                    const Text("Lot Size : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(homepageCtr
                                        .newuserList[index].userLotSize ??
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
                                            homepageCtr.newuserList[index], index);
                                        // deletedata(keyvalue: homepageCtr.userList[index].clientcode.toString());
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:     InkWell(
                                      onTap: () {
                                        Get.to(() => NewAddUserScreens(
                                          forEdit: true,
                                          userModel:
                                          homepageCtr.newuserList[index],
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
}
