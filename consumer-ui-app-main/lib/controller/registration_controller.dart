// controller.dart
// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member, unrelated_type_equality_checks

import 'dart:async';

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:b2b_graphql_package/modules/registration/registration_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/dailog_helper.dart';
import 'package:flutter/material.dart';
import '../const/constant.dart';
import '../const/size_config.dart';
import '../model/registration_model.dart';

import '../const/model_form_field.dart';
import '../helper/keyboard.dart';
import '../model/enum.dart';
import '../model/postal_code_model.dart';
import '../model/user_model.dart';
import '../services/common_service.dart';
import 'base_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'notification_controller.dart';

class RegistrationController extends GetxController with BaseController {
  var registerForm = defaultRegistrationForm;
  // var contactForm = modelContactForm;
  // var addressForm = agencyAddressForm;
  var textController = [].obs;
  CommonService? commonService;
  TextEditingController? confirmPasswordController;
  LoginRepo? loginRepo;
  RegistrationRepo? registrationRepo;
  CartRepo? cartRepo;
  UserRepo? userRepo;
  final _notificationController = Get.find<NotificationController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var isLoading = false.obs;
  var buttonName = 'Sign Up'.obs;
  var isProgress = false.obs;
  final themeController = Get.find<ThemeController>();
  var isUserType = false.obs;

