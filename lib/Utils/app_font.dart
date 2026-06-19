import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Font {
  Font._();

  static TextStyle title1({Color color = Colors.white}) => GoogleFonts.urbanist(
      fontSize: Get.width * 0.07,
      color: color,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.9);

  static TextStyle title2({Color color = Colors.white}) => GoogleFonts.urbanist(
      fontSize: Get.width * 0.06,
      color: color,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.9);

  static TextStyle subTitle1({Color color = Colors.white}) =>
      GoogleFonts.urbanist(
          fontSize: Get.width <= 550
              ? Get.width * 0.05
              : Get.width <= 770
                  ? Get.width * 0.03
                  : Get.width * 0.025,
          color: color,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.9);

  static TextStyle subTitle2({Color color = Colors.white}) =>
      GoogleFonts.urbanist(
          fontSize: Get.width <= 550
              ? Get.width * 0.05
              : Get.width <= 770
                  ? Get.width * 0.03
                  : Get.width * 0.025,
          color: color,
          letterSpacing: 0.9);

  static TextStyle bodyText1({Color color = Colors.white}) =>
      GoogleFonts.urbanist(
          fontSize: Get.width <= 550 ? Get.width * 0.04 : Get.width * 0.025,
          color: color,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.9);

  static TextStyle bodyText2({Color color = Colors.white}) =>
      GoogleFonts.urbanist(
          fontSize: Get.width <= 550 ? Get.width * 0.04 : Get.width * 0.025,
          color: color,
          letterSpacing: 0.9);

  static TextStyle bodyText3({Color color = Colors.white}) =>
      GoogleFonts.urbanist(
          fontSize: Get.width * 0.03, color: color, letterSpacing: 0.4);

  static TextStyle label1({Color color = Colors.white}) => GoogleFonts.urbanist(
      fontSize: Get.width <= 550
          ? Get.width * 0.033
          : Get.width <= 450
              ? Get.width * 0.028
              : Get.width * 0.022,
      color: color,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.9);

  static TextStyle label1system({Color color = Colors.white}) => TextStyle(
      fontSize: Get.width <= 400
          ? Get.width * 0.022
          : Get.width <= 550
              ? Get.width * 0.033
              : Get.width <= 770
                  ? Get.width * 0.027
                  : Get.width * 0.022,
      color: color,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4);

  static TextStyle label2({Color color = Colors.white}) => GoogleFonts.urbanist(
      fontSize: Get.width <= 550 ? Get.width * 0.033 : Get.width * 0.022,
      color: color,
      letterSpacing: 0.9);

  static TextStyle label3({Color color = Colors.white}) => TextStyle(
        fontSize: Get.width <= 550 ? Get.width * 0.025 : Get.width * 0.018,
        color: color,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.9,
      );

  static TextStyle text(
          {Color? color, double? size, FontWeight? weight, double? space}) =>
      TextStyle(
          fontSize: size ?? Get.width * 0.035,
          color: color ?? Colors.white,
          fontWeight: weight,
          letterSpacing: space);

  static TextStyle systemTxtStyle(
          {Color color = Colors.white,
          double stroke = 1.6,
          double? size,
          double? space,
          FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Get.width * 0.09,
          fontWeight: weight ?? FontWeight.w600,
          letterSpacing: space ?? 2.5,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = stroke
            ..color = color);
}
