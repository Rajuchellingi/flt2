//
//import 'package:flutter/material.dart';

// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:flutter/material.dart';
import '../const/constant.dart';
import '../const/size_config.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController with BaseController {
  TextEditingController? passwordController, confirmPasswordController;
  LoginRepo? loginRepo;
  var isVisible = false.obs;
  var isVisible1 = false.obs;
  var isLoading = false.obs;
  var token;
  @override
  void onInit() {
    passwordController = TextEditingController(text: '');
    confirmPasswordController = TextEditingController(text: '');
    loginRepo = LoginRepo();
    var args = Get.arguments;
    if (args != null) token = args['token'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  changePasswordVisible() {
    isVisible.value = !isVisible.value;
  }

  changePasswordVisible1() {
    isVisible1.value = !isVisible1.value;
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar(
      "", msg,
      snackPosition: position,
      backgroundColor: kTextColor,
      colorText: Colors.white,
      // duration: Duration(milliseconds: 10000),
      maxWidth: SizeConfig.screenWidth,
      borderRadius: 0,
      titleText: Container(),
      snackStyle: SnackStyle.FLOATING,
      // padding: EdgeInsets.all(kDefaultPadding / 2),
      // margin: EdgeInsets.all(0)
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  Future changePassword() async {
    if (isLoading.value == true) return;
    KeyboardUtil.hideKeyboard(Get.context!);
    isLoading.value = true;
    var result = await loginRepo!
        .verifyAndChangePassword(token, passwordController!.text);
    if (result != null) {
      if (result['error'] == false)
        Get.offAndToNamed('/login', arguments: {"path": "/home"});
      showSnackBar(result['message'], SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    super.onClose();
  }
}