  @override
  void onInit() {
    confirmPasswordController = TextEditingController();
    commonService = CommonService();
    loginRepo = LoginRepo();
    registrationRepo = RegistrationRepo();
    cartRepo = CartRepo();
    userRepo = new UserRepo();
    getTemplate();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'register');
    // if (template.value != null) {
    //   if (template.value['instanceId'] == 'design3')
    //     registerForm = userRegistrationForm2;
    //   else
    //     registerForm = userRegistrationForm;
    // }
    assignRegistrationForm();
    setTextFieldValue();
    isTemplateLoading.value = false;
  }

  assignRegistrationForm() {
    if (template.value != null &&
        template.value['layout'] != null &&
        template.value['layout']['blocks'] != null &&
        template.value['layout']['blocks'].isNotEmpty) {
      var formComponent = template.value['layout']['blocks'].firstWhere(
          (element) => element['componentId'] == 'form-component',
          orElse: () => null);
      if (formComponent != null &&
          formComponent['lists'] != null &&
          formComponent['lists'].isNotEmpty) {
        var form = formComponent['lists']
            .where((element) => element['visibility']['hide'] == false)
            .toList();
        if (form != null && form.length > 0) {
          var parsedList = form.map((item) {
            return item as Map<String, Object?>;
          }).toList();
          registerForm = parsedList.cast<Map<String, Object?>>();
          if (formComponent['source'] != null &&
              formComponent['source']['buttonName'] != null &&
              formComponent['source']['buttonName'].isNotEmpty) {
            buttonName.value = formComponent['source']['buttonName'];
          }
        }
      }
    }
  }

  setTextFieldValue() {
    registerForm.forEach((element) {
      var _fController = {};
      _fController[element['name']] = TextEditingController();
      textController.add(_fController);
    });
    registerForm.forEach((element) {
      var _fController = {};
      _fController[element['name']] = TextEditingController();
      textController.add(_fController);
    });
    // addressForm.forEach((element) {
    //   var _fController = {};
    //   _fController[element['name']] = TextEditingController();
    //   textController.add(_fController);
    // });
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

  Future onPinCodeChange(value, context) async {
    if (value != null && value.length == 6) {
      showLoading('Loading..');
      var result = await commonService!.getPostalCode(value);
      var response = postalCodeVMFromJson(result);
      if (response != null && response.postOffice.length > 0) {
        var address = response.postOffice.first;
        setAddressByPincode(address);
      }
      KeyboardUtil.hideKeyboard(context);
      hideLoading();
    }
  }

  setAddressByPincode(address) {
    var details = [];
    registerForm.forEach((element) {
      var value = getFormDetails(element);
      var _fController = {};
      if (element == 'city')
        _fController[element] = TextEditingController(text: address.district);
      else if (element == 'state')
        _fController[element] = TextEditingController(text: address.state);
      else if (element == 'country')
        _fController[element] = TextEditingController(text: address.country);
      else
        _fController[element] = TextEditingController(text: value);
      details.add(_fController);
    });
    textController.value = [];
    textController.value = details;
  }

  getFormDetails(name) {
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController != null)
      return textEditingController[name].text;
    else
      return null;
  }

  Future submitForm(context) async {
    showLoading('Loading...');
    var model = getAgencyInput();
    var email = model['email'];
    var password = model['password'];
    var result = await registrationRepo!.customerCreate(model);
    if (result != null) {
      var response = registrationModelVMFromJson(result);
      if (response.error != null) {
        hideLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!.message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        var getToken =
            await loginRepo!.logInWithEmailAndPassword(email, password);
        if (getToken != null && getToken['accessToken'] != null) {
          var response = LoginTokenVMJson(getToken);
          GetStorage().write("utoken", getToken['accessToken']);
          GetStorage().write("userExpiry", getToken['expiresAt']);
          var input = {
            "buyerIdentity": {
              "email": email,
            }
          };
          var shopifyUser = await createShopifyUser(getToken['accessToken']);
          var cartId = GetStorage().read("cartId");
          if (cartId == null) {
            var getCartId = await cartRepo!.createCart(input);
            GetStorage().write("cartId", getCartId['cart']['id']);
            GetStorage().write("cartExpiry", getCartId['cart']['updatedAt']);
          } else {
            await cartRepo!
                .cartBuyerIdentityUpdate(cartId, input['buyerIdentity']);
          }
          var userId = GetStorage().read("utoken");
          var userExpiry = GetStorage().read("userExpiry");
          clearInputvalues();
          hideLoading();
          if (userId != null) {
            DailogHelper.showInfoDailog(
                title: "Success!!!",
                description: "Your account created successfully.",
                onPressed: () {
                  // Get.back(result: registerForm);
                  // Get.offAllNamed('/home');
                  navigateByArgument();
                  Get.back(result: getToken['accessToken']);
                });
            // Get.toNamed('/home');
          }
        } else {
          hideLoading();
        }
      }
    }
  }

  navigateByArgument() async {
    var argument = Get.arguments;
    if (argument != null) {
      var path = argument['path'];
      var pathArgs = argument['arguments'];
      if (pathArgs != null) {
        await Get.offAllNamed(path, arguments: pathArgs);
      } else {
        await Get.offAllNamed(path);
      }
    } else {
      await Get.offAllNamed("/home");
    }
  }

  updateCustomerMetafield(customerId) {
    var metafields = metafieldInput();
    if (metafields != null && metafields.isNotEmpty) {
      registrationRepo!.updateCustomerMetafields(customerId, metafields);
    }
  }

  Future createShopifyUser(userId) async {
    var userResult = await userRepo!.getUserById(userId, []);
    if (userResult != null) {
      var userData = userDetailsVMFromJson(userResult);
      GetStorage().write("customerId", userData.sId);
      var user = {"customerId": userData.sId};
      if (userData.emailId != null) user['emailId'] = userData.emailId;
      if (userData.firstName != null) user['firstName'] = userData.firstName;
      if (userData.lastName != null) user['lastName'] = userData.lastName;
      if (userData.mobileNumber != null)
        user['mobileNumber'] = userData.mobileNumber;
      var token = await _notificationController.checkPermissionAndGetToken();
      user['deviceToken'] = token;
      var result = await registrationRepo!.createShopifyUser(user);
      updateCustomerMetafield(userData.sId);
      if (result != null) {
        var response = userRegisterVMFromJson(result);
        return response;
      }
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

  Map<String, dynamic> getAgencyInput() {
    Map<String, dynamic> agencyInput = {};
    registerForm.forEach((element) {
      if (element['fieldType'] == 'form-field')
        agencyInput[element['name'].toString()] =
            getControllerValue(element['name']);
    });
    return agencyInput;
  }

  getControllerValue(name) {
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController[name].text.isNotEmpty) {
      var value = textEditingController[name].text;
      if (name == "gender") {
        return int.parse(value);
      } else if (name == "phone") {
        return "+91$value";
      } else {
        return value;
      }
    } else
      return null;
  }

  clearInputvalues() {
    var details = [];
    registerForm.forEach((element) {
      var _fController = {};
      _fController[element['name']] = TextEditingController(text: '');
      details.add(_fController);
    });
    textController.value = [];
    textController.value = details;
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar("", msg,
        snackPosition: position,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        isDismissible: false,

        // duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        // padding: EdgeInsets.all(kDefaultPadding / 2),
        // margin: EdgeInsets.all(0)
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
