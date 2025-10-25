//
//import 'package:flutter/material.dart';

// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const/constant.dart';
import '../const/size_config.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController with BaseController {
  TextEditingController? userIdController, passwordController, otpController;
  LoginRepo? loginRepo;
  FirebaseAuth? auth;
  var initialLogin = true.obs;
  var isVisible = false.obs;
  var userDetails;
  var userDetailsResponse = {}.obs;
  var isLoading = false.obs;
  var verificationId;
  var inputData;
  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    passwordController = TextEditingController(text: '');
    userIdController = TextEditingController(text: '');
    otpController = TextEditingController();
    loginRepo = LoginRepo();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  changePasswordVisible() {
    isVisible.value = !isVisible.value;
  }

  // editLoginId() {
  //   initialLogin.value = true;
  // }

  Future accountLogin() async {
    if (isLoading.value == true) return;
    KeyboardUtil.hideKeyboard(Get.context!);
    inputData = getLoginInput();
    isLoading.value = true;
    var result = await loginRepo!.verifyUserForForgotPassword(inputData);
    isLoading.value = false;
    if (result != null) {
      if (result['error'] == false) {
        initialLogin.value = false;
        if (inputData['mobileNumber'] != null)
          phoneSignIn(inputData['mobileNumber']);
      }
      showSnackBar(result['message'], SnackPosition.BOTTOM);
    }
  }

  Future resendOtp() async {
    if (isLoading.value == true) return;
    inputData = getLoginInput();
    isLoading.value = true;
    var result = await loginRepo!.resendForgotPasswordOTP(inputData);
    isLoading.value = false;
    if (result != null) {
      if (inputData['mobileNumber'] != null)
        phoneSignIn(inputData['mobileNumber']);
      showSnackBar(result['message'], SnackPosition.BOTTOM);
    }
  }

  getLoginInput() {
    var input = {};
    var userId = userIdController!.text;
    bool isNumber = num.tryParse(userId) != null;
    if (isNumber) {
      input['mobileNumber'] = userId;
    } else {
      input['emailId'] = userId;
    }
    return input;
  }

  Future<void> phoneSignIn(mobileNumber) async {
    await auth!.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await auth!.signInWithCredential(authCredential);
        }
      }
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      // print("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) async {
    // print("code sent $verificationId");
    this.verificationId = verificationId;
    // showSnackBar("OTP Sent Successfully", SnackPosition.BOTTOM);
  }

  _onCodeTimeout(String timeout) {
    print(timeout);
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

  Future verifyOtp() async {
    if (isLoading.value == true) return;
    KeyboardUtil.hideKeyboard(Get.context!);
    if (inputData['emailId'] != null) {
      isLoading.value = true;
      var result = await loginRepo!
          .verifyForgotPasswordOtp(inputData, otpController!.text);
      isLoading.value = false;
      if (result != null) {
        if (result['error'] == false)
          Get.offAndToNamed('/newPassword', arguments: result);
        showSnackBar(result['message'], SnackPosition.BOTTOM);
      }
    } else if (inputData['mobileNumber'] != null) {
      verifySMSOTP(otpController!.text);
    }
  }

  Future verifySMSOTP(otp) async {
    try {
      isLoading.value = true;
      var credential = await auth!.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      if (credential.user != null) {
        var result = await loginRepo!
            .verifyForgotPasswordOtp(inputData, otpController!.text);
        isLoading.value = false;
        if (result != null) {
          if (result['error'] == false)
            Get.offAndToNamed('/newPassword', arguments: result);
          showSnackBar(result['message'], SnackPosition.BOTTOM);
        }
      }
    } catch (error) {
      isLoading.value = false;
      showSnackBar("Incorrect OTP", SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    userIdController!.dispose();
    passwordController!.dispose();
    otpController!.dispose();
    super.onClose();
  }
}
