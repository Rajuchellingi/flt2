// ignore_for_file: unused_field, invalid_use_of_protected_member, unrelated_type_equality_checks

import 'package:black_locust/common_component/custom_checkbox.dart';
import 'package:black_locust/common_component/custom_drop_down_field.dart';
import 'package:black_locust/common_component/custom_radio_button.dart';
import 'package:black_locust/common_component/custom_text_field_v1.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/dynamic_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicFormBottomSheet extends StatefulWidget {
  @override
  DynamicFormState createState() => DynamicFormState();
}

class DynamicFormState extends State<DynamicFormBottomSheet> {
  final _controller = Get.find<DynamicFormController>();
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
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      if (_controller.isLoading.value == true)
        return Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
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
            padding: EdgeInsets.symmetric(
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
                    child: Text(_controller.dynamicForm.value.form!.name ?? '',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600))),
                const SizedBox(height: 20),
                for (var element in _controller.dynamicForm.value.formField!)
                  buildFormField(element),
                kDefaultHeight(30),
                Container(
                    width: SizeConfig.screenWidth,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _controller.submitRegistration();
                            }
                          }
                        },
                        child: Text(
                            _controller.dynamicForm.value.form!.buttonLabel ??
                                'Submit',
                            style: const TextStyle(color: Colors.white)),
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

  buildFormField(element) {
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
}
