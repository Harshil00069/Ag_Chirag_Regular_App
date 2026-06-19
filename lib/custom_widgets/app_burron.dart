import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  VoidCallback? onPress;
  bool customView;
  Widget? widget;
  String text;
  bool isLoading;

  AppButton(
      {this.onPress, this.customView = false, this.widget, this.text = "",this.isLoading =false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: onPress,
      child: customView ? widget : isLoading? SizedBox(height: 20,width: 20,
          child: CircularProgressIndicator()): Text(text),
    );
  }
}
