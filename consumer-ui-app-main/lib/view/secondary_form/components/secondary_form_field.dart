// ignore_for_file: camel_case_types, invalid_use_of_protected_member

import 'package:black_locust/common_component/custom_checkbox.dart';
import 'package:black_locust/common_component/custom_radio_button.dart';
import 'package:black_locust/common_component/custom_text_field_v1.dart';
import 'package:black_locust/controller/secondary_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_component/custom_drop_down_field.dart';
import '../../../common_component/default_button.dart';
import '../../../const/constant.dart';
import '../../../const/size_config.dart';

class SecondaryFormField extends StatefulWidget {
  @override
  _registerFormState createState() => _registerFormState();
}

class _registerFormState extends State<SecondaryFormField> {
  final _controller = Get.find<SecondaryFormController>();
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 30, top: 5),
        padding: EdgeInsets.all(20),
        child: Obx(() => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var element in _controller.dynamicForm.value.formField!)
                    buildFormField(element),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    text: _controller.dynamicForm.value.form!.buttonLabel
                        .toString(),
                    press: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _controller.submitRegistration();
                        }
                      }
                    },
                  ),
                ],
              ),
            )));
  }

  buildFormField(element) {
    // print("buildFormField element ${element.toJson()}");
    switch (element.type) {
      case 1:
        return buildTextField(element);
      case 2:
        return buildTextField(element);
      case 4:
        return buildSelectTextField(element);
      case 5:
        return buildRadioButton(element);
      case 6:
        return buildCheckboxField(element);
      case 7:
        return buildTextField(element);
      case 8:
        return buildTextField(element);
      case 9:
        return buildTextField(element);
      case 11:
        return buildTextField(element);
      default:
        return buildTextField(element);
    }
  }

  Container buildTextField(element) {
    var validationPattern;
    if (element.settings != null && element.settings.validation != null) {
      for (var validation in element.settings.validation) {
        // print("validation==1 ${validation.toJson()}");
        if (validation.rule == '3') {
          // print("validationPattern123 ${validation.rule}");
          // print("validationPattern123 ${validation.value}");
          validationPattern = validation.value;
          // print("validationPattern123 ${validationPattern}");
          break;
        } else if (validation.rule == '1') {
          validationPattern = r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
          // print("validationPattern1234 ${validationPattern}");
          break;
        }
        // print("validationPattern==12 ${validationPattern}");
      }
    }
    // print("validationPattern==1 ${validationPattern}");
    return _controller.getHiddenField(element.name)
        ? Container(
            child: Column(
              children: [
                CustomTextFieldV1(
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputType(element),
                  pattern: validationPattern,
                  controller: _controller,
                  isTextChanged: element.name == 'pincode',
                  onTextChange: element.name == 'pincode'
                      ? (value) {
                          _controller.onPinCodeChange(value, context);
                        }
                      : null,
                  isPhoneCode: (element.name == 'whatsAppNumber' ||
                      element.name == 'mobileNumber'),
                ),
                kDefaultHeight(kDefaultPadding),
              ],
            ),
          )
        : Container();
  }

  Container buildSelectTextField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(children: [
            CustomDropdownField(
                // name: element.name,
                // enabled: _controller.getDisableField(element.name),
                // placeholder: element.placeHolder,
                dropdownList: element.settings.options,
                lableText: element.label,
                selectedType: getSelectType(element),
                controller: _controller),
            kDefaultHeight(kDefaultPadding),
          ]))
        : Container();
  }

  Container buildRadioButton(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(
            children: [
              CustomRadioButton(
                  controller: _controller,
                  enabled: _controller.getDisableField(element.name),
                  label: element.label,
                  name: element.name,
                  element: element,
                  options: element.settings.options,
                  value: getCheckBoxValue(element)),
              kDefaultHeight(kDefaultPadding),
            ],
          ))
        : Container();
  }

  Container buildCheckboxField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(
            children: [
              for (var input in element.settings.options)
                CustomCheckbox(
                    controller: _controller,
                    name: element.name,
                    label: input.name,
                    element: input,
                    enabled: _controller.getDisableField(element.name),
                    value: getCheckBoxValue(element)),
              kDefaultHeight(kDefaultPadding),
            ],
          ))
        : Container();
  }

  getSelectType(element) {
    var _fController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (_fController[element.name].text.isNotEmpty) {
      var value = _fController[element.name].text;
      var selectedType =
          element.settings.options.firstWhere((da) => da.value == value);
      if (selectedType != null)
        return selectedType;
      else
        return null;
    } else {
      return null;
    }
  }

  getCheckBoxValue(element) {
    var textEditingController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (textEditingController[element.name].text.isNotEmpty)
      return textEditingController[element.name].text;
    else
      return null;
  }

  getTextEditingController(element) {
    var textEditingController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    return textEditingController[element.name];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
