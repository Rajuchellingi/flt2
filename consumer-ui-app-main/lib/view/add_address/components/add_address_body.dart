// ignore_for_file: must_be_immutable

import 'package:black_locust/common_component/custom_text_field.dart';
import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/add_address_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<AddAddressController>();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _mobileNumberFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _pincodeFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  var errorField = [];
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
                  CustomTextFiled(
                    textEditingController: _controller.firstNameController!,
                    labelText: "First Name",
                    hintText: "Enter First Name",
                    errorMsg: 'Enter first name',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    fieldName: 'firstName',
                    focusNode: _firstNameFocus,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    pattern:
                        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$",
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.lastNameController!,
                    labelText: "Last Name",
                    hintText: "Enter Last Name",
                    errorMsg: 'Enter last name',
                    fieldName: 'lastName',
                    focusNode: _lastNameFocus,
                    pattern:
                        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$",
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                    onValidate: (value) {
                      onValidate(value);
                    },
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.mobileNumberController!,
                    labelText: "Mobile Number",
                    hintText: "Enter Mobile Number",
                    errorMsg: 'Enter valid mobile number',
                    pattern: r'^[6789]\d{9}$',
                    fieldName: 'mobileNumber',
                    inputType: InputType.number,
                    focusNode: _mobileNumberFocus,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.addressController!,
                    labelText: "Address",
                    hintText: "Enter Address",
                    errorMsg: 'Enter address',
                    fieldName: 'address',
                    focusNode: _addressFocus,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    inputType: InputType.text,
                    pattern:
                        r'^(?!.*([\w\W\s])\1{2,})(?!.{101,})[\w\W\s]{1,100}$',
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                      textEditingController: _controller.pincodeController!,
                      labelText: "Pincode",
                      hintText: "Enter Pincode",
                      errorMsg: 'Enter pincode',
                      focusNode: _pincodeFocus,
                      fieldName: 'pincode',
                      pattern: r'^\d{6}$',
                      onValidate: (value) {
                        onValidate(value);
                      },
                      inputType: InputType.number,
                      isPhoneCode: false,
                      controller: _controller,
                      isTextChanged: true,
                      onTextChange: (value) {
                        _controller.onPinCodeChange(value, context);
                      }),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.cityController!,
                    labelText: "City",
                    hintText: "Enter City",
                    errorMsg: 'Enter city',
                    fieldName: 'city',
                    focusNode: _cityFocus,
                    pattern:
                        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$",
                    inputType: InputType.text,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.stateController!,
                    labelText: "State",
                    hintText: "Enter State",
                    errorMsg: 'Enter state',
                    fieldName: 'state',
                    focusNode: _stateFocus,
                    pattern:
                        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$",
                    inputType: InputType.text,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    isPhoneCode: false,
                    isReadOnly: true,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.countryController!,
                    labelText: "Country",
                    hintText: "Enter Country",
                    errorMsg: 'Enter country',
                    fieldName: 'country',
                    focusNode: _countryFocus,
                    inputType: InputType.text,
                    pattern:
                        r"^(?!.*(?:([a-zA-Z])\1{3}))(?!.*(?:[^a-zA-Z\s]{3}))[a-zA-Z\s]{1,50}$",
                    isPhoneCode: false,
                    onValidate: (value) {
                      onValidate(value);
                    },
                    isReadOnly: true,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  Obx(
                    () => DefaultButton(
                        text: _controller.btnText.value,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.addAddress();
                          } else {
                            // List<FocusNode> errorFields = _getErrorFields();
                            if (errorField.isNotEmpty) {
                              _scrollToAndFocusField(errorField.first);
                              errorField = [];
                            }
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onValidate(name) {
    if (name != null) errorField.add(name);
  }

  void _scrollToAndFocusField(field) {
    if (field == 'firstName')
      _firstNameFocus.requestFocus();
    else if (field == 'lastName')
      _lastNameFocus.requestFocus();
    else if (field == 'mobileNumber')
      _mobileNumberFocus.requestFocus();
    else if (field == 'address')
      _addressFocus.requestFocus();
    else if (field == 'pincode')
      _pincodeFocus.requestFocus();
    else if (field == 'city')
      _cityFocus.requestFocus();
    else if (field == 'state')
      _stateFocus.requestFocus();
    else if (field == 'country') _countryFocus.requestFocus();
  }
}
