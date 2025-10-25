// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/registration/registration_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/const/constant.dart';

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpVerificationController extends GetxController {
  final List<String> otpValues = [];
  var userData;
  var verificationId;
  var mobileNumberVerified = false.obs;
  var emailVerified = false.obs;
  var isLoading = false.obs;
  final storage = GetStorage();
  UserRepo? userRepo;
  FirebaseAuth? auth;
  final _countController = Get.find<CartCountController>();
  final musicController = Get.find<MusicController>();
  final loyalityController = Get.find<LoyalityController>();
  RegistrationRepo? registrationRepo;
  final _notificationController = Get.find<NotificationController>();

  @override
  void onInit() {
    super.onInit();
    registrationRepo = RegistrationRepo();
    auth = FirebaseAuth.instance;
    var args = Get.arguments;
    userData = args['userData'];
    verificationId = args['verificationId'];
    storage.write('userData', userData);
    userRepo = UserRepo();
  }

  List<String> getOtpValues() {
    return otpValues;
  }

  void handleMobileOtpVerify(String otp) {
    // saveOtp(otp);
    // print('Mobile OTP saved: ${getOtpValues()}');
  }

  Future handleVerify(smsOtp, emailOtp, type) async {
    if (isLoading.value == true) return;
    var userid = storage.read('userData');
    var data = {
      "tempId": userid['tempId'],
      "emailOtp": "",
      "smsOtp": "",
      // "verifyType":"",
    };
    if (userid['smsOtp'] == true && userid['emailOtp'] == false) {
      data["smsOtp"] = smsOtp;
      // data['verifyType'] = "sms";
    }
    if (userid['emailOtp'] == true && userid['smsOtp'] == false) {
      data["emailOtp"] = emailOtp;
      // data['verifyType'] = "email";
    }

    var inputData = {
      "tempId": userid['tempId'],
      "emailOtp": emailOtp,
      "smsOtp": smsOtp,
      "verifyType": emailOtp.isNotEmpty ? "email" : "sms",
    };
    if (type == 'sms') {
      if (smsOtp != null && smsOtp.isNotEmpty) {
        verifySMSOTP(smsOtp, inputData);
      } else {
        snackMessage("OTP is required");
      }
    } else if (type == 'email') {
      if (emailOtp != null && emailOtp.isNotEmpty) {
        if (this.userData['smsOtp'] == true &&
            this.userData['emailOtp'] == true) {
          isLoading.value = true;
          var result = await userRepo!.createEmailAndSmsOtp(inputData);
          isLoading.value = false;
          print('result $result');
          if (result['error'] == false) {
            emailVerified.value = true;
            snackMessage(result['message']);
          } else if (result['error'] == true) {
            snackMessage(result['message']);
          }
        } else {
          var input = {'tempId': this.userData['tempId'], 'emailOtp': emailOtp};
          isLoading.value = true;
          var result = await userRepo!.createEmailorSmsOtp(input);
          snackMessage(result['message']);
          if (result['error'] == false) {
            _countController.getCartCount();
            musicController.startMusicByLogin();
            // _countController.getWishlistCount();
            // Get.offAllNamed('/home');
            loyalityController.getLoyalityDataAfterLogin();
            var token =
                await _notificationController.checkPermissionAndGetToken();
            await registrationRepo!.updateShopifyUserDeviceToken(null, token);
            isLoading.value = false;
            navigateByArgument();
          }
        }
      } else {
        snackMessage("OTP is required");
      }
    }
  }

  Future verifySMSOTP(otp, input) async {
    try {
      isLoading.value = true;
      var credential = await auth!.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      isLoading.value = false;
      if (credential.user != null) {
        if (this.userData['smsOtp'] == true &&
            this.userData['emailOtp'] == true) {
          isLoading.value = true;
          var result = await userRepo!.createEmailAndSmsOtp(input);
          isLoading.value = false;
          if (result['error'] == false) {
            mobileNumberVerified.value = true;
            snackMessage(result['message']);
          } else if (result['error'] == true) {
            snackMessage(result['message']);
          }
        } else {
          var input = {'tempId': this.userData['tempId'], 'smsOtp': otp};
          isLoading.value = true;
          var result = await userRepo!.createEmailorSmsOtp(input);
          isLoading.value = false;
          snackMessage(result['message']);
          if (result['error'] == false) {
            _countController.getCartCount();
            musicController.startMusicByLogin();
            // _countController.getWishlistCount();
            // Get.offAllNamed('/home');
            loyalityController.getLoyalityDataAfterLogin();
            var token =
                await _notificationController.checkPermissionAndGetToken();
            await registrationRepo!.updateShopifyUserDeviceToken(null, token);
            navigateByArgument();
          }
        }
      }
    } catch (error) {
      snackMessage("Incorrect OTP");
    }
  }

  Future resendOTP(resend) async {
    if (isLoading.value == true) return;
    isLoading.value = true;
    var result = await userRepo!.resendOTP(this.userData['tempId'], resend);
    isLoading.value = false;
    if (result['error'] == false) {
      if (resend == 'sms') {
        isLoading.value = true;
        await auth!.verifyPhoneNumber(
          phoneNumber: "+91" + this.userData['mobileNumber'],
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: (verificationId, resendToken) {
            isLoading.value = false;
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: _onCodeTimeout,
          timeout: const Duration(seconds: 60),
        );
      }
    }
    snackMessage(result['message']);
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
    // print("hello 2");
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  // _onCodeSent(String verificationId, int? forceResendingToken) async {
  //   print("hello 3");
  //   print(verificationId);
  //   print(forceResendingToken);
  //   print("code sent");
  // }

  _onCodeTimeout(String timeout) {
    // print("hello 4");
    print(timeout);
  }

  Future userCreatedSubmit() async {
    if (isLoading.value == true) return;
    isLoading.value = true;
    var result = await userRepo!.userCreatedSubmit(this.userData['tempId']);
    isLoading.value = false;
    snackMessage(result['message']);
    if (result['error'] == false) {
      _countController.getCartCount();
      musicController.startMusicByLogin();
      // _countController.getWishlistCount();
      // Get.offAllNamed('/home');
      loyalityController.getLoyalityDataAfterLogin();
      var token = await _notificationController.checkPermissionAndGetToken();
      await registrationRepo!.updateShopifyUserDeviceToken(null, token);
      navigateByArgument();
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
        await Get.offAllNamed(path ?? '/home');
      }
    } else {
      await Get.offAllNamed("/home");
    }
  }

  snackMessage(String message) {
    Get.snackbar(
      "", message,
      snackPosition: SnackPosition.BOTTOM,
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

  @override
  void onClose() {
    super.onClose();
  }
}
