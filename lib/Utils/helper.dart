import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Helper {
  static List<String> typeList = ["NFO","BSE", "NSE",  "MCX", "BFO", "CDS"];

   showMessage({String? title,required String message}){
     // Get.snackbar(title??"", message).show();

     Fluttertoast.showToast(
         msg: message,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );

  }
}