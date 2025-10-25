import 'package:black_locust/common_component/custom_text_field.dart';
import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/add_address_v1_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressV1Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<AddAddressV1Controller>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding, horizontal: kDefaultPadding),
              child: Column(
                children: [
                  CustomTextFiled(
                    textEditingController: _controller.contactNameController!,
                    hintText: "Enter Contact Name",
                    labelText: "Contact Name",
                    errorMsg: 'Contact name is required',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.emailIdController!,
                    hintText: "Enter Email",
                    labelText: "Email",
                    errorMsg: 'Enter valid email',
                    inputType: InputType.email,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.mobileNumberController!,
                    hintText: "Enter Mobile Number",
                    labelText: "Mobile Number",
                    errorMsg: 'Enter valid mobile number',
                    inputType: InputType.number,
                    isPhoneCode: true,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.addressController!,
                    hintText: "Enter Address",
                    labelText: "Address",
                    errorMsg: 'Address is required',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.landmarkController!,
                    hintText: "Enter Landmark",
                    labelText: "Landmark",
                    errorMsg: null,
                    inputType: InputType.text,
                    isPhoneCode: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                      textEditingController: _controller.pincodeController!,
                      hintText: "Enter Pincode",
                      labelText: "Pincode",
                      errorMsg: 'Pincode is required',
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
                    hintText: "Enter City",
                    labelText: "City",
                    errorMsg: 'City is required',
                    inputType: InputType.text,
                    isPhoneCode: false,
                    isReadOnly: false,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.stateController!,
                    hintText: "Enter State",
                    labelText: "State",
                    errorMsg: 'State is required',
                    inputType: InputType.text,
                    enabled: false,
                    isPhoneCode: false,
                    isReadOnly: true,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CustomTextFiled(
                    textEditingController: _controller.countryController!,
                    hintText: "Enter Country",
                    labelText: "Country",
                    errorMsg: 'Country is required',
                    enabled: false,
                    inputType: InputType.text,
                    isPhoneCode: false,
                    isReadOnly: true,
                    controller: _controller,
                  ),
                  kDefaultHeight(kDefaultPadding),
                  CheckboxListTile(
                    title: Text("Billing Address"),
                    value: _controller.billingAddress.value,
                    onChanged: (newValue) {
                      _controller.billingAddress.value = newValue!;
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Shipping Address"),
                    value: _controller.shippingAddress.value,
                    onChanged: (bool? newValue) {
                      _controller.shippingAddress.value = newValue!;
                    },
                  ),
                  Obx(
                    () => DefaultButton(
                        text: _controller.btnText.value,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _controller.addAddress();
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
