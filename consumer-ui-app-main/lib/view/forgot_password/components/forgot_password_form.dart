// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'package:black_locust/controller/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/default_button.dart';
import '../../../const/size_config.dart';
import '../../../helper/validation_helper.dart';
import '../../../model/enum.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _controller = Get.find<ForgotPasswordController>();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error != null ? error : '');
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error != null ? error : '');
      });
  }

  var validationMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 30, top: 15),
        padding: const EdgeInsets.all(20),
        child: Obx(() => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Center(
                  //     child: Text(
                  //   "RINTEGER",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  // )),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  _controller.initialLogin.value == true
                      ? buildInitialForm()
                      : buildOtpForm(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    text: "Verify",
                    press: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _controller.initialLogin.value == true
                              ? _controller.accountLogin()
                              : _controller.verifyOtp();
                        }
                      }
                    },
                  ),
                ],
              ),
            )));
  }

  Container buildInitialForm() {
    final brightness = Theme.of(context).brightness;
    return Container(
      child: Column(children: [
        TextFormField(
            cursorColor:
                brightness == Brightness.dark ? Colors.white : Colors.black,
            decoration: const InputDecoration(
              hintText: 'Enter Email Id/Mobile Number',
              labelText: 'Email Id/Mobile Number *',
            ),
            controller: _controller.userIdController!,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              validationMsg = ValidationHelper.validate(InputType.text, value,
                  errorMsg: "EmailId/Mobile Number is required");
              return validationMsg != '' ? validationMsg : null;
            }),
      ]),
    );
  }

  Container buildOtpForm() {
    final brightness = Theme.of(context).brightness;
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          cursorColor:
              brightness == Brightness.dark ? Colors.white : Colors.black,
          decoration: InputDecoration(
            hintText: 'Enter Email Id/Mobile Number',
            labelText: 'Email Id/Mobile Number *',
          ),
          keyboardType: TextInputType.emailAddress,
          readOnly: true,
          controller: _controller.userIdController!,
          validator: (value) {
            validationMsg = ValidationHelper.validate(InputType.text, value,
                errorMsg: "EmailId/Mobile Number is required");
            return validationMsg != '' ? validationMsg : null;
          },
        ),
        if (_controller.initialLogin.value == false) ...[
          TextFormField(
            cursorColor:
                brightness == Brightness.dark ? Colors.white : Colors.black,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
              labelText: 'OTP *',
            ),
            controller: _controller.otpController!,
            keyboardType: TextInputType.number,
            validator: (value) {
              validationMsg = ValidationHelper.validate(InputType.text, value,
                  errorMsg: "OTP is required");
              return validationMsg != '' ? validationMsg : null;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  _controller.resendOtp();
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(color: Colors.blue),
                ),
              )),
        ]
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
