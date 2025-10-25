// ignore_for_file: camel_case_types, invalid_use_of_protected_member, unused_local_variable, unnecessary_null_comparison

import 'package:black_locust/common_component/custom_checkbox.dart';
import 'package:black_locust/common_component/custom_drop_down_meta_field.dart';
import 'package:black_locust/common_component/custom_radio_button.dart';
import 'package:black_locust/common_component/custom_textArea_field.dart';
import 'package:black_locust/common_component/custom_text_field_v1.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_component/custom_drop_down_field.dart';
import '../../../const/constant.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationFormFieldV2 extends StatefulWidget {
  const RegistrationFormFieldV2({
    Key? key,
    required this.block,
  }) : super(key: key);
  final Map<String, dynamic> block;
  @override
  _registerFormState createState() => _registerFormState();
}

class _registerFormState extends State<RegistrationFormFieldV2> {
  final RegistrationV1Controller _controller =
      Get.find<RegistrationV1Controller>();
  final themeController = Get.find<ThemeController>();
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
      color: Colors.blueAccent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 60),

            // Top Image (woman)
            if (widget.block['source']['image'] != null &&
                widget.block['source']['image'].isNotEmpty) ...[
              Center(
                child: Image.network(
                  widget.block['source']['image'],
                  height: 200,
                ),
              )
            ],
            // const SizedBox(height: 10),

            // Registration Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Obx(() => Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (themeController.logo.value != null &&
                            themeController.logo.value.isNotEmpty) ...[
                          Center(
                              child: Image.network(themeController.logo.value,
                                  height: 50)),
                          const SizedBox(height: 15)
                        ],
                        if (widget.block['source']['title'] != null &&
                            widget.block['source']['title'].isNotEmpty) ...[
                          Center(
                            child: Text(
                              widget.block['source']['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5)
                        ],
                        if (widget.block['source']['description'] != null &&
                            widget
                                .block['source']['description'].isNotEmpty) ...[
                          Center(
                            child: Text(
                              widget.block['source']['description'],
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 25)
                        ],

                        // Dynamic Fields
                        for (var element
                            in _controller.dynamicForm.value.formField!)
                          element.fieldType == "metafield"
                              ? buildMetaFormField(element)
                              : buildFormField(element),

                        const SizedBox(height: 25),

                        // Terms & Conditions checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() => Checkbox(
                                  value: _controller.isTermsAccepted.value,
                                  onChanged: (val) {
                                    _controller.isTermsAccepted.value =
                                        val ?? false;
                                  },
                                )),
                            Expanded(
                              child: Wrap(
                                children: [
                                  const Text("I agree to the "),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to Terms page
                                    },
                                    child: const Text(
                                      "Terms & Conditions",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const Text(" and "),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to Privacy Policy
                                    },
                                    child: const Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState!.save();
                                if (_controller.isTermsAccepted.value) {
                                  _controller.submitRegistration();
                                } else {
                                  Get.snackbar("Alert",
                                      "Please accept Terms & Conditions");
                                }
                              }
                            },
                            child: Text(
                              "Create Account",
                              // _controller.dynamicForm.value.form?.buttonLabel ??
                              //     "Create Account",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Login link
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to Login
                              Get.toNamed('/login');
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(fontSize: 13),
                                children: [
                                  TextSpan(
                                    text: "Login here",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
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
    String? validationPattern;

    // Determine validation pattern based on rules
    if (element.settings != null && element.settings.validation != null) {
      for (var validation in element.settings.validation) {
        if (validation.rule == '3') {
          validationPattern = validation.value;
          break;
        } else if (validation.rule == '1') {
          validationPattern = r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
          break;
        }
      }
    }

    return _controller.getHiddenField(element.name)
        ? Obx(() {
            var visibleField = _controller.visibilityField.value[element.name];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label with red asterisk on the right side
                if (element.label != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: element.label,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (element.required == true)
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                // Input field
                CustomTextFieldV1(
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  label: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ${element.label}'
                      : null,
                  inputType: _controller.getInputType(element),
                  pattern: validationPattern,
                  suffixIcon: element.type == 'password'
                      ? (visibleField == true
                          ? Icons.visibility
                          : Icons.visibility_off)
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
            );
          })
        : const SizedBox.shrink();
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
