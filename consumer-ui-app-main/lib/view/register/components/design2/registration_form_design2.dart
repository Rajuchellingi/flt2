// registration_ui.dart

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design2/input_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationFormDesign2 extends StatefulWidget {
  @override
  RegisterFormField createState() => RegisterFormField();
}

class RegisterFormField extends State<RegistrationFormDesign2> {
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
                      child: InputDesign2(
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
                      child: InputDesign2(
                        fieldName: 'confirmPassword',
                        required: true,
                        passwordController: getModelController(element),
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
                      child: InputDesign2(
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
                ]
              ],
              const SizedBox(height: 20),
              Center(
                  child: GestureDetector(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  child: Text(
                    _controller.buttonName.value,
                    style: const TextStyle(
                        fontSize: 16,
                        color: kSecondaryColor,
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
              ))
            ],
          ),
        ));
  }

  getModelController(element) {
    var textEditingController = _controller.textController
        .firstWhere((textField) => textField[element['name']] != null);
    return textEditingController[element['name']];
  }
}
