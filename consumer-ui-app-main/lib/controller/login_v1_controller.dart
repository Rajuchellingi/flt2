//
//import 'package:flutter/material.dart';

// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:b2b_graphql_package/modules/registration/registration_repo.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/site_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/dailog_helper.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/model/registration_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../const/size_config.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class LoginV1Controller extends GetxController with BaseController {
  TextEditingController? userIdController, passwordController, otpController;
  LoginRepo? loginRepo;
  RegistrationRepo? registrationRepo;
  FirebaseAuth? auth;
  var initialLogin = true.obs;
  var isVisible = false.obs;
  var userDetails;
  var loginSetting =
      new LoginSettingVM(loginAuthentication: null, logoName: null).obs;
  var userDetailsResponse = {}.obs;
  final storage = GetStorage();
  var isLoading = false.obs;
  var verificationId;
  final _countController = Get.find<CartCountController>();
  final loyalityController = Get.find<LoyalityController>();
  final musicController = Get.find<MusicController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final siteSettingController = Get.find<SiteSettingController>();
  var useOtp = false.obs;
  // final otpController = TextEditingController();
  final _notificationController = Get.find<NotificationController>();

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    passwordController = TextEditingController(text: '');
    userIdController = TextEditingController(text: '');
    otpController = TextEditingController();
    loginRepo = LoginRepo();
    registrationRepo = RegistrationRepo();
    getLoginSetting();
    getTemplate();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getLoginSetting() async {
    isLoading.value = true;
    var result = await loginRepo!.getLoginSettingForUI();
    isLoading.value = false;
    if (result != null) {
      loginSetting.value = loginSettingVMFromJson(result);
    }
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'login');
    isTemplateLoading.value = false;
  }

  changePasswordVisible() {
    isVisible.value = !isVisible.value;
  }

  // editLoginId() {
  //   initialLogin.value = true;
  // }

  bool validateInput() {
    var userId = userIdController!.text;
    bool isNumber = num.tryParse(userId) != null;
    if (isNumber) {
      if (isValidMobile(userId)) {
        return true;
      } else {
        showSnackBar("Invalid Mobile Number", SnackPosition.BOTTOM);
        return false;
      }
    } else {
      if (isValidEmail(userId)) {
        return true;
      } else {
        showSnackBar("Invalid Email Id", SnackPosition.BOTTOM);
        return false;
      }
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool isValidMobile(String number) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(number);
  }

  Future accountLogin(type) async {
    if (isLoading.value == true || !validateInput()) return;
    var input = getLoginInput();
    print("hloooooooooooooo login");
    print("accountLogin input-------->>>>> ${input}");
    print("accountLogin type------------->>>>> ${type}");
    print("hlooooooooooo login");

    if (input['emailId'] != null && input['emailId'].isNotEmpty) {
      input = {
        'emailId': input['emailId'],
      };
    } else if (input['mobileNumber'] != null &&
        input['mobileNumber'].isNotEmpty) {
      input = {
        'mobileNumber': input['mobileNumber'],
      };
    }
    isLoading.value = true;
    var result = await loginRepo!.accountLogin(input);
    isLoading.value = false;
    if (result != null) {
      userDetails = result;
      userDetailsResponse.value = result;
      storage.write('userLoginData', result);
      if (result['error'] == true) {
        if (result['isExpired'] == true) {
          KeyboardUtil.hideKeyboard(Get.context!);
          if (type == "login") {
            loginRenewal(input);
          } else if (type == "ticketLogin") {
            print("hlooooooooooo ticketLogin");
            loginRenewalV2(input);
          }
        } else {
          if (input['emailId'] != null && input['emailId'].isNotEmpty) {
            showSnackBar("The email ID you entered is not registered.",
                SnackPosition.BOTTOM);
          } else if (input['mobileNumber'] != null &&
              input['mobileNumber'].isNotEmpty) {
            showSnackBar("The mobile number you entered is not registered.",
                SnackPosition.BOTTOM);
          }
        }
      }
      if (result['error'] == false) {
        initialLogin.value = false;
        if (result['authenticate'] == 'otp' &&
            input['mobileNumber'] != null &&
            input['mobileNumber'].isNotEmpty)
          phoneSignIn(input['mobileNumber']);
      }
      //  else if (result['error'] == false && result!['verify'] == true) {
      //   showSnackBar(result?['message'], SnackPosition.BOTTOM);
      //   Get.toNamed('/home', preventDuplicates: false);
      // }
    }
  }

  void ticketRaise(type) {
    if (type == "ticketRaise") {
      print("hlooooooooooo ticketRaise");
      var input = getLoginInput();
      loginRenewalForm(input);
    }
  }

  Future loginRenewal(input) async {
    DailogHelper.showInfoDailog(
        title: "Account Expired",
        showClose: true,
        btnText: "Request Account Renewal",
        description:
            "⚠️ Your account has expired. Please request renewal to regain access.",
        onPressed: () async {
          Get.back();
          showLoading("Loading...");
          var result = await loginRepo!.requestLoginRenewal(input);
          hideLoading();
          if (result != null) {
            showSnackBar(result['message'], SnackPosition.BOTTOM);
          }
        });
  }

  Future loginRenewalV2(input) async {
    print("inputs------------------>>> ${input}");
    DailogHelper.showInfoDailog(
        title: "Account Expired",
        showClose: true,
        btnText: "Request Account Renewal",
        description:
            "⚠️ Your account has expired. Please request renewal to regain access.",
        onPressed: () async {
          Get.back();
          loginRenewalForm(input);
        });
  }

  Future loginRenewalForm(input) async {
    final _formKey = GlobalKey<FormState>();
    var validationMsg;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey, // ✅ Wrap inside Form
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Request Password Renewal",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your registered mobile number to receive a renewal request.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 20),

                    /// ✅ TextFormField with proper validator
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: userIdController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email Id / Mobile Number',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      validator: (value) {
                        validationMsg = ValidationHelper.validate(
                          InputType.text,
                          value,
                          errorMsg: "Email Id / Mobile Number is required",
                        );
                        return validationMsg != '' ? validationMsg : null;
                      },
                    ),
                    const SizedBox(height: 20),

                    /// ✅ Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Get.back();
                          showLoading("Loading...");
                          var result =
                              await loginRepo!.requestLoginRenewal(input);
                          hideLoading();

                          if (result != null) {
                            showSnackBar(
                              result['message'],
                              SnackPosition.BOTTOM,
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Send Request →",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Info Message
                    Row(
                      children: [
                        const Icon(Icons.info, size: 16, color: Colors.grey),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "You’ll receive a message if the number is linked with your account.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  getLoginInput() {
    var input = {};
    input['password'] = passwordController!.text;
    input['type'] = 1;
    input['otp'] = otpController!.text;
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
    showSnackBar("OTP Sent Successfully", SnackPosition.BOTTOM);
  }

  _onCodeTimeout(String timeout) {
    print(timeout);
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar(
      "", msg,
      snackPosition: position,
      backgroundColor: Colors.black,
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

  Future verifyOtpOrPassword() async {
    if (isLoading.value == true) return;
    var input = getLoginInput();
    var userid = storage.read('userLoginData');
    var data;

    if (userid['authenticate'] == 'otp' &&
        input['mobileNumber'] != null &&
        input['mobileNumber'].isNotEmpty) {
      data = {
        "otp": '',
        "password": '',
        "smsOtp": input['otp'],
        "smsVerified": true,
        "tempId": userid['tempId'],
        "userId": ""
      };
    } else if (userid['authenticate'] == 'otp' &&
        input['emailId'] != null &&
        input['emailId'].isNotEmpty) {
      data = {
        "otp": input['otp'],
        "password": '',
        "smsOtp": "",
        "smsVerified": false,
        "tempId": userid['tempId'],
        "userId": ""
      };
    } else if (userid['authenticate'] == 'password') {
      data = {
        "otp": "",
        "password": input['password'],
        "smsOtp": "",
        "smsVerified": false,
        "tempId": userid['tempId'],
        "userId": ""
      };
    } else if (userid['authenticate'] == 'password-or-otp') {
      data = {
        "otp": input['otp'].isNotEmpty ? input['otp'] : "",
        "password": input['password'].isNotEmpty ? input['password'] : "",
        "smsOtp": "",
        "smsVerified": false,
        "tempId": userid['tempId'],
        "userId": ""
      };
    } else if (userid['authenticate'] == 'password-and-otp') {
      data = {
        "otp": "",
        "password": input['password'],
        "smsOtp": "",
        "smsVerified": false,
        "tempId": userid['tempId'],
        "userId": ""
      };
    }

    if (input['mobileNumber'] != null && userid['authenticate'] == 'otp') {
      verifySMSOTP(input['otp'], data);
    } else {
      isLoading.value = true;
      var result = await loginRepo!.accountLoginWithPassword(data);
      // print("result --->>> ${result}");
      if (result['error'] == true) {
        showSnackBar(result?['message'], SnackPosition.BOTTOM);
        isLoading.value = false;
      } else if (result['error'] == false) {
        showSnackBar('Login successful', SnackPosition.BOTTOM);
        _countController.getCartCount();
        musicController.startMusicByLogin();
        loyalityController.getLoyalityDataAfterLogin();
        var token = await _notificationController.checkPermissionAndGetToken();
        await registrationRepo!.updateShopifyUserDeviceToken(null, token);
        isLoading.value = false;
        // _countController.getWishlistCount();
        // Get.offAllNamed('/home');
        triggerLoginAction(input);
        navigateByArgument();
        refresh();
      }
    }
  }

  triggerLoginAction(input) {
    dynamic google = {
      "name": "signin",
      "data": {"ecommerce": {}}
    };
    if (input['mobileNumber'] != null && input['mobileNumber'].isNotEmpty) {
      google['data']['ecommerce']['phone'] = input['mobileNumber'];
    }
    if (input['emailId'] != null && input['emailId'].isNotEmpty) {
      google['data']['ecommerce']['email'] = input['emailId'];
    }
    var data = {"google": google};
    siteSettingController.trackActions(data);
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

  Future verifySMSOTP(otp, input) async {
    try {
      isLoading.value = true;
      var credential = await auth!.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      if (credential.user != null) {
        var result = await loginRepo!.accountLoginWithPassword(input);
        if (result['error'] == true) {
          isLoading.value = false;
          showSnackBar(result?['message'], SnackPosition.BOTTOM);
        } else if (result['error'] == false) {
          showSnackBar("Login successfully!!!", SnackPosition.BOTTOM);
          _countController.getCartCount();
          musicController.startMusicByLogin();
          loyalityController.getLoyalityDataAfterLogin();
          var token =
              await _notificationController.checkPermissionAndGetToken();
          await registrationRepo!.updateShopifyUserDeviceToken(null, token);
          isLoading.value = false;
          // _countController.getWishlistCount();
          triggerLoginAction(input);
          navigateByArgument();
          // Get.offAllNamed('/home');
          refresh();
        }
      }
    } catch (error) {
      hideLoading();
      showSnackBar("Incorrect OTP", SnackPosition.BOTTOM);
      // print('errrror $error');
    }
  }

  Future verifyEmailOtp() async {
    showLoading("Loading....");
    var preference = 1;
    var verified = 1;
    var tableType = 1;
    // var result = await loginRepo!.updateEmailOtpDetails(userIdController!.text,
    //     preference, verified, otpController!.text, tableType);
    // hideLoading();
    // if (result != null) {
    //   if (result.error) {
    //     showSnackBar(result.message, SnackPosition.BOTTOM);
    //   } else {
    //     showSnackBar('Login Successfully!!!', SnackPosition.BOTTOM);
    //     Get.toNamed('/home', preventDuplicates: false);
    //   }
    // }
  }

  Future verifyResendOTP() async {
    // Retrieve user login data from local storage
    var userid = storage.read('userLoginData');

    // Get the login input data
    var input = getLoginInput();

    // Initialize the data variable
    var data;

    // Check if emailId is not null and construct the data accordingly
    if (input['emailId'] != null && input['emailId'].isNotEmpty) {
      data = {
        "resend": "email",
        "tempId": userid['tempId'],
      };
    }
    // Check if mobileNumber is not null and construct the data accordingly
    else if (input['mobileNumber'] != null &&
        input['mobileNumber'].isNotEmpty) {
      data = {
        "resend": "sms",
        "tempId": userid['tempId'],
      };
    }

    // Send the OTP resend request
    isLoading.value = true;
    var result = await loginRepo!.resendOtp(data);
    isLoading.value = false;

    // Check the result and show appropriate snack bar messages
    if (result['error'] == true) {
      showSnackBar(result['message'], SnackPosition.BOTTOM);
    } else if (result['error'] == false) {
      if (input['mobileNumber'] != null && input['mobileNumber'].isNotEmpty)
        phoneSignIn(input['mobileNumber']);
      showSnackBar(result['message'], SnackPosition.BOTTOM);
      // Get.toNamed('/profile', preventDuplicates: false);
    }
  }

  Future verifySmsOtp() async {}

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
