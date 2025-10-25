// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressV1Controller extends GetxController with BaseController {
  TextEditingController? contactNameController,
      landmarkController,
      emailIdController,
      mobileNumberController,
      addressController,
      pincodeController,
      cityController,
      stateController,
      countryController;
  UserRepo? userRepo;
  var btnText = 'Submit'.obs;
  var isEdit = false;
  var userId;
  var editAddress;
  var billingAddress = false.obs;
  var isLoading = false.obs;
  var shippingAddress = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    contactNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    addressController = TextEditingController();
    landmarkController = TextEditingController();
    pincodeController = TextEditingController();
    emailIdController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    userRepo = UserRepo();
    var arguments = Get.arguments;
    getTemplate();
    if (arguments['type'] == 'edit') {
      editAddress = arguments['address'];
      contactNameController!.text = editAddress.contactName;
      landmarkController!.text = editAddress.landmark;
      emailIdController!.text = editAddress.emailId;
      mobileNumberController!.text = editAddress.mobileNumber;
      addressController!.text = editAddress.address;
      pincodeController!.text = editAddress.pinCode;
      cityController!.text = editAddress.city;
      stateController!.text = editAddress.state;
      countryController!.text = editAddress.country;
      shippingAddress.value = editAddress.shippingAddress;
      billingAddress.value = editAddress.billingAddress;
      btnText.value = 'Update';
      isEdit = true;
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'manage-address');
    isTemplateLoading.value = false;
  }

  Future onPinCodeChange(value, context) async {
    if (value != null && value.length > 5) {
      showLoading('Loading..');
      var result = await userRepo!.getPinCodeFormService(value);
      if (result != null) {
        stateController!.text = result['state'] ?? '';
        countryController!.text = result['country'] ?? '';
      }
      KeyboardUtil.hideKeyboard(context);
      hideLoading();
    }
  }

  Future addAddress() async {
    if (isLoading.value == true) return;
    var response;
    isLoading.value = true;
    var data = {
      "contactName": contactNameController!.text,
      "address": addressController!.text,
      "emailId": emailIdController!.text,
      "mobileNumber": mobileNumberController!.text,
      "landmark": landmarkController!.text,
      "pinCode": pincodeController!.text,
      "city": cityController!.text,
      "state": stateController!.text,
      "country": countryController!.text,
      "billingAddress": billingAddress.value,
      "shippingAddress": shippingAddress.value,
    };
    if (isEdit) {
      var editInput = {
        "addressInput": data,
        "addressId": editAddress.sId,
      };
      response = await userRepo!.updateAddressDetail(editInput);
    } else {
      response = await userRepo!.addAddressDetails(data);
    }
    isLoading.value = true;
    if (response != null) {
      Get.back(result: response);
    }
  }

  @override
  void onClose() {
    contactNameController!.dispose();
    mobileNumberController!.dispose();
    addressController!.dispose();
    landmarkController!.dispose();
    pincodeController!.dispose();
    emailIdController!.dispose();
    cityController!.dispose();
    stateController!.dispose();
    countryController!.dispose();
    btnText.close();
    billingAddress.close();
    isLoading.close();
    shippingAddress.close();
    template.close();
    isTemplateLoading.close();
    super.onClose();
  }
}
