// registration_ui.dart

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationFormDesign3 extends StatefulWidget {
  @override
  RegisterFormField createState() => RegisterFormField();
}

class RegisterFormField extends State<RegistrationFormDesign3> {
  final _controller = Get.find<RegistrationController>();
  final _formKey = GlobalKey<FormState>();
  var validationMsg;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Form(
        key: _formKey,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              for (var element in _controller.registerForm) ...[
                if (element['type'] == 'password') ...[
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: InputDesign3(
                        fieldName: element['name'].toString(),
                        required: element['required'] == true ? true : false,
                        textEditingController: getModelController(element),
                        hintText: "Enter  " + element['label'].toString(),
                        pattern: element['pattern'] != null
                            ? element['pattern'].toString()
                            : null,
                        labelText: element['label'].toString(),
                        enabled: true,
                        errorMsg: element['required'] == true
                            ? element['errorMessage'] != null
                                ? element['errorMessage'].toString()
                                : "${element['label']} is required"
                            : null,
                        inputType: _controller.getInputType(element['type']),
                        controller: _controller,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: InputDesign3(
                        fieldName: 'confirmPassword',
                        required: true,
                        newPasswordController: getModelController(element),
                        textEditingController:
                            _controller.confirmPasswordController!,
                        hintText: "Enter Confirm Password",
                        pattern: null,
                        labelText: "Confirm Password",
                        enabled: true,
                        errorMsg: "Confirm Password is required",
                        inputType: InputType.password,
                        controller: _controller,
                      )),
                ] else ...[
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: InputDesign3(
                        required: element['required'] == true ? true : false,
                        textEditingController: getModelController(element),
                        hintText: "Enter  " + element['label'].toString(),
                        pattern: element['pattern'] != null
                            ? element['pattern'].toString()
                            : null,
                        labelText: element['label'].toString(),
                        enabled: true,
                        errorMsg: element['required'] == true
                            ? element['errorMessage'] != null
                                ? element['errorMessage'].toString()
                                : "${element['label']} is required"
                            : null,
                        inputType: element['name'] == 'phone'
                            ? InputType.phone
                            : _controller.getInputType(element['type']),
                        controller: _controller,
                      )),
                ]
              ],
              const SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('/login', arguments: {"path": "/home"});
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_right_alt_sharp,
                            color: kPrimaryColor,
                            size: 20,
                          )
                        ]),
                  )),
              const SizedBox(height: 25),
              GestureDetector(
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: new BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _controller.buttonName.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      _controller.submitForm(context);
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, '/home', (route) => false);
                      // Get.toNamed('/home');
                    }
                  }
                },
              )
            ],
          ),
        ));
  }

  getModelController(element) {
    var textEditingController = _controller.textController
        .firstWhere((textField) => textField[element['name']] != null);
    return textEditingController[element['name']];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
