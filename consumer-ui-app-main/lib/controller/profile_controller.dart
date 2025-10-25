// ignore_for_file: invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/const/model_form_field.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/product_detail_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController with BaseController {
  UserRepo? userRepo;
  var userId;
  var isLoading = false.obs;
  var cartBagCount = 0.obs;
  var isLoggedIn = false.obs;
  var pageIndex = 0.obs;
  var phoneNumber;
  var registerForm = defaultRegistrationForm;
  var textController = [].obs;

  var userProfile = new UserDetailsVM(
    sId: "",
    altIsdCode: 0,
    altMobileNumber: "",
    userTypeName: "",
    companyName: "",
    contactName: "",
    numberOfAddresses: 0,
    numberOfOrders: 0,
    emailId: "",
    firstName: "",
    gstNumber: "",
    isdCode: 0,
    metafields: null,
    lastName: "",
    mobileNumber: "",
  ).obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final commonController = Get.find<CommonController>();
  var metafields = [];
  var isPrizma = false.obs;
  final pluginController = Get.find<PluginsController>();
  @override
  void onInit() {
    userId = GetStorage().read('utoken');
    userRepo = new UserRepo();
    getTemplate();
    checkIsMobileLogin();
    if (userId != null) {
      getProfile(userId);
    }
    super.onInit();
  }

  void onTabTapped(int index) {
    this.pageIndex.value = index;
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-profile');
    assignRegistrationForm();
    isTemplateLoading.value = false;
  }

  Future logOut() async {
    commonController.logOut();
  }

  checkIsMobileLogin() {
    var plugin = pluginController.getPluginValue('prizma-otp');
    if (plugin != null) {
      isPrizma.value = true;
    } else {
      isPrizma.value = false;
    }
  }

  Future getProfile(String id) async {
    this.isLoading.value = true;
    var result = await userRepo!.getUserById(id, metafields);
    if (result != null) {
      userProfile.value = userDetailsVMFromJson(result);
      setTextFieldValue();
      var mobile = userProfile.value.mobileNumber;
      if (mobile != null) {
        if (mobile.startsWith("+91")) {
          mobile = mobile.substring(3);
        }
        if (mobile.length == 10 && int.tryParse(mobile) != null) {
          phoneNumber = mobile;
        } else {
          print("Invalid mobile number format");
        }
      }
    }
    this.isLoading.value = false;
    // print("phoneNumber: -->>>! $phoneNumber");
  }

  Future updateProfilePage(type) async {
    var result = await Get.toNamed('/updateProfile',
        arguments: [userProfile.value, type]);
    if (result != null && result == true) {
      getProfile(userId);
    }
  }

  assignRegistrationForm() {
    List<dynamic> allTemplates = themeController.allTemplate.value;
    var registrationTemplate =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'register');
    if (registrationTemplate != null &&
        registrationTemplate['layout'] != null &&
        registrationTemplate['layout']['blocks'] != null &&
        registrationTemplate['layout']['blocks'].isNotEmpty) {
      var formComponent = registrationTemplate['layout']['blocks'].firstWhere(
          (element) => element['componentId'] == 'form-component',
          orElse: () => null);
      if (formComponent != null &&
          formComponent['lists'] != null &&
          formComponent['lists'].isNotEmpty) {
        var form = formComponent['lists']
            .where((element) =>
                element['visibility']['hide'] == false &&
                element['name'] != 'password')
            .toList();
        if (form != null && form.length > 0) {
          var parsedList = form.map((item) {
            return item as Map<String, Object?>;
          }).toList();
          registerForm = parsedList.cast<Map<String, Object?>>();
          var metaObjects = formComponent['lists']
              .where((element) => element['fieldType'] == 'metafield')
              .toList();
          if (metaObjects != null && metaObjects.length > 0) {
            metafields = metaObjects.map((item) {
              return {"key": item["key"], "namespace": item["namespace"]};
            }).toList();
          }
        }
      }
    }
  }

  setTextFieldValue() {
    textController.value = [];
    print('reeeeeeeeeeeeeeeeeeeeeeeeeeee $registerForm');
    registerForm.forEach((element) {
      var value = getValue(element);
      var _fController = {};
      _fController[element['name']] = TextEditingController(text: value);
      textController.add(_fController);
    });
  }

  getValue(field) {
    var fieldType = field['fieldType'];
    var name = field['name'];
    if (fieldType == 'metafield') {
      var metafieldValue = metaFieldData(field);
      return metafieldValue.value ?? '';
    } else {
      var userValue = userProfile.toJson();
      if (name == 'email' || name == 'emailId') {
        return userProfile.value.emailId ?? '';
      } else if (name == 'phone' ||
          name == 'mobileNumber' ||
          name == 'mobile') {
        return userProfile.value.mobileNumber ?? '';
      } else {
        return userValue[name] ?? '';
      }
    }
  }

  metaFieldData(data) {
    var key = data['key'];
    var namespace = data['namespace'];
    dynamic value = userProfile.value.metafields!.firstWhere(
        (element) => element.key == key && element.namespace == namespace,
        orElse: () => MetafieldVM(
            id: null,
            description: null,
            key: null,
            namespace: null,
            reference: null,
            references: null,
            type: null,
            value: null));
    return value;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
