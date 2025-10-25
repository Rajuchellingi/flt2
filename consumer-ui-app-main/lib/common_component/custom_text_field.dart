// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';

// import '../../controller/sign_up_controller.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {Key? key,
      required this.textEditingController,
      this.hintText,
      this.labelText,
      this.inputType,
      required controller,
      this.isReadOnly,
      this.onTap,
      this.errorMsg,
      this.enabled = true,
      this.suffixIcon,
      this.onSuffixTap,
      this.onTextChange,
      this.onValidate,
      this.passwordController,
      this.maxlength,
      this.pattern,
      this.required,
      this.focusNode,
      this.fieldName,
      this.isTextChanged = false,
      this.isPhoneCode = false,
      this.isLightTheam = false,
      this.isSuffixButton = false,
      this.suffixButtonTxt = ""})
      : _controller = controller,
        super(key: key);

  final String? errorMsg;
  final String? labelText;
  final bool? enabled;
  final String? hintText;
  final TextEditingController textEditingController;
  final TextEditingController? passwordController;
  final IconData? suffixIcon;
  bool isPhoneCode = false;
  bool suffixButton = false;
  String suffixButtonText = "";
  final InputType? inputType;
  final _controller;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onSuffixTap;
  final Function? onTextChange;
  final bool? isReadOnly;
  final bool? isTextChanged;
  String? fieldName;
  FocusNode? focusNode;
  Function? onValidate;
  final bool? isLightTheam;
  final int? maxlength;
  final bool? isSuffixButton;
  final bool? required;
  final String? suffixButtonTxt;
  final String? pattern;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var validationMsg;
    suffixButton = isSuffixButton!;
    suffixButtonText = suffixButtonTxt!;
    return TextFormField(
      focusNode: focusNode != null ? focusNode : null,
      enabled: enabled!,
      cursorColor: brightness == Brightness.dark ? Colors.white : Colors.black,
      obscureText: inputType == InputType.password ? true : false,
      readOnly: isReadOnly != null ? isReadOnly! : false,
      keyboardType: buildTextInputType(inputType),
      maxLines: inputType == InputType.multiLine ? null : 1,
      maxLength: maxlength,
      controller: textEditingController,
      onChanged: (value) {
        if (isTextChanged!) {
          onTextChange!(value);
        }

        //removeValidateError(value, inputType, errorMsg);
      },
      validator: (value) {
        if (errorMsg != null && errorMsg!.isNotEmpty) {
          validationMsg =
              ValidationHelper.validate(inputType!, value, errorMsg: errorMsg!);
          if (validationMsg != '') {
            if (onValidate != null) onValidate!(fieldName);
            return validationMsg;
          }
        }
        if (value != null &&
            value.isNotEmpty &&
            pattern != null &&
            pattern!.isNotEmpty) {
          var regex = RegExp(pattern!);
          if (!regex.hasMatch(value)) {
            if (onValidate != null) onValidate!(fieldName);
            return getValidationMessage(labelText!);
          }
        }
        if (value != null &&
            value.isNotEmpty &&
            fieldName == 'confirmPassword' &&
            value != passwordController?.text) {
          return "Password and confirm password must match";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: isPhoneCode ? buildPhoneCodePrefix() : null,
        labelText: required == true ? labelText! + '*' : labelText,
        hintText: hintText,
        suffix: suffixButton
            ? InkWell(
                onTap: onSuffixTap,
                child: Text(suffixButtonText,
                    style: const TextStyle(
                        color: kTextColor, fontWeight: FontWeight.w600)),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.only(
            top: 35,
            left: 15,
            right: 15,
            bottom: 10), //EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        enabledBorder: brightness == Brightness.dark
            ? darkOutlineInputBorder
            : outlineInputBorder,
        focusedBorder: brightness == Brightness.dark
            ? darkOutlineInputBorder
            : outlineInputBorder,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
          gapPadding: 8,
        ),
      ),
    );
  }

  Padding buildPhoneCodePrefix() {
    return Padding(
      padding: const EdgeInsets.all(2),
      // child: Text(
      //   '+91',
      //   style: TextStyle(fontSize: 16),
      // ),
    );
  }

  getValidationMessage(String message) {
    String modifiedMessage = message.split(' ').map((word) {
      return word[0].toLowerCase() + word.substring(1);
    }).join(' ');
    return "Enter a valid $modifiedMessage";
  }

  final OutlineInputBorder darkOutlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.white),
    gapPadding: 8,
  );
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kPrimaryColor),
    gapPadding: 8,
  );
  TextInputType buildTextInputType(type) {
    switch (type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.password:
        return TextInputType.text;
      case InputType.number:
        return TextInputType.number;
      case InputType.phone:
        return TextInputType.number;
      case InputType.multiLine:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
}
