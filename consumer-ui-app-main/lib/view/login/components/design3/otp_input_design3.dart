// ignore_for_file: must_be_immutable, unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms_autofill/sms_autofill.dart';

// import '../../controller/sign_up_controller.dart';

class OtpInputDesign3 extends StatefulWidget {
  OtpInputDesign3(
      {Key? key,
      required this.textEditingController,
      this.newPasswordController,
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
  final TextEditingController? newPasswordController;
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
  _InputDesign3State createState() => _InputDesign3State();
}

class _InputDesign3State extends State<OtpInputDesign3> with CodeAutoFill {
  bool isValid = true;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    listenForCode();
    getAppSignature();
    _focusNode.addListener(_onFocusChange);
  }

  Future<void> getAppSignature() async {
    try {
      var signature = await SmsAutoFill().getAppSignature;
      print("App Signature: $signature");
    } catch (e) {
      print("Failed to get app signature: $e");
    }
  }

  @override
  void codeUpdated() {
    print('codeeeee $code');
    widget.textEditingController.text = code!;
    setState(() {
      isValid = true;
    });
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      print("Input field gained focus");
    } else {
      var value = widget.textEditingController.text;
      if (widget.errorMsg != null && widget.errorMsg!.isNotEmpty) {
        var validationMsg = ValidationHelper.validate(widget.inputType!, value,
            errorMsg: widget.errorMsg!);
        if (validationMsg != '') {
          setState(() {
            isValid = false;
          });
          return;
        }
      }
      if (value != null &&
          value.isNotEmpty &&
          widget.pattern != null &&
          widget.pattern!.isNotEmpty) {
        var regex = RegExp(widget.pattern!);
        if (!regex.hasMatch(value)) {
          setState(() {
            isValid = false;
          });
          return;
        }
      }
      setState(() {
        isValid = true;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    var validationMsg;
    widget.suffixButton = widget.isSuffixButton!;
    widget.suffixButtonText = widget.suffixButtonTxt!;
    return Container(
        child: TextFormField(
      style: TextStyle(
          color:
              brightness == Brightness.dark ? Colors.white : kPrimaryTextColor),
      focusNode: _focusNode,
      enabled: widget.enabled!,
      cursorColor:
          brightness == Brightness.dark ? Colors.white : kPrimaryTextColor,
      obscureText: widget.inputType == InputType.password ? true : false,
      readOnly: widget.isReadOnly != null
          ? widget.isReadOnly!
          : widget.inputType == InputType.date
              ? true
              : false,
      autofillHints:
          widget.fieldName == 'otp' ? const [AutofillHints.oneTimeCode] : null,
      keyboardType: buildTextInputType(widget.inputType),
      maxLines: widget.inputType == InputType.multiLine ? 3 : 1,
      maxLength: widget.maxlength,
      onTap: () async {
        if (widget.inputType == InputType.date)
          await showDatePicker(
            context: context,
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.blue,
                  colorScheme: ColorScheme.light(
                    primary: kPrimaryColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
            initialDate: widget.textEditingController.text != null &&
                    widget.textEditingController.text.isNotEmpty
                ? DateFormat("yyyy-MM-dd")
                    .parse(widget.textEditingController.text)
                : DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          ).then((selectedDate) {
            if (selectedDate != null) {
              widget.textEditingController.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            }
          });
      },
      controller: widget.textEditingController,
      onChanged: (value) {
        if (widget.isTextChanged!) {
          widget.onTextChange!(value);
        }

        //removeValidateError(value, inputType, errorMsg);
      },
      validator: (value) {
        if (widget.errorMsg != null && widget.errorMsg!.isNotEmpty) {
          validationMsg = ValidationHelper.validate(widget.inputType!, value,
              errorMsg: widget.errorMsg!);
          if (validationMsg != '') {
            if (widget.onValidate != null) widget.onValidate!(widget.fieldName);
            setState(() {
              isValid = false;
            });
            return validationMsg;
          }
        }
        if (value != null &&
            value.isNotEmpty &&
            widget.pattern != null &&
            widget.pattern!.isNotEmpty) {
          var regex = RegExp(widget.pattern!);
          if (!regex.hasMatch(value)) {
            if (widget.onValidate != null) widget.onValidate!(widget.fieldName);
            setState(() {
              isValid = false;
            });
            return getValidationMessage(widget.labelText!);
          }
        }
        if (value != null &&
            value.isNotEmpty &&
            widget.fieldName == 'confirmPassword' &&
            value != widget.newPasswordController?.text) {
          setState(() {
            isValid = false;
          });
          return "Password and confirm password must match";
        }
        setState(() {
          isValid = true;
        });
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 11, color: Color(0xFFF01F0E)),
        isDense: true,

        prefixIcon: widget.isPhoneCode ? buildPhoneCodePrefix() : null,
        labelText: widget.labelText,
        // hintText: hintText,
        labelStyle: TextStyle(
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor),
        fillColor: brightness == Brightness.light ? Colors.white : Colors.black,
        filled: true,
        suffixIcon: (widget.isReadOnly == true || widget.enabled == false)
            ? null
            : !isValid
                ? Icon(
                    Icons.clear,
                    color: Color(0xFFF01F0E),
                  )
                : (widget.textEditingController.text != null &&
                        widget.textEditingController.text.isNotEmpty)
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        floatingLabelStyle: TextStyle(
            fontSize: 14,
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        enabledBorder: outlineInputBorder,
        errorBorder: errorInputBorder,
        focusedErrorBorder: errorInputBorder,
        focusedBorder: outlineInputBorder,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
          gapPadding: 8,
        ),
      ),
    ));
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

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.grey.shade300),
    gapPadding: 2,
  );

  final OutlineInputBorder errorInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Color(0xFFF01F0E)),
    gapPadding: 2,
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
