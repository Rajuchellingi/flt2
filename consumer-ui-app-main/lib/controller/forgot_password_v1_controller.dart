// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member
import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller.dart';

class ForgotPasswordV1Controller extends GetxController with BaseController {
  TextEditingController? emailController;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth? auth;
  LoginRepo? loginRepo;
  var isPasswordAvailable = false.obs;
  var initialLogin = true.obs;
  var isOtp = false.obs;
  var isLoading = false.obs;
  var updateFlags = [].obs;
  var btnText = 'Continue'.obs;
  bool shouldReload = false;
  bool showForgotPassword = false;
  final themeController = Get.find<ThemeController>();
  var isTemplateLoading = false.obs;
  var template = {}.obs;

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    loginRepo = LoginRepo();
    emailController = TextEditingController(); // Initialize emailController
    super.onInit();
    getTemplate();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'forgot-password');
    isTemplateLoading.value = false;
  }

  Future<void> forgetPassword(data) async {
    showLoading('Loading..');
    var email = emailController!.text;
    var result = await loginRepo!.forgetassword(email);
    hideLoading();
    if (result != null) {
      if (result['customerUserErrors'] != null &&
          result['customerUserErrors'].length > 0) {
        var message = result['customerUserErrors'].first;
        showMessage(message['message']);
      } else if (result['errors'] != null && result['errors'].length > 0) {
        var message = result['errors'].first;
        showMessage(message.message);
      } else {
        var message =
            "Reset password email sent! Please check your inbox for the link.";
        showMessage(message);
        Get.back();
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Could not find customer'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  showMessage(message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void onClose() {
    emailController!.dispose(); // Dispose emailController
    super.onClose();
  }
}
