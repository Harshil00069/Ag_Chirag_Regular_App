import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totp/totp.dart';

import '../Api/api_implementor.dart';
import '../Utils/helper.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController usernumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ApiImplementor. profileApi();
    // ApiImplementor.getLtpData();
  }

  //My totp :- NDSLNN7WBTZGNX75GS7WMBJIDE

  List<MyTest> widgetList = [];
  List<String> selectedDropDoen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("demo")),
      body: Column(
        children: [
          // TextFormField(controller: usernumber,),

          InkWell(
              onTap: () {
                // ApiImplementor.getVersionInfoApiImplementer();
              },
              child: const Text("Login key")),
          InkWell(
              onTap: () {
// ApiImplementor.generateTokensApi(tolen: usernumber.text);
                ApiImplementor.profileApi();
              },
              child: const Text("generateTokens")),
          InkWell(
              onTap: () {
                ApiImplementor.logout();
              },
              child: const Text("Logout")),
          //get totp
          InkWell(
              onTap: () {
                /// default initialization for intervals of 30 seconds and 6 digit tokens
                TOTP totp =
                    TOTP(secret: "44YEC4CXXCKAVX3AK3MBK3WMAQ", digits: 6);

                /// initialization for custom interval and digit values
                //  TOTP totp = TOTP(secret: "J22U6B3WIWRRBTAV", interval: 60, digits: 8);

                print(totp.now());

                /// => 432143

                // /// verify for the current time
                // totp.verify(otp: 432143); /// => true
                //
                // /// verify after 30s
                // totp.verify(otp: 432143); ///
              },
              child: const Text("Get Totp")), //get totp

          InkWell(
              onTap: () {
                // ApiImplementor.getLtpData();
              },
              child: const Text("Get Price")),


          InkWell(
              onTap: () {
                print(widgetList.map((e) => e.selected));
              },
              child: const Text("Print My Data")),
          InkWell(
              onTap: () {
                widgetList.add(MyTest());
                setState(() {});
              },
              child: const Text("Add View")),
          ...widgetList
        ],
      ),
    );
  }

}

class TestModel {
  Widget myWidget;
  String selectedDropDown;
  ValueChanged<dynamic>? onChanged;

  TestModel(
      {required this.myWidget, required this.selectedDropDown, this.onChanged});
}

class MyTest extends StatelessWidget {
  MyTest({Key? key}) : super(key: key);

  String selected="-";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: DropdownSearch<String>(
          popupProps: PopupProps.menu(),
          items: Helper.typeList,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: "Type",
            ),
          ),
          selectedItem: selected,
          onChanged: (val) {
            selected=val??"-";
            print(val);
          }),
    );
  }
}

