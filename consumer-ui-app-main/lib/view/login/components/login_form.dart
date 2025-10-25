// ignore_for_file: unused_element

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../common_component/phoneNumberWithCodeTextFiled.dart';
import '../../../common_component/form_error.dart';
import '../../../helper/keyboard.dart';

import '../../../common_component/default_button.dart';

import '../../../const/size_config.dart';
// import '../../../controller/sign_in_controller.dart';
import '../../../common_component/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<LoginForm> {
  final _controller = Get.find<LogInController>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Obx(() => Column(
            children: [
              if (_controller.isPrizma.value == true)
                buildOTPField()
              else
                buildCustomField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "LOGIN",
                press: () {
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
          )),
    );
  }

  Widget buildOTPField() {
    return Obx(() => Column(
          children: [
            CustomTextFiled(
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
              CustomTextFiled(
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
        CustomTextFiled(
          textEditingController: _controller.emailController!,
          hintText: "Email",
          labelText: "Enter Email",
          errorMsg: 'Enter Valid Email',
          inputType:
              InputType.email, // Assuming you have an InputType for email
          controller: _controller,
        ),
        SizedBox(height: kDefaultPadding), // Adjust as needed
        CustomTextFiled(
          textEditingController: _controller.passwordController!,
          hintText: "Password",
          labelText: "Enter Password",
          errorMsg: 'Enter Valid Password',
          inputType: InputType.password,
          controller: _controller,
        ),
      ],
    );
  }
}
