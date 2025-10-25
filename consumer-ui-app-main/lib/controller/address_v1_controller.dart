// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/address_v1_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/address/address_repo.dart';

class AddressV1Controller extends GetxController {
  AddressRepo? addressRepo;
  var profileData = [].obs; // Specify the type
  var formKeys = <String, GlobalKey<FormState>>{}.obs;
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  var isEditing = <String, bool>{}.obs;
  var isLoading = false.obs;
  var billingAddress = <String, bool>{}.obs;
  var shippingAddress = <String, bool>{}.obs;
  var showValidationErrors = <TextEditingController, bool>{}.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  Map<String, bool> validationState = {}; // Manages validation states.

  // Method to reset validation state when form is closed or canceled.
  void resetValidationState(String id) {
    validationState[id] = false;
  }

  @override
  void onInit() {
    super.onInit();
    addressRepo = AddressRepo();
    getTemplate();
    myAccountUserData();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'manage-address');
    isTemplateLoading.value = false;
  }

  Future<void> myAccountUserData() async {
    isLoading.value = true;
    try {
      var result = await addressRepo!.getUserMyAddressDetails('');
      var userDetails = myAddressFromJson(result);
      profileData.value = userDetails.addresses;
      isLoading.value = false;
      for (var address in userDetails.addresses) {
        if (address.sId != null) {
          formKeys[address.sId!] = GlobalKey<FormState>();
          billingAddress[address.sId!] = address.billingAddress ?? false;
          shippingAddress[address.sId!] = address.shippingAddress ?? false;
        } else {
          formKeys[address.sId!] = GlobalKey<FormState>();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void setEditing(String id, bool value) {
    if (id == 'new') {
      isEditing[id] = value;
      contactNameController.clear();
      emailController.clear();
      mobileController.clear();
      addressController.clear();
      landmarkController.clear();
      pinCodeController.clear();
      cityController.clear();
      stateController.clear();
      countryController.clear();
    } else {
      isEditing[id] = value;
    }
  }

  Future<void> updatePersonalInfo(String id) async {
    var data = {
      "addressInput": {
        "contactName": contactNameController.text,
        "address": addressController.text,
        "emailId": emailController.text,
        "mobileNumber": mobileController.text,
        "landmark": landmarkController.text,
        "pinCode": pinCodeController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "billingAddress": billingAddress[id],
        "shippingAddress": shippingAddress[id],
      },
      "addressId": id,
      "id": ""
    };
    // print("Updating address with data: $data");
    try {
      await addressRepo!.updateUserDetails(data);
      await myAccountUserData();
      // Get.back();
    } catch (e) {
      // print('Error updating address: $e');
    }
  }

  Future<void> addNewAddress(formKey) async {
    // print("data is here ${formKey}");
    var data = {
      'contactName': contactNameController.text,
      'address': addressController.text,
      'emailId': emailController.text,
      'mobileNumber': mobileController.text,
      'landmark': landmarkController.text,
      'pinCode': pinCodeController.text,
      'state': stateController.text,
      'country': countryController.text,
      'city': cityController.text,
      'billingAddress': billingAddress['new'],
      'shippingAddress': shippingAddress['new'],
    };
    // print("datadatadatadatadatadata ${data}");
    try {
      await addressRepo!.addAddressDetails(data);
      isLoading.value = true;
      await myAccountUserData();
    } catch (e) {
      print('Error updating address: $e');
    }
  }

  void removePersonalInfo(String id) async {
    var data = {
      "addressId": id,
      "id": "",
    };
    // print("Removing address with ID: $id"); // Debugging
    try {
      await addressRepo!.removeSingleAddress(data);
      await myAccountUserData();
    } catch (e) {
      print('Error removing address: $e');
    }
  }

  Future<void> setEditingValues(address, String id) async {
    contactNameController.text = address.contactName ?? '';
    emailController.text = address.emailId ?? '';
    mobileController.text = address.mobileNumber ?? '';
    addressController.text = address.address ?? '';
    landmarkController.text = address.landmark ?? '';
    pinCodeController.text = address.pinCode ?? '';
    stateController.text = address.state ?? '';
    countryController.text = address.country ?? '';
    cityController.text = address.city ?? '';
    billingAddress[address.sId ?? ''] = address.billingAddress ?? false;
    shippingAddress[address.sId ?? ''] = address.shippingAddress ?? false;
  }

  void updateBillingAddress(String id, bool? newValue) {
    billingAddress[id] = newValue ?? false;
  }

  void updateShippingAddress(String id, bool? newValue) {
    shippingAddress[id] = newValue ?? false;
  }

  Future<void> fetchStateAndCountry(String pincode, String addressId) async {
    try {
      var result = await addressRepo!.updatePincode(pincode);
      stateController.text = result['state'] ?? '';
      countryController.text = result['country'] ?? '';
    } catch (e) {
      print('Error fetching state and country: $e');
    }
  }

  void updateValidationState(TextEditingController controller, bool showError) {
    showValidationErrors[controller] = showError;
  }

  Future openAddAddress() async {
    var result = await Get.toNamed('/addAddress', arguments: {'type': 'new'});
    if (result != null) myAccountUserData();
  }

  Future openEditAddress(address) async {
    var result = await Get.toNamed('/addAddress',
        arguments: {'type': 'edit', 'address': address});
    if (result != null) myAccountUserData();
  }

  @override
  void onClose() {
    contactNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    pinCodeController.dispose();
    stateController.dispose();
    countryController.dispose();
    cityController.dispose();
    profileData.close();
    formKeys.close();
    isEditing.close();
    isLoading.close();
    billingAddress.close();
    shippingAddress.close();
    showValidationErrors.close();
    template.close();
    isTemplateLoading.close();
    super.onClose();
  }
}
