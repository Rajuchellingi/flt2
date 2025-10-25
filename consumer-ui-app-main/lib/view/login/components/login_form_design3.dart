// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member, camel_case_types, unused_local_variable

import 'package:black_locust/common_component/default_button_design2.dart';
import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/size_config.dart';
import '../../../helper/validation_helper.dart';
import '../../../model/enum.dart';

class LoginFormV2Design3 extends StatefulWidget {
  const LoginFormV2Design3({
    Key? key,
    required this.block,
  }) : super(key: key);

  final Map<String, dynamic> block;

  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<LoginFormV2Design3> {
  final _controller = Get.find<LoginV1Controller>();
  final _formKey = GlobalKey<FormState>();

  var validationMsg;

  @override
  Widget build(BuildContext context) {
    final forgotOption = ["password", "password-or-otp", "passwordand-otp"];

    final source = widget.block['source'] ?? {};
    final buttonName = source['buttonName'] ?? "Sign In";
    final raiseRequestLabel = source['isRaiseRequest'] ?? "";
    final title = source['title'] ?? "";
    final description = source['description'] ?? "";
    // print("raiseRequestLabel------------>>> ${raiseRequestLabel}");
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Obx(() {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      _controller.initialLogin.value
                          ? buildInitialForm(raiseRequestLabel)
                          : buildOtpForm(),
                      SizedBox(height: getProportionateScreenHeight(20)),

                      // ✅ Dynamic Raise Request
                      // if (forgotOption.contains(_controller
                      //     .loginSetting.value.loginAuthentication)) ...[
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 20),
                      //   alignment: Alignment.bottomRight,
                      //   child: GestureDetector(
                      //     onTap: () => _controller.ticketRaise("ticketRaise"),
                      //     child: Text(
                      //       raiseRequestLabel,
                      //       style: const TextStyle(color: Colors.orange),
                      //     ),
                      //   ),
                      // ),
                      // ],

                      // ✅ Dynamic Button
                      DefaultButtondesign2(
                        text: buttonName,
                        press: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _controller.initialLogin.value == true
                                  ? _controller.accountLogin("ticketLogin")
                                  : _controller.verifyOtpOrPassword();
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => Get.toNamed('/register'),
                            child: const Text(
                              'Sign up now',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget buildInitialForm(raiseRequestLabel) {
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
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () => _controller.ticketRaise("ticketRaise"),
            child: Text(
              raiseRequestLabel,
              style: const TextStyle(color: Colors.orange),
            ),
          ),
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
      print("authType ${authType}");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Email Id / Mobile Number *',
          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          // ),
          // const SizedBox(height: 6),
          // TextFormField(
          //   readOnly: true,
          //   cursorColor:
          //       brightness == Brightness.dark ? Colors.white : Colors.black,
          //   controller: _controller.userIdController,
          //   keyboardType: TextInputType.emailAddress,
          //   decoration: const InputDecoration(
          //     hintText: 'Enter Email Id / Mobile Number',
          //     border: OutlineInputBorder(),
          //     contentPadding:
          //         EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          //   ),
          //   validator: (value) {
          //     validationMsg = ValidationHelper.validate(
          //       InputType.text,
          //       value,
          //       errorMsg: "EmailId / Mobile Number is required",
          //     );
          //     return validationMsg != '' ? validationMsg : null;
          //   },
          // ),
          // const SizedBox(height: 20),
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
          ] else if (authType == 'password-or-otp') ...[
            // inside your widget
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _controller.useOtp.value ? 'OTP *' : 'Password *',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),

                  // Input box
                  TextFormField(
                    obscureText: !_controller.useOtp.value &&
                        !_controller.isVisible.value,
                    cursorColor: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    controller: _controller.useOtp.value
                        ? _controller.otpController
                        : _controller.passwordController,
                    keyboardType: _controller.useOtp.value
                        ? TextInputType.number
                        : TextInputType.text,
                    decoration: InputDecoration(
                      hintText: _controller.useOtp.value
                          ? 'Enter OTP'
                          : 'Enter Password',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      suffixIcon: !_controller.useOtp.value
                          ? IconButton(
                              icon: Icon(_controller.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: _controller.changePasswordVisible,
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (_controller.useOtp.value) {
                        validationMsg = ValidationHelper.validate(
                          InputType.text,
                          value,
                          errorMsg: "OTP is required",
                        );
                      } else {
                        validationMsg = ValidationHelper.validate(
                          InputType.password,
                          value,
                          errorMsg: "Password is required",
                        );
                      }
                      return validationMsg != '' ? validationMsg : null;
                    },
                  ),

                  const SizedBox(height: 10),

                  if (_controller.useOtp.value) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _controller.verifyResendOTP,
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        return TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // removes extra padding
                            minimumSize: Size(0, 0), // avoid reserved space
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap, // tighter fit
                          ),
                          onPressed: () {
                            if (_controller.useOtp.value) {
                              _controller.useOtp.value = false;
                            } else {
                              _controller.useOtp.value = true;
                              _controller.verifyResendOTP();
                            }
                          },
                          child: Text(
                            _controller.useOtp.value
                                ? "Use Password"
                                : "Use OTP",
                            style: const TextStyle(color: Colors.orange),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            })
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
