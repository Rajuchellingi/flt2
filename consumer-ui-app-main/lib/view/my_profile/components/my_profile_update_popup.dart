// ignore_for_file: unused_field, invalid_use_of_protected_member, unrelated_type_equality_checks

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileUpdatePopup extends StatelessWidget {
  final _controller = Get.find<UpdateProfileController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
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
                Center(
                    child: Text(_controller.title.value,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor))),
                const SizedBox(height: 20),
                if (_controller.updateType == "name") ...[
                  InputDesign3(
                    textEditingController: _controller.firstNameController!,
                    hintText: "First Name",
                    labelText: "Enter First Name",
                    errorMsg: 'Enter First Name',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  InputDesign3(
                    textEditingController: _controller.lastNameController!,
                    hintText: "Last Name",
                    labelText: "Enter Last Name",
                    errorMsg: 'Enter Last Name',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  // InputDesign3(
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
                ] else if (_controller.updateType == "email") ...[
                  InputDesign3(
                    textEditingController: _controller.emailIdController!,
                    hintText: "Email",
                    labelText: "Enter Email",
                    errorMsg: 'Enter Valid Email',
                    inputType: InputType.email,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                ] else if (_controller.updateType == "mobile") ...[
                  InputDesign3(
                    textEditingController: _controller.mobileNumberController!,
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
                        ? InputDesign3(
                            textEditingController: _controller.otpController!,
                            hintText: "OTP",
                            labelText: "Enter OTP",
                            errorMsg: 'Enter OTP',
                            inputType: InputType.number,
                            controller: _controller,
                          )
                        : Container(),
                  ),
                ] else if (_controller.updateType == "password") ...[
                  InputDesign3(
                    textEditingController: _controller.oldPasswordController!,
                    hintText: "Password",
                    labelText: "Enter Old Password",
                    errorMsg: 'Enter Old Password',
                    inputType: InputType.password,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  const SizedBox(height: 5),
                  Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () async {
                            await _controller.logOut();
                            Get.offAllNamed('/forgotPassword');
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor)))),
                  kDefaultHeight(15),
                  InputDesign3(
                    textEditingController: _controller.newPasswordController!,
                    hintText: "Password",
                    labelText: "New Password",
                    errorMsg: 'Enter New Password',
                    inputType: InputType.password,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(15),
                  InputDesign3(
                    fieldName: 'confirmPassword',
                    newPasswordController: _controller.newPasswordController,
                    textEditingController:
                        _controller.confirmPasswordController!,
                    hintText: "Password",
                    labelText: "Repeat New Password",
                    errorMsg: 'Enter New Password',
                    inputType: InputType.password,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                ] else if (_controller.updateType == 'personal-info') ...[
                  for (var element in _controller.registerForm) ...[
                    InputDesign3(
                      textEditingController: getTextController(element),
                      labelText: element['label'].toString(),
                      pattern: element['pattern'] != null
                          ? element['pattern'].toString()
                          : null,
                      enabled: true,
                      errorMsg: element['required'] == true
                          ? element['errorMessage'] != null
                              ? element['errorMessage'].toString()
                              : "${element['label']} is required"
                          : null,
                      inputType: _controller.getInputType(element['type']),
                      isPhoneCode: false,
                      controller: _controller,
                    ),
                    kDefaultHeight(kDefaultPadding)
                  ],
                  // if (_controller.profileDetails.lastName != null &&
                  //     _controller.profileDetails.lastName.isNotEmpty) ...[
                  //   InputDesign3(
                  //     textEditingController: _controller.lastNameController!,
                  //     hintText: "Last Name",
                  //     labelText: "Enter Last Name",
                  //     errorMsg: 'Enter Last Name',
                  //     inputType: InputType.text,
                  //     isPhoneCode: false,
                  //     controller: _controller,
                  //   ),
                  //   kDefaultHeight(kDefaultPadding),
                  // ],
                  // if (_controller.profileDetails.emailId != null &&
                  //     _controller.profileDetails.emailId.isNotEmpty) ...[
                  //   InputDesign3(
                  //     textEditingController: _controller.emailIdController!,
                  //     hintText: "Email",
                  //     labelText: "Enter Email",
                  //     errorMsg: 'Enter Valid Email',
                  //     inputType: InputType.email,
                  //     isPhoneCode: false,
                  //     controller: _controller,
                  //   ),
                  //   kDefaultHeight(kDefaultPadding),
                  // ],
                  // if (_controller.profileDetails.mobileNumber != null &&
                  //     _controller.profileDetails.mobileNumber.isNotEmpty) ...[
                  //   InputDesign3(
                  //     textEditingController:
                  //         _controller.mobileNumberController!,
                  //     hintText: "Mobile Number",
                  //     labelText: "Enter Mobile Number",
                  //     errorMsg: 'Enter Valid Mobile Number',
                  //     inputType: InputType.phone,
                  //     isPhoneCode: false,
                  //     controller: _controller,
                  //   ),
                  //   kDefaultHeight(kDefaultPadding),
                  // ]
                ],
                kDefaultHeight(30),
                Container(
                    width: SizeConfig.screenWidth,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.updateProfile();
                          }
                        },
                        child: Text(_controller.btnText.value,
                            style: const TextStyle(color: kSecondaryColor)),
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: brightness == Brightness.dark
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor),
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
