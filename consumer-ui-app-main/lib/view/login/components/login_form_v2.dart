// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member, camel_case_types, unnecessary_null_comparison

import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/default_button.dart';
import '../../../const/size_config.dart';
import '../../../helper/validation_helper.dart';
import '../../../model/enum.dart';

class LoginFormV2 extends StatefulWidget {
  const LoginFormV2({
    Key? key,
    required this.block,
  }) : super(key: key);

  final Map<String, dynamic> block;
  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<LoginFormV2> {
  final _controller = Get.find<LoginV1Controller>();
  final themeController = Get.find<ThemeController>();
  final _formKey = GlobalKey<FormState>();

  var validationMsg;

  @override
  Widget build(BuildContext context) {
    final forgotOption = ["password", "password-or-otp", "passwordand-otp"];

    return Container(
      color: Colors.blue,
      height: SizeConfig.screenHeight - 90,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.block['source']['image'] != null &&
                  widget.block['source']['image'].isNotEmpty) ...[
                Center(
                  child: Image.network(
                    widget.block['source']['image'],
                    height: 200,
                  ),
                )
              ],
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 12,
                  //     offset: Offset(0, 6),
                  //   ),
                  // ],
                ),
                child: Obx(() {
                  return Column(
                    children: [
                      if (themeController.logo.value != null &&
                          themeController.logo.value.isNotEmpty)
                        Image.network(themeController.logo.value, height: 50),
                      if (widget.block['source']['title'] != null &&
                          widget.block['source']['title'].isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(
                          widget.block['source']['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                      if (widget.block['source']['description'] != null &&
                          widget.block['source']['description'].isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          widget.block['source']['description'],
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                      const SizedBox(height: 30),
                      _controller.initialLogin.value
                          ? buildInitialForm()
                          : buildOtpForm(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      if (forgotOption.contains(_controller
                          .loginSetting.value.loginAuthentication)) ...[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () => Get.toNamed('/forgotPassword',
                                preventDuplicates: false),
                            child: const Text(
                              "Forgot your password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
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
                              //  ? _controller.accountLogin()
                              // : _controller.verifyOtpOrPassword();
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => Get.toNamed('/register'),
                            child: const Text(
                              'Sign up now',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if (_controller.initialLogin.value) ...[
                      //   const SizedBox(height: 15),
                      //   Row(
                      //     children: [
                      //       const Text("Don't have an account?"),
                      //       const SizedBox(width: 5),
                      //       GestureDetector(
                      //         onTap: () => Get.toNamed('/register'),
                      //         child: const Text(
                      //           'Sign up now',
                      //           style: TextStyle(
                      //             color: Colors.green,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ],
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialForm() {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Id / Mobile Number *',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextFormField(
          cursorColor:
              brightness == Brightness.dark ? Colors.white : Colors.black,
          controller: _controller.userIdController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter Email Id / Mobile Number',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: (value) {
            validationMsg = ValidationHelper.validate(
              InputType.text,
              value,
              errorMsg: "EmailId / Mobile Number is required",
            );
            return validationMsg != '' ? validationMsg : null;
          },
        ),
      ],
    );
  }

  Widget buildOtpForm() {
    final brightness = Theme.of(context).brightness;
    final passwordOptions = ["password", "password-or-otp", "passwordand-otp"];

    return Obx(() {
      String authType =
          _controller.userDetailsResponse.value['authenticate'] ?? '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email Id / Mobile Number *',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          TextFormField(
            readOnly: true,
            cursorColor:
                brightness == Brightness.dark ? Colors.white : Colors.black,
            controller: _controller.userIdController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter Email Id / Mobile Number',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            validator: (value) {
              validationMsg = ValidationHelper.validate(
                InputType.text,
                value,
                errorMsg: "EmailId / Mobile Number is required",
              );
              return validationMsg != '' ? validationMsg : null;
            },
          ),
          const SizedBox(height: 20),
          if (authType == 'otp') ...[
            const Text(
              'OTP *',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextFormField(
              cursorColor:
                  brightness == Brightness.dark ? Colors.white : Colors.black,
              controller: _controller.otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              validator: (value) {
                validationMsg = ValidationHelper.validate(
                  InputType.text,
                  value,
                  errorMsg: "OTP is required",
                );
                return validationMsg != '' ? validationMsg : null;
              },
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _controller.verifyResendOTP,
              child: const Text(
                'Resend OTP',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ] else if (passwordOptions.contains(authType)) ...[
            const Text(
              'Password *',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Obx(() => TextFormField(
                  obscureText: !_controller.isVisible.value,
                  cursorColor: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  controller: _controller.passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(_controller.isVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _controller.changePasswordVisible,
                    ),
                  ),
                  validator: (value) {
                    validationMsg = ValidationHelper.validate(
                      InputType.password,
                      value,
                      errorMsg: "Password is required",
                    );
                    return validationMsg != '' ? validationMsg : null;
                  },
                )),
          ],
        ],
      );
    });
  }
}
