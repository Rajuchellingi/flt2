// ignore_for_file: unused_element

import 'package:black_locust/common_component/form_error.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormDesign3 extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<LoginFormDesign3> {
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
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot your password? ",
                          style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                        const Icon(
                          Icons.arrow_right_alt_sharp,
                          color: kPrimaryColor,
                          size: 20,
                        )
                      ]),
                ))
          ],
          FormError(errors: errors),
          const SizedBox(height: 30),
          GestureDetector(
            child: Container(
              width: SizeConfig.screenWidth,
              decoration: new BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
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
    final brightness = Theme.of(context).brightness;
    return Obx(() => Column(
          children: [
            InputDesign3(
              textEditingController: _controller.phoneNumberController!,
              hintText: "Mobile Number",
              labelText: "Enter Mobile Number",
              errorMsg: 'Enter Valid Mobile Number',
              inputType: InputType.phone,
              enabled: _controller.isOtp.value == false,
              controller: _controller,
            ),
            if (_controller.isOtp.value == true) ...[
              SizedBox(height: kDefaultPadding),
              InputDesign3(
                fieldName: 'otp',
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
                    child: Text("Resend OTP",
                        style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                        )),
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
        InputDesign3(
          textEditingController: _controller.emailController!,
          hintText: "Email",
          labelText: "Email",
          errorMsg: 'Enter Valid Email',
          inputType:
              InputType.email, // Assuming you have an InputType for email
          controller: _controller,
        ),
        SizedBox(height: kDefaultPadding), // Adjust as needed
        InputDesign3(
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
