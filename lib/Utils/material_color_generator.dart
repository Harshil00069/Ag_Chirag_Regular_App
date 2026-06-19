import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  static MaterialColor primaryColor = generateMaterialColor(
    color: const Color(0xFF006CEB),
  );

  static MaterialColor secondaryColor = generateMaterialColor(
    color: const Color(0xFFEC8101),
  );

  static const MaterialColor grey = Colors.grey;
  static const Color active = Color.fromRGBO(193, 114, 11, 0.1);
  static const Color inActive = Color.fromRGBO(231, 231, 231, 0.5);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color purple = Colors.deepPurple;

  static MaterialColor generateMaterialColor({required Color color}) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}

String greetings() {
  int hour = TimeOfDay.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour <= 16) {
    return "Good Afternoon";
  } else if (hour > 16 && hour < 20) {
    return "Good Evening";
  } else {
    return "Hello";
  }
}
