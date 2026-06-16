import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  VoidCallback? onPress;
  bool customView;
  Widget? widget;
  String text;

  AppButton(
      {this.onPress, this.customView = false, this.widget, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: onPress,
      child: customView ? widget : Text(text),
    );
  }
}
