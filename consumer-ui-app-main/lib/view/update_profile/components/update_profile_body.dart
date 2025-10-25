// ignore_for_file: unrelated_type_equality_checks

import 'package:black_locust/common_component/custom_text_field.dart';
import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<UpdateProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
              child: Column(
                children: [
                  _controller.updateType == "name"
                      ? Column(
                          children: [
                            CustomTextFiled(
                              textEditingController:
                                  _controller.firstNameController!,
                              hintText: "First Name",
                              labelText: "Enter First Name",
                              errorMsg: 'Enter First Name',
                              inputType: InputType.text,
                              isPhoneCode: false,
                              controller: _controller,
                            ),
                            kDefaultHeight(kDefaultPadding),
                            CustomTextFiled(
                              textEditingController:
                                  _controller.lastNameController!,
                              hintText: "Last Name",
                              labelText: "Enter Last Name",
                              errorMsg: 'Enter Last Name',
                              inputType: InputType.text,
                              isPhoneCode: false,
                              controller: _controller,
                            ),
                            kDefaultHeight(kDefaultPadding),
                            // CustomTextFiled(
                            //   textEditingController:
                            //       _controller.altmobileNumberController,
                            //   hintText: "Alternate Mobile Number",
                            //   labelText: "Enter Alternate Mobile Number",
                            //   errorMsg: 'Enter Valid Mobile Number',
                            //   inputType: InputType.number,
                            //   isPhoneCode: true,
                            //   controller: _controller,
                            // ),
                            // kDefaultHeight(kDefaultPadding),
                          ],
                        )
                      : Container(),
                  _controller.updateType == "email"
                      ? CustomTextFiled(
                          textEditingController: _controller.emailIdController!,
                          hintText: "Email",
                          labelText: "Enter Email",
                          errorMsg: 'Enter Valid Email',
                          inputType: InputType.email,
                          isPhoneCode: false,
                          controller: _controller,
                        )
                      : Container(),
                  _controller.updateType == "mobile"
                      ? Column(
                          children: [
                            CustomTextFiled(
                              textEditingController:
                                  _controller.mobileNumberController!,
                              hintText: "Mobile Number",
                              labelText: "Enter Mobile Number",
                              errorMsg: 'Enter Valid Mobile Number',
                              inputType: InputType.phone,
                              isPhoneCode: true,
                              controller: _controller,
                            ),
                            kDefaultHeight(kDefaultPadding),
                            Obx(
                              () => _controller.otpEnable == true
                                  ? CustomTextFiled(
                                      textEditingController:
                                          _controller.otpController!,
                                      hintText: "OTP",
                                      labelText: "Enter OTP",
                                      errorMsg: 'Enter OTP',
                                      inputType: InputType.number,
                                      controller: _controller,
                                    )
                                  : Container(),
                            ),
                          ],
                        )
                      : Container(),
                  _controller.updateType == "password"
                      ? Column(
                          children: [
                            CustomTextFiled(
                              textEditingController:
                                  _controller.oldPasswordController!,
                              hintText: "Password",
                              labelText: "Enter Old Password",
                              errorMsg: 'Enter Old Password',
                              inputType: InputType.password,
                              isPhoneCode: false,
                              controller: _controller,
                            ),
                            kDefaultHeight(kDefaultPadding),
                            CustomTextFiled(
                              textEditingController:
                                  _controller.newPasswordController!,
                              hintText: "Password",
                              labelText: "Enter New Password",
                              errorMsg: 'Enter New Password',
                              inputType: InputType.password,
                              isPhoneCode: false,
                              controller: _controller,
                            ),
                          ],
                        )
                      : Container(),
                  kDefaultHeight(kDefaultPadding),
                  Obx(
                    () => DefaultButton(
                        text: _controller.btnText.value,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.updateProfile();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
