// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/postal_code_model.dart';
import 'package:black_locust/services/common_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController with BaseController {
  TextEditingController? contactNameController,
      firstNameController,
      lastNameController,
      companyNameController,
      emailIdController,
      mobileNumberController,
      addressController,
      pincodeController,
      cityController,
      stateController,
      countryController;
  CommonService? commonService;
  UserRepo? userRepo;
  var btnText = 'Submit'.obs;
  var isEdit = false;
  var userId;
  var editAddress;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    contactNameController = TextEditingController();
    companyNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailIdController = TextEditingController();
    mobileNumberController = TextEditingController();
    addressController = TextEditingController();
    pincodeController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    commonService = CommonService();
    userRepo = UserRepo();
    userId = GetStorage().read('utoken');
    getTemplate();
    editAddress = Get.arguments;
    if (editAddress != null) {
      firstNameController!.text = editAddress.firstName ?? '';
      lastNameController!.text = editAddress.lastName ?? '';
      // contactNameController!.text = editAddress.contactName;
      companyNameController!.text =
          editAddress.company != null ? editAddress.company : '';
      // emailIdController!.text = editAddress.emailId;
      mobileNumberController!.text = editAddress.phone ?? '';
      addressController!.text = editAddress.address ?? '';
      pincodeController!.text = editAddress.zip ?? '';
      cityController!.text = editAddress.city ?? '';
      stateController!.text = editAddress.province ?? '';
      countryController!.text = editAddress.country ?? '';
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
    try {
      if (value != null && value.length > 5) {
        showLoading('Loading..');
        var result = await commonService!.getPostalCode(value);
        hideLoading();
        var response = postalCodeVMFromJson(result);
        if (response != null && response.postOffice.length > 0) {
          var address = response.postOffice.first;
          cityController!.text = address.district!;
          stateController!.text = address.state!;
          countryController!.text = address.country!;
        } else {
          cityController!.text = '';
          stateController!.text = '';
          countryController!.text = '';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Enter a valid pincode'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        KeyboardUtil.hideKeyboard(context);
      }
    } catch (error) {
      hideLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter a valid pincode'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future addAddress() async {
    var response;
    showLoading('Loading...');
    // var request = UpdateAddAddressRequestModel(
    //     addressId: isEdit ? editAddress.sId : '',
    //     addressInput: new UserAddressRequestModel(
    //         contactName: contactNameController!.text,
    //         companyName: companyNameController!.text,
    //         address: addressController!.text,
    //         emailId: emailIdController!.text,
    //         mobileNumber: mobileNumberController!.text,
    //         mobileNumber: mobileNumberController!.text,
    //         mobileNumber: mobileNumberController!.text,
    //         pinCode: pincodeController!.text,
    //         city: cityController!.text,
    //         state: stateController!.text,
    //         country: countryController!.text,
    //         billingAddress:
    //             editAddress != null ? editAddress.billingAddress : false),
    var request = {
      "firstName": this.firstNameController!.text,
      "lastName": this.lastNameController!.text,
      "phone": this.mobileNumberController!.text,
      "company": this.companyNameController!.text,
      // "email": this.emailIdController!.text,
      "address1": this.addressController!.text,
      "zip": this.pincodeController!.text,
      "city": this.cityController!.text,
      "country": this.countryController!.text,
      'province': stateController!.text,
      // "address1": this.addressController!.text,
    };
    //     sId: userId);
    if (isEdit) {
      var addressId = editAddress.sId;
      response = await userRepo!.updateAddress(request, userId, addressId);
    } else {
      response = await userRepo!.addAddress(request, userId);
    }
    hideLoading();
    if (response == true) {
      Get.back(result: response);
    }
  }

  @override
  void onClose() {
    contactNameController!.dispose();
    companyNameController!.dispose();
    firstNameController!.dispose();
    lastNameController!.dispose();
    emailIdController!.dispose();
    mobileNumberController!.dispose();
    addressController!.dispose();
    pincodeController!.dispose();
    cityController!.dispose();
    stateController!.dispose();
    countryController!.dispose();
    btnText.close();
    template.close();
    isTemplateLoading.close();
    super.onClose();
  }
}
