// ignore_for_file: unused_element

// import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/forgot_password_v1_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/keyboard.dart';

import '../../../common_component/default_button.dart';
import '../../../common_component/form_error.dart';

import '../../../const/size_config.dart';
import '../../../common_component/custom_text_field.dart';

class ForgotPasswordV1Body extends StatefulWidget {
  const ForgotPasswordV1Body({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ForgotPasswordV1Controller _controller;
  @override
  ForgotPasswordIAState createState() => ForgotPasswordIAState();
}

class ForgotPasswordIAState extends State<ForgotPasswordV1Body> {
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget._controller.formKey,
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(40),
            ),
            child: Column(
              children: [
                buildCustomField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                DefaultButton(
                  text: widget._controller.btnText.value,
                  press: () {
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
      ),
    );
  }

  Widget buildCustomField() {
    return Column(
      children: [
        CustomTextFiled(
          textEditingController: widget._controller.emailController!,
          hintText: "Email",
          labelText: "Enter Email",
          errorMsg: 'Enter Valid Email',
          inputType: InputType.email,
          controller: widget._controller,
        ),
      ],
    );
  }
}
