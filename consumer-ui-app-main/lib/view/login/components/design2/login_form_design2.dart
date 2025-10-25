// ignore_for_file: unused_element

import 'package:black_locust/common_component/form_error.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design2/input_design2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormDesign2 extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<LoginFormDesign2> {
  final _controller = Get.find<LogInController>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          if (_controller.isPrizma.value == true)
            buildOTPField()
          else
            buildCustomField(),
          if (_controller.isPrizma.value == false) ...[
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/forgotPassword');
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                ))
          ],
          FormError(errors: errors),
          const SizedBox(height: 25),
          GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                border: Border.all(
                    color: brightness == Brightness.dark
                        ? kPrimaryColor == Colors.black
                            ? Colors.white
                            : kPrimaryColor
                        : kPrimaryColor),
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
              child: const Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 16,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              if (_controller.formKey.currentState!.validate()) {
                _controller.formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                if (_controller.isPrizma.value == true) {
                  _controller.loginWithMobileNumber();
                } else {
                  _controller.loginWithEmail(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildOTPField() {
    return Obx(() => Column(
          children: [
            InputDesign2(
              textEditingController: _controller.phoneNumberController!,
              hintText: "Mobile Number",
              labelText: "Enter Mobile Number",
              errorMsg: 'Enter Valid Mobile Number',
              inputType: InputType.number,
              enabled: _controller.isOtp.value == false,
              controller: _controller,
            ),
            if (_controller.isOtp.value == true) ...[
              SizedBox(height: kDefaultPadding),
              InputDesign2(
                textEditingController: _controller.otpController!,
                hintText: "OTP",
                labelText: "Enter OTP",
                errorMsg: 'Enter Valid OTP',
                inputType: InputType.number,
                controller: _controller,
              ),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Text("Resend OTP"),
                    onTap: () {
                      _controller.sendMobileNumberOTP();
                    },
                  ))
            ],
          ],
        ));
  }

  Widget buildCustomField() {
    return Column(
      children: [
        InputDesign2(
          textEditingController: _controller.emailController!,
          hintText: "Email",
          labelText: "Email",
          errorMsg: 'Enter Valid Email',
          inputType:
              InputType.email, // Assuming you have an InputType for email
          controller: _controller,
        ),
        SizedBox(height: kDefaultPadding), // Adjust as needed
        InputDesign2(
          textEditingController: _controller.passwordController!,
          hintText: "Password",
          labelText: "Password",
          errorMsg: 'Enter Valid Password',
          inputType: InputType.password,
          controller: _controller,
        ),
      ],
    );
  }
}
