// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../../controller/sign_up_controller.dart';

class CustomTextFieldV1 extends StatelessWidget {
  CustomTextFieldV1(
      {Key? key,
      required this.textEditingController,
      this.hintText,
      this.labelText,
      this.label,
      this.inputType,
      required controller,
      this.isReadOnly,
      this.onTap,
      this.errorMsg,
      this.enabled = true,
      this.suffixIcon,
      this.onSuffixTap,
      this.onTextChange,
      this.maxlength,
      this.minlength,
      this.pattern,
      this.focusNode,
      this.fieldName,
      this.onValidate,
      this.isTextChanged = false,
      this.isPhoneCode = false,
      this.isLightTheam = false,
      this.isSuffixButton = false,
      this.suffixButtonTxt = ""})
      : _controller = controller,
        super(key: key);

  final String? errorMsg;
  final String? labelText;
  final String? label;
  final bool? enabled;
  final String? hintText;
  final String? pattern;
  final TextEditingController textEditingController;
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
  final bool? isLightTheam;
  final int? maxlength;
  final int? minlength;
  String? fieldName;
  FocusNode? focusNode;
  Function? onValidate;
  final bool? isSuffixButton;
  final String? suffixButtonTxt;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var validationMsg;
    suffixButton = isSuffixButton!;
    suffixButtonText = suffixButtonTxt!;
    return TextFormField(
      enabled: enabled!,
      cursorColor: brightness == Brightness.dark ? Colors.white : Colors.black,
      focusNode: focusNode != null ? focusNode : null,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'^\s*$')),
        if (InputType.number == inputType)
          FilteringTextInputFormatter.digitsOnly, // Only allow digits (numbers)
        if (fieldName == 'pincode') LengthLimitingTextInputFormatter(6),
      ],
      obscureText: inputType == InputType.password ? true : false,
      readOnly: isReadOnly != null ? isReadOnly! : false,
      keyboardType: buildTextInputType(inputType),
      maxLines: inputType == InputType.multiLine ? null : 1,
      maxLength: maxlength,
      // minLength: minlength,
      controller: textEditingController,
      onChanged: (value) {
        if (isTextChanged == true) {
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
            maxlength != null &&
            minlength != null &&
            value.isNotEmpty) {
          if (value.length != maxlength && value.length != minlength) {
            if (onValidate != null) onValidate!(fieldName);
            return "$labelText must be exactly $minlength characters long";
          }
        }
        if (value != null &&
            value.isNotEmpty &&
            pattern != null &&
            pattern!.isNotEmpty) {
          var convertedPattern = convertJsRegexToFlutter(pattern!);
          var regex = RegExp(convertedPattern);
          if (!regex.hasMatch(value)) {
            if (onValidate != null) onValidate!(fieldName);
            return "Enter a Valid ${labelText ?? label}";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: brightness == Brightness.dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17),
        isDense: true,
        prefixIcon: isPhoneCode ? buildPhoneCodePrefix() : null,
        labelText: labelText,
        hintText: hintText,
        suffix: suffixButton
            ? InkWell(
                onTap: onSuffixTap,
                child: Text(suffixButtonText,
                    style: const TextStyle(
                        color: kTextColor, fontWeight: FontWeight.w600)),
              )
            : suffixIcon != null
                ? InkWell(onTap: onSuffixTap, child: Icon(suffixIcon))
                : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: isLightTheam! ? kPrimaryColor : kTextColor),
          gapPadding: 8,
        ),
      ),
    );
  }

  Container buildPhoneCodePrefix() {
    return Container(
        width: 50,
        padding: const EdgeInsets.fromLTRB(10, 11, 10, 5),
        child: Align(
          alignment: Alignment.center,
          child: const Text(
            '+91',
            style: const TextStyle(fontSize: 16),
          ),
        ));
  }

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
      case InputType.multiLine:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  String convertJsRegexToFlutter(String jsRegex) {
    return jsRegex.replaceAll(r"\\", r"\");
  }
}
