// ignore_for_file: camel_case_types, invalid_use_of_protected_member, unused_local_variable

import 'package:black_locust/common_component/custom_checkbox.dart';
import 'package:black_locust/common_component/custom_drop_down_meta_field.dart';
import 'package:black_locust/common_component/custom_radio_button.dart';
import 'package:black_locust/common_component/custom_textArea_field.dart';
import 'package:black_locust/common_component/custom_text_field_v1.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_component/custom_drop_down_field.dart';
import '../../../common_component/default_button.dart';
import '../../../const/constant.dart';
import '../../../const/size_config.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationFormFieldV1Design3 extends StatefulWidget {
  @override
  _registerFormState createState() => _registerFormState();
}

class _registerFormState extends State<RegistrationFormFieldV1Design3> {
  final RegistrationV1Controller _controller =
      Get.find<RegistrationV1Controller>();
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
    // print("dynamicForm--->>> ${_controller.dynamicForm.value.toJson()}");
    return Container(
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        margin: const EdgeInsets.only(bottom: 30, top: 5),
        padding: const EdgeInsets.all(20),
        child: Obx(() => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    // child: Text(
                    //   "Basic Details",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                  ),
                  for (var element in _controller.dynamicForm.value.formField!)
                    element.fieldType == "metafield"
                        ? buildMetaFormField(element)
                        : buildFormField(element),
                  // buildFormField(element),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    text: _controller.dynamicForm.value.form!.buttonLabel ??
                        "Submit",
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
    switch (element.type) {
      case 'text':
        return buildTextField(element);
      case 'number':
        return buildTextField(element);
      case 'select':
        return buildSelectTextField(element);
      case 'radio':
        return buildRadioButton(element);
      case 'checkbox':
        return buildCheckboxField(element);
      case 'email':
        return buildTextField(element);
      case 'password':
        return buildTextField(element);
      case 'phone':
        return buildTextField(element);
      case 'textarea':
        return buildTextField(element);
      default:
        return buildTextField(element);
    }
  }

  buildMetaFormField(element) {
    // print("element.type ${element.toJson()}");
    // print("dynamicForm--->>> ${_controller.dynamicForm.value.toJson()}");

    if (element.metafield.type == "single-line-text" &&
        element.metafield.isPresetChoices == true) {
      return buildSelectTextMetaField(element);
    }
    switch (element.metafield.type) {
      case "single-line-text":
        return buildTextMetaField(element);
      case "integer":
        return buildTextMetaField(element);
      case "multi-line-text":
        return buildTextAreaMetaField(element);
      case "file":
        return buildMetaFileUploader(element);
      // case 5:
      //   return buildRadioButton(element);
      // case 6:
      //   return buildCheckboxField(element);
      // case 7:
      //   return buildTextField(element);
      // case 8:
      //   return buildTextField(element);
      // case 9:
      //   return buildTextField(element);
      // case 11:
      // return buildTextField(element);
      default:
        return buildTextMetaField(element);
    }
  }

  Container buildTextMetaField(element) {
    // print("buildTextMetaField element ----->>> ${element.toJson()}");
    return _controller.getHiddenField(element.metafield.name)
        ? Container(
            child: Column(
              children: [
                CustomTextFieldV1(
                  minlength: element.metafield.minimumCharacterCount,
                  maxlength: element.metafield.maximumCharacterCount,
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputMetaType(element),
                  // pattern: validationPattern,
                  pattern: element.metafield.regularExpression,
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

  Widget buildTextField(element) {
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
        ? Obx(() {
            var visibleField = _controller.visibilityField.value[element.name];
            return Container(
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
                    suffixIcon: element.type == 'password'
                        ? visibleField == true
                            ? Icons.visibility
                            : Icons.visibility_off
                        : null,
                    onSuffixTap: element.type == 'password'
                        ? () {
                            _controller.changeVisibility(element.name);
                          }
                        : null,
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
            );
          })
        : Container();
  }

  Container buildTextAreaMetaField(element) {
    // print("buildTextAreaMetaField element ----->>> ${element.toJson()}");

    if (!_controller.getHiddenField(element.metafield.name)) {
      return Container();
    }

    bool isTextArea =
        _controller.getInputType(element) == TextInputType.multiline;

    return Container(
      child: Column(
        children: [
          CustomTextAreaFieldV1(
            textEditingController: getTextEditingController(element),
            hintText: element.placeHolder,
            labelText: element.label,
            enabled: _controller.getDisableField(element.name),
            errorMsg:
                element.required == true ? 'Enter ${element.label}' : null,
            inputType: _controller.getInputMetaType(element),
            pattern: element.metafield.regularExpression,
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
    );
  }

  Widget buildMetaFileUploader(element) {
    // print("file element ----->>> ${element.toJson()}");

    if (!_controller.getHiddenField(element.metafield.name)) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Upload a file",
              style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                ),
                onPressed: () {
                  if (element.metafield.valueType == "multiple") {
                    _controller.pickFileBulk(ImageSource.gallery, element.sId);
                  } else {
                    _controller.pickFileSingle(
                        ImageSource.gallery, element.sId);
                  }
                },
                child: const Text('Select File',
                    style: const TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 10),
              Obx(() => Flexible(
                    child: Text(
                      (_controller.videoNameMap[element.sId] as List<String>?)
                              ?.join(", ") ??
                          "No file selected",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Select a File between 5MB to 15MB",
              style: const TextStyle(color: Colors.black, fontSize: 12)),
          const SizedBox(height: 10),
          Obx(() => _controller.isError.value
              ? Text(
                  _controller.errorMessage[element.sId] ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                )
              : const SizedBox.shrink()),
          // SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.black,
          //         padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          //       ),
          //       onPressed: () => Navigator.pop(Get.context!, false),
          //       child: const Text("Close"),
          //     ),
          //     SizedBox(width: 15),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.black,
          //         padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          //       ),
          //       onPressed: () {
          //         _controller.uploadVideo(element.sId);
          //       },
          //       child: const Text("Upload"),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
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

  Container buildSelectTextMetaField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(children: [
            CustomDropdownMetaField(
                name: element.name,
                enabled: _controller.getDisableField(element.name),
                hintText: element.placeHolder,
                dropdownList: element.metafield.presetChoices,
                lableText: element.label,
                selectedType: getSelectmetafieldType(element),
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

  getSelectmetafieldType(element) {
    var _fController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (_fController[element.metafield.name] != null) {
      var value = _fController[element.metafield.name];
      var selectedType =
          element.metafield.presetChoices.firstWhere((da) => da.value == value);
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
