// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'package:black_locust/controller/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/default_button.dart';
import '../../../const/size_config.dart';
import '../../../helper/validation_helper.dart';
import '../../../model/enum.dart';

class NewPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<NewPasswordForm> {
  final _controller = Get.find<NewPasswordController>();
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
    final brightness = Theme.of(context).brightness;
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 30, top: 15),
        padding: EdgeInsets.all(20),
        child: Obx(() => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "RINTEGER",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  )),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    "New Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    child: Column(children: [
                      TextFormField(
                          cursorColor: brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          obscureText:
                              _controller.isVisible.value ? false : true,
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
                          }),
                      TextFormField(
                          cursorColor: brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          obscureText:
                              _controller.isVisible1.value ? false : true,
                          decoration: InputDecoration(
                            hintText: 'Enter Confirm Password',
                            labelText: 'Confirm Password *',
                            suffixIcon: IconButton(
                              icon: Icon(_controller.isVisible1.value == true
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                _controller.changePasswordVisible1();
                              },
                            ),
                          ),
                          controller: _controller.confirmPasswordController!,
                          validator: (value) {
                            validationMsg = ValidationHelper.validate(
                                InputType.password, value,
                                errorMsg: "Confirm Password is required");
                            if (validationMsg != '') {
                              return validationMsg;
                            } else if (value !=
                                _controller.passwordController!.text) {
                              return "Password and confirm password not match";
                            } else {
                              return null;
                            }
                          }),
                    ]),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    text: "Submit",
                    press: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _controller.changePassword();
                        }
                      }
                    },
                  ),
                ],
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
