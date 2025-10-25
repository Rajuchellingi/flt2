// ignore_for_file: unused_element

// import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/forgot_password_v1_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3.dart';
import 'package:flutter/material.dart';
import '../../../helper/keyboard.dart';

import '../../../common_component/form_error.dart';

import '../../../const/size_config.dart';

class ForgotPasswordDesign2 extends StatefulWidget {
  const ForgotPasswordDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ForgotPasswordV1Controller _controller;
  @override
  ForgotPasswordIAState createState() => ForgotPasswordIAState();
}

class ForgotPasswordIAState extends State<ForgotPasswordDesign2> {
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SingleChildScrollView(
      child: Form(
        key: widget._controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Forgot password",
                  style: TextStyle(
                    fontSize: 30,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 60),
              Text(
                  "Please, enter your email address. You will receive a link to create a new password via email.",
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor)),
              const SizedBox(height: 15),
              buildCustomField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              GestureDetector(
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: new BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "SEND",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  if (widget._controller.formKey.currentState!.validate()) {
                    widget._controller.formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    widget._controller.forgetPassword(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomField() {
    return Column(
      children: [
        InputDesign3(
          textEditingController: widget._controller.emailController!,
          hintText: "Email",
          labelText: "Email",
          errorMsg: 'Not a valid email address. Should be your@email.com',
          inputType: InputType.email,
          controller: widget._controller,
        ),
      ],
    );
  }
}
