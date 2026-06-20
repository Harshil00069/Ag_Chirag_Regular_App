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
    return SizedBox(
      height: 40,
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        controller: ctr,
        readOnly: isReadOnly,
        inputFormatters: inputFormatters,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: showPwdIcon && !passwordVisible,
        decoration: InputDecoration(
          fillColor: ColorConst.txtBgColor,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          suffixIcon: showPwdIcon
              ? IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 35,
              minHeight: 35,
            ),
            icon: Icon(
              passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: ColorConst.headerColor,
            ),
            onPressed: onTapIcon,
          )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 35,
            minHeight: 35,
          ),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: ColorConst.txtBgColor,
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: ColorConst.headerColor,
          ),
          hintText: hintTxt,
          prefixIcon: prefix,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onChanged: onChanged,
        maxLength: maxLength,
        onTap: onTap,
      ),
    );
  }
}
