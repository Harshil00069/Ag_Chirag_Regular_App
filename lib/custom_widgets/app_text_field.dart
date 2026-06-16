import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/color_const.dart';


class RegTxtField extends StatelessWidget {
  TextEditingController? ctr;
  double radius;
  String labelText;
  String hintTxt;
  FormFieldValidator<dynamic>? validator;
  Widget? prefix;
  TextInputType? keyboardType;
  int? maxLength;
  bool isReadOnly;
  bool passwordVisible;
  bool showPwdIcon;
  VoidCallback? onTap;
  VoidCallback? onTapIcon;
  List<TextInputFormatter>? inputFormatters;
  ValueChanged<String>? onChanged;

  RegTxtField(
      {this.ctr,
        this.radius = 10,
        this.labelText = "",
        this.hintTxt = "",
        this.validator,
        this.prefix,
        this.isReadOnly = false,
        this.passwordVisible = false,
        this.showPwdIcon = false,
        this.keyboardType = TextInputType.text,
        this.maxLength,
        this.onTap,
        this.onTapIcon,
        this.inputFormatters,
        this.onChanged,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,
      child: TextFormField(style: const TextStyle(fontSize: 14),
        controller: ctr,
        readOnly: isReadOnly,
        inputFormatters: inputFormatters,
        validator: validator,
        keyboardType: keyboardType,
        // autofocus: true,
        obscureText: showPwdIcon && !passwordVisible,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: ColorConst.txtBgColor,
          filled: true,
          suffixIcon: showPwdIcon ? IconButton(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: ColorConst.headerColor,
            ),
            onPressed: onTapIcon,
          ) : SizedBox.shrink(),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor,
            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor, // Set your desired header color here
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
              color: ColorConst.headerColor,
          ),
          focusColor: ColorConst.headerColor,
          hintText: hintTxt,
          // hintStyle: TextStyle(
          //     color: Colors.red
          // ),
          prefixIcon: prefix,
          // prefixIconConstraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          // alignLabelWithHint: true,
        ),
        onChanged: onChanged,
        maxLength: maxLength,
        onTap: onTap,
      ),
    );
  }
}
