// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member, camel_case_types

import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/default_button.dart';
import '../../../const/size_config.dart';
import '../../../helper/validation_helper.dart';
import '../../../model/enum.dart';

class LoginFormV1 extends StatefulWidget {
  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<LoginFormV1> {
  final _controller = Get.find<LoginV1Controller>();
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
    var forgotOption = ["password", "password-or-otp", "passwordand-otp"];
    final brightness = Theme.of(context).brightness;
    // print("_controller.initialLogin ${_controller.userDetailsResponse.value}");
    return Container(
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        margin: const EdgeInsets.only(bottom: 30, top: 15),
        padding: const EdgeInsets.all(20),
        child: Obx(() => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //     child: Text(
                  //   "RINTEGER",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  // )),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  _controller.initialLogin.value == true
                      ? buildInitialForm()
                      : buildOtpForm(),
                  SizedBox(height: getProportionateScreenHeight(20)),

                  if (forgotOption.contains(
                      _controller.loginSetting.value.loginAuthentication)) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTap: () async {
                            Get.toNamed('/forgotPassword',
                                preventDuplicates: false);
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ),
                  ],

                  DefaultButton(
                    text: "Continue",
                    press: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _controller.initialLogin.value == true
                              ? _controller.accountLogin("login")
                              : _controller.verifyOtpOrPassword();
                        }
                      }
                    },
                  ),
                  if (_controller.initialLogin.value == true) ...[
                    SizedBox(height: 15),
                    Row(children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5),
                      Container(
                        // margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                            onTap: () async {
                              Get.toNamed('/register',
                                  preventDuplicates: false,
                                  arguments: Get.arguments);
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ),
                    ]),
                  ]
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
    var passwordOptions = ["password", "password-or-otp", "passwordand-otp"];

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
        if (_controller.userDetailsResponse.value['authenticate'] == 'otp') ...[
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
          GestureDetector(
            onTap: () {
              _controller.verifyResendOTP();
            },
            child: Text(
              'Resend OTP',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ] else if (passwordOptions.contains(
            _controller.userDetailsResponse.value['authenticate'])) ...[
          TextFormField(
            cursorColor:
                brightness == Brightness.dark ? Colors.white : Colors.black,
            obscureText: _controller.isVisible.value ? false : true,
            decoration: InputDecoration(
              hintText: 'Enter Password',
              labelText: 'Password *',
              suffixIcon: IconButton(
                icon: Icon(_controller.isVisible.value == true
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  _controller.changePasswordVisible();
                },
              ),
            ),
            controller: _controller.passwordController!,
            validator: (value) {
              validationMsg = ValidationHelper.validate(
                  InputType.password, value,
                  errorMsg: "Password is required");
              return validationMsg != '' ? validationMsg : null;
            },
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 15),
          //   alignment: Alignment.bottomRight,
          //   child: GestureDetector(
          //       onTap: () async {
          //         Get.toNamed('/forgotPassword', preventDuplicates: false);
          //       },
          //       child: Text(
          //         "Forgot Password",
          //         style: TextStyle(color: Colors.blue),
          //       )),
          // )
        ]
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
