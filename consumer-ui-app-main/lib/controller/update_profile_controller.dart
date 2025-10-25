// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:b2b_graphql_package/modules/registration/registration_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/const/model_form_field.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/model/product_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/registration_model.dart';

class UpdateProfileController extends GetxController with BaseController {
  UserRepo? userRepo;
  LoginRepo? loginRepo;
  TextEditingController? contactNameController,
      firstNameController,
      companyNameController,
      lastNameController,
      emailIdController,
      mobileNumberController,
      altmobileNumberController,
      otpController,
      passwordController,
      oldPasswordController,
      confirmPasswordController,
      newPasswordController;
  var userId;
  var profileDetails;
  var updateType;
  var verificationId;
  var btnText = 'Update'.obs;
  var title = ''.obs;
  var otpEnable = false.obs;
  final _countController = Get.find<CartCountController>();
  final _notificationController = Get.find<NotificationController>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  var registerForm = defaultRegistrationForm;
  var textController = [].obs;
  RegistrationRepo? registrationRepo;

  @override
  void onInit() {
    userRepo = new UserRepo();
    registrationRepo = RegistrationRepo();
    loginRepo = new LoginRepo();
    contactNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    companyNameController = TextEditingController();
    emailIdController = TextEditingController();
    mobileNumberController = TextEditingController();
    altmobileNumberController = TextEditingController();
    otpController = TextEditingController();
    passwordController = TextEditingController(text: '********');
    oldPasswordController = TextEditingController(text: '********');
    newPasswordController = TextEditingController(text: '********');
    confirmPasswordController = TextEditingController();
    userId = GetStorage().read('utoken');
    getTemplate();
    if (Get.arguments != null && Get.arguments.length > 0) {
      profileDetails = Get.arguments[0];
      // profileDetails.refresh();
      if (profileDetails != null) {
        firstNameController!.text = profileDetails.firstName;
        lastNameController!.text = profileDetails.lastName;
        // contactNameController!.text = profileDetails.contactName;
        // profileDetails.firstName + " " + profileDetails.lastName;
        if (profileDetails.companyName != null)
          companyNameController!.text = profileDetails.companyName;
        emailIdController!.text = profileDetails.emailId;
        var mobileValue = profileDetails.mobileNumber;
        // mobileNumberController!.text = profileDetails.mobileNumber;
        if (mobileValue != null && mobileValue!.startsWith("+91")) {
          mobileValue = mobileValue.substring(3);
        }
        if (mobileValue != null &&
            mobileValue.length == 10 &&
            int.tryParse(mobileValue) != null) {
          mobileNumberController!.text = mobileValue;
        } else {
          print("Invalid mobile number format");
        }
        // altmobileNumberController!.text = profileDetails.altMobileNumber;
        oldPasswordController!.text = '';
        newPasswordController!.text = '';
        confirmPasswordController!.text = '';
      }
      this.updateType = Get.arguments[1];
    }

    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'update-profile');
    isTemplateLoading.value = false;
  }

  setInitialValues(value, type) {
    contactNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    companyNameController = TextEditingController();
    emailIdController = TextEditingController();
    mobileNumberController = TextEditingController();
    altmobileNumberController = TextEditingController();
    otpController = TextEditingController();
    passwordController = TextEditingController(text: '********');
    oldPasswordController = TextEditingController(text: '********');
    newPasswordController = TextEditingController(text: '********');
    userId = GetStorage().read('utoken');
    profileDetails = value;
    // profileDetails.refresh();
    if (profileDetails != null) {
      firstNameController!.text = profileDetails.firstName;
      lastNameController!.text = profileDetails.lastName ?? '';
      // contactNameController!.text = profileDetails.contactName;
      // profileDetails.firstName + " " + profileDetails.lastName;
      if (profileDetails.companyName != null)
        companyNameController!.text = profileDetails.companyName;
      emailIdController!.text = profileDetails.emailId;
      var mobileValue = profileDetails.mobileNumber;
      // mobileNumberController!.text = profileDetails.mobileNumber;
      if (mobileValue != null && mobileValue!.startsWith("+91")) {
        mobileValue = mobileValue.substring(3);
      }
      if (mobileValue != null &&
          mobileValue.length == 10 &&
          int.tryParse(mobileValue) != null) {
        mobileNumberController!.text = mobileValue;
      } else {
        print("Invalid mobile number format");
      }
      // altmobileNumberController!.text = profileDetails.altMobileNumber;
      oldPasswordController!.text = '';
      newPasswordController!.text = '';
      confirmPasswordController!.text = '';
    }
    this.updateType = type;
    if (type == 'password') {
      btnText.value = 'SAVE PASSWORD';
      title.value = 'Password Change';
    } else {
      title.value = 'Change Personal Information';
      btnText.value = 'SAVE';
    }
  }

  Future updateProfile() async {
    var type = this.updateType;
    switch (type) {
      case "name":
        await updateNameDetails();
        break;
      case "email":
        await emailIdUpdate();
        break;
      case "mobile":
        await updateMobile();
        break;
      case "password":
        await updatePassword();
        break;
      case "personal-info":
        await updatePersonalInfo();
        break;
      default:
    }
    // type.refresh();
  }

  Future updateNameDetails() async {
    var user = {
      'firstName': this.firstNameController!.text,
      'lastName': this.lastNameController!.text,
    };
    var result = await userRepo!.updateUserProfile(user, userId);
    if (result != null) {
      Get.back(result: true);
    }
  }

  Future updatePersonalInfo() async {
    showLoading("Loading...");
    var user = getUpdateInput();
    var editedMobileNumber = this.mobileNumberController!.text;
    if (editedMobileNumber != null && editedMobileNumber.isNotEmpty) {
      user['phone'] = '+91$editedMobileNumber';
    }
    var result = await userRepo!.updateUserProfile(user, userId);
    await updateCustomerMetafield();
    hideLoading();
    if (result != null) {
      Get.back(result: true);
      CommonHelper.showSnackBarAddToBag('Sucessfully Updated');
    }
  }

  Future updateCustomerMetafield() async {
    var customerId = GetStorage().read('customerId');
    var metafields = metafieldInput();
    if (metafields != null && metafields.isNotEmpty) {
      await registrationRepo!.updateCustomerMetafields(customerId, metafields);
    }
  }

  metafieldInput() {
    var input = [];
    registerForm.forEach((element) {
      if (element['fieldType'] == 'metafield') {
        var value = getControllerValue(element['name']);
        if (value != null) {
          var data = {
            "key": element['key'],
            "value": value != null ? value.toString() : null,
            "type": element['type'].toString(),
            "namespace": element['namespace'],
          };
          input.add(data);
        }
      }
    });
    return input;
  }

  Map<String, dynamic> getUpdateInput() {
    Map<String, dynamic> updateInput = {};
    registerForm.forEach((element) {
      if (element['fieldType'] == 'form-field' && element['name'] != 'password')
        updateInput[element['name'].toString()] =
            getControllerValue(element['name']);
    });
    return updateInput;
  }

  getControllerValue(name) {
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController[name].text.isNotEmpty) {
      var value = textEditingController[name].text;
      if (name == "gender") {
        return int.parse(value);
      } else if (name == "phone") {
        return value.contains("+91") ? value : "+91$value";
      } else {
        return value;
      }
    } else
      return null;
  }

  Future emailIdUpdate() async {
    var user = {'email': this.emailIdController!.text};
    var result = await userRepo!.updateUserProfile(user, userId);

    print("result emailIdUpdate ${result.toJson()}");

    if (result.error == null) {
      Get.back(result: true);
      CommonHelper.showSnackBarAddToBag('Sucessfully Update the Email Id');
    } else {
      CommonHelper.showSnackBarAddToBag('Email Id Exist');
    }
  }

  Future updatePassword() async {
    showLoading('Loading...');
    var result = await loginRepo!.logInWithEmailAndPassword(
      this.emailIdController!.text,
      this.oldPasswordController!.text,
    );
    if (result != null && result['accessToken'] != null) {
      // var response = loginUserDetailsVMFromJson(result);
      // print("response---> $response");
      if (result['accessToken'] != null) {
        userId = result['accessToken'];
        GetStorage().write("utoken", result['accessToken']);

        var user = {'password': this.newPasswordController!.text};
        var results = await userRepo!.updateUserProfile(user, userId);
        // print('results $results');
        if (results != null) {
          var response = registrationModelVMFromJson(results);
          if (response.error != null) {
            hideLoading();
            CommonHelper.showSnackBarAddToBag(response.error!.message);
          } else {
            hideLoading();
            logOut();
            checkLogin();
            CommonHelper.showSnackBarAddToBag(
                'Password successfully updated. Please login to continue');
          }
        } else {
          hideLoading();
          CommonHelper.showSnackBarAddToBag("Password not updated");
        }
      }
    } else {
      hideLoading();
      CommonHelper.showSnackBarAddToBag('Incorrect password');
    }
  }

  Future checkLogin() async {
    var result =
        await Get.offAndToNamed('/login', arguments: {"path": "/home"});
    // print('login result $result');
    // if (result != null) {
    // Get.offAndToNamed('/home');
    // }
  }

  Future updateMobile() async {
    var editedMobileNumber = this.mobileNumberController!.text;
    var phoneNumberWithCountryCode = '+91$editedMobileNumber';
    var user = {'phone': phoneNumberWithCountryCode};
    var result = await userRepo!.updateUserProfile(user, userId);
    // print("result updateMobile ${result.toJson()}");
    if (result.error == null) {
      Get.back(result: true);
      CommonHelper.showSnackBarAddToBag('Sucessfully Update the Mobile Number');
    } else {
      CommonHelper.showSnackBarAddToBag('Mobile Number is Exist');
    }
  }

  getInputType(type) {
    switch (type) {
      case 'text':
        return InputType.text;
      case 'number':
        return InputType.number;
      case 'file':
        return InputType.file;
      case 'select':
        return InputType.select;
      case 'radio':
        return InputType.radio;
      case 'checkbox':
        return InputType.checkbox;
      case 'email':
        return InputType.email;
      case 'password':
        return InputType.password;
      case 'number':
        return InputType.number;
      case 'date':
        return InputType.date;
      case 'textarea':
        return InputType.multiLine;
      default:
        return InputType.text;
    }
  }

  assignRegistrationForm(value, type) {
    profileDetails = value;
    this.updateType = type;
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
        }
      }
    }
    if (type == 'password') {
      btnText.value = 'SAVE PASSWORD';
      title.value = 'Password Change';
    } else {
      title.value = 'Change Personal Information';
      btnText.value = 'SAVE';
    }

    setTextFieldValue();
  }

  setTextFieldValue() {
    textController.value = [];
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
      var userValue = profileDetails.toJson();
      if (name == 'email' || name == 'emailId') {
        return profileDetails.emailId ?? '';
      } else if (name == 'phone' ||
          name == 'mobileNumber' ||
          name == 'mobile') {
        return profileDetails.mobileNumber ?? '';
      } else {
        return userValue[name] ?? '';
      }
    }
  }

  metaFieldData(data) {
    var key = data['key'];
    var namespace = data['namespace'];
    dynamic value = profileDetails.metafields!.firstWhere(
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

  Future logOut() async {
    GetStorage().remove('utoken');
    GetStorage().remove('cartId');
    GetStorage().remove('wishlist');
    _countController.onLogout();
    _notificationController.onLogout();
    commonWishlistController.clearAllWishlist();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
