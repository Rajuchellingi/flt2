// registration_ui.dart

import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/custom_text_field.dart';
import '../../../common_component/default_button.dart';

class RegistrationFormField extends StatefulWidget {
  @override
  RegisterFormField createState() => RegisterFormField();
}

class RegisterFormField extends State<RegistrationFormField> {
  final _controller = Get.find<RegistrationController>();
  final _formKey = GlobalKey<FormState>();
  var validationMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              for (var element in _controller.registerForm) ...[
                if (element['type'] == 'password') ...[
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFiled(
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
                      child: CustomTextFiled(
                        fieldName: 'confirmPassword',
                        required: true,
                        textEditingController:
                            _controller.confirmPasswordController!,
                        passwordController: getModelController(element),
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
                      child: CustomTextFiled(
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
                                : "$element['label'] is required"
                            : null,
                        inputType: _controller.getInputType(element['type']),
                        controller: _controller,
                      )),
                ]
              ],
              const SizedBox(height: 20),
              DefaultButton(
                  press: () {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        _controller.submitForm(context);
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/home', (route) => false);
                        // Get.toNamed('/home');
                      }
                    }
                  },
                  text: _controller.buttonName.value)
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
