// ignore_for_file: unused_field, invalid_use_of_protected_member, unrelated_type_equality_checks

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
// import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3_V2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyUpdatePasswordPopup extends StatelessWidget {
  final _controller = Get.find<ProfileV1Controller>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: brightness == Brightness.dark ? Colors.black : kBackground,
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey))),
                const SizedBox(height: 15),

                const SizedBox(height: 20),
                // if (_controller.updateType == "password") ...[
                InputDesign3V2(
                  textEditingController: _controller.oldPasswordController,
                  hintText: "Password",
                  labelText: "Enter Old Password",
                  errorMsg: 'Enter Old Password',
                  inputType: InputType.password,
                  isPhoneCode: false,
                  controller: _controller,
                ),
                const SizedBox(height: 5),
                kDefaultHeight(15),
                InputDesign3V2(
                  textEditingController: _controller.newPasswordController,
                  hintText: "Password",
                  labelText: "New Password",
                  errorMsg: 'Enter New Password',
                  inputType: InputType.password,
                  isPhoneCode: false,
                  controller: _controller,
                ),
                kDefaultHeight(15),
                InputDesign3V2(
                  fieldName: 'confirmPassword',
                  newPasswordController: _controller.newPasswordController,
                  textEditingController: _controller.confirmPasswordController,
                  hintText: "Password",
                  labelText: "Repeat New Password",
                  errorMsg: 'Enter New Password',
                  inputType: InputType.password,
                  isPhoneCode: false,
                  controller: _controller,
                ),
                kDefaultHeight(30),
                Container(
                    width: SizeConfig.screenWidth,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.updatePassWord(context);
                          }
                        },
                        child: Text(_controller.btnText.value,
                            style: const TextStyle(color: kSecondaryColor)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: kSecondaryColor,
                            padding:
                                const EdgeInsets.symmetric(vertical: 15)))),
              ],
            )),
          ),
        ),
      );
    });
  }

  getTextController(element) {
    var textEditingController = _controller.textController
        .firstWhere((textField) => textField[element['name']] != null);
    return textEditingController[element['name']];
  }
}
