// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member
import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:b2b_graphql_package/modules/login/login_repo.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/plugins_model.dart';
import 'package:black_locust/model/registration_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integration_package/modules/otp/otp_repo.dart';
// import 'package:get_storage/get_storage.dart';
import '../model/user_model.dart';
import 'base_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'notification_controller.dart';

class LogInController extends GetxController with BaseController {
  TextEditingController? phoneNumberController,
      countryCodeController,
      passwordController,
      otpController,
      emailController;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth? auth;
  UserRepo? userRepo;
  LoginRepo? loginRepo;
  OTPRepo? otpRepo;
  CartRepo? cartRepo;
  var isPasswordAvailable = false.obs;
  var initialLogin = true.obs;
  var isOtp = false.obs;
  var isLoading = false.obs;
  var updateFlags = [].obs;
  bool shouldReload = false;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final _notificationController = Get.find<NotificationController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  final pluginsController = Get.find<PluginsController>();
  var arguments;
  var isPrizma = true.obs;
  var otpId;
  var loginPlugin = new PluginsVM(
          name: '',
          sId: null,
          status: null,
          isReview: null,
          mobileNumber: null,
          title: null,
          code: null,
          secretKey: null,
          workspace: null)
      .obs;
  @override
  void onInit() {
    arguments = Get.arguments;
    auth = FirebaseAuth.instance;
    countryCodeController = TextEditingController(text: '+91 ');
    cartRepo = CartRepo();
    otpRepo = OTPRepo();
    loginRepo = LoginRepo();
    passwordController = TextEditingController(text: '');
    phoneNumberController = TextEditingController(text: '');
    otpController = TextEditingController();
    emailController = TextEditingController(); // Initialize emailController
    userRepo = new UserRepo();
    getTemplate();
    checkIsMobileLogin();
    super.onInit();
  }

  checkIsMobileLogin() {
    var plugin = pluginsController.getPluginValue('prizma-otp');
    if (plugin != null) {
      isPrizma.value = true;
      loginPlugin.value = plugin;
    } else {
      isPrizma.value = false;
    }
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'login');
    isTemplateLoading.value = false;
  }

  Future<void> loginWithEmail(context) async {
    try {
      showLoading('Loading..');
      var email = emailController!.text;
      var password = passwordController!.text;
      print('emailController $password');
      var result = await loginRepo!.logInWithEmailAndPassword(email, password);
      if (result != null && result['accessToken'] != null) {
        var response = LoginTokenVMJson(result);
        // isPasswordAvailable.value = response.email != "" ? true : false;
        initialLogin.value = !isPasswordAvailable.value;
        GetStorage().write("utoken", result['accessToken']);
        GetStorage().write("userExpiry", result['expiresAt']);
        var userId = GetStorage().read("utoken");
        var userExpiry = GetStorage().read("userExpiry");
        // print("email------------ $email");
        var input = {
          "buyerIdentity": {
            "email": email,
          }
        };
        var cartId = GetStorage().read("cartId");
        // print("getCartId ID: $getCartId");
        // var userProfile = await getProfile(userId);
        // print("userProfile: $userProfile");
        await FirebaseAnalytics.instance.logEvent(
          name: 'login_success',
          parameters: {'method': 'email'},
        );
        if (cartId == null) {
          var getCartId = await cartRepo!.createCart(input);
          GetStorage().write("cartId", getCartId['cart']['id']);
          GetStorage().write("cartExpiry", getCartId['cart']['updatedAt']);
        } else {
          await cartRepo!
              .cartBuyerIdentityUpdate(cartId, input['buyerIdentity']);
        }
        // print("cartId ID: $cartId");
        // print("cartExpiry Expiry: $cartExpiry");
        // hideLoading();
        if (userId != null) {
          var userProfile = await getProfile(userId);
          getWishlist();
          // Get.offAndToNamed("/home");
          // await Get.offAllNamed("/home");
          navigateByArgument();
          // }
        }
        hideLoading();
        // if (initialLogin.value = !isPasswordAvailable.value) {
        //   Get.toNamed("/home");
        //   shouldReload = true;
        //   // loginWithEmail();
        // }
        //   var getToken =
        //     await registerRepo!.logInWithEmailAndPassword(email, password);
        // if (getToken != null) {
        //   print("getToken $getToken");
        //   GetStorage().write("userId", getToken['accessToken']);
        //   GetStorage().write("userExpiry", getToken['expiresAt']);
        //   var userId = GetStorage().read("userId");
        //   var userExpiry = GetStorage().read("userExpiry");
        //   print("User ID: $userId");
        //   print("User Expiry: $userExpiry");
        // }
        // Handle the response as needed
      } else if (result != null && result['message'] != null) {
        hideLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        hideLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        // CommonHelper.showSnackBarAddToBag('Invalid email and password');
        // Navigator.pushNamed(context, '/register');
        // hideLoading();
        // CommonHelper.showSnackBarAddToBag('Invalid email and password');
        // onPressed() {
        //   Get.toNamed('/register');
        // }
      }
    } catch (e) {
      print('error $e');
      hideLoading();
    }
  }

  Future loginWithMobileNumber() async {
    if (isOtp.value == true)
      verifyMobileNumberOTP();
    else
      sendMobileNumberOTP();
  }

  Future verifyMobileNumberOTP() async {
    try {
      KeyboardUtil.hideKeyboard(Get.context!);
      showLoading('Loading..');
      var otp = otpController!.text;
      var resultData = await loginRepo!.verifyLoginOTP(otpId, otp);
      hideLoading();
      if (resultData != null) {
        print('resutlt $resultData');
        if (resultData['error'] == false) {
          emailController!.text = resultData['emailId'];
          passwordController!.text = resultData['loginData'];
          loginWithEmail(Get.context);
          showSnackbar("OTP verified successfully");
        } else {
          showSnackbar(resultData['message'] ?? "OTP Verification Failed");
        }
      } else {
        showSnackbar("OTP Verification Failed");
      }
    } catch (e) {
      print('error $e');
      hideLoading();
    }
  }

  Future sendMobileNumberOTP() async {
    try {
      showLoading('Loading..');
      var phoneNumber = phoneNumberController!.text;
      var mobileNumber = "+91${phoneNumber.trim()}";
      var resultData = await loginRepo!.sendOTPForLogin(mobileNumber);
      hideLoading();
      if (resultData != null) {
        if (resultData['error'] == false) {
          otpId = resultData['otpId'];
          showSnackbar("OTP sent successfully");
          isOtp.value = true;
        } else {
          showSnackbar(resultData['message'] ?? "OTP Not Sent");
        }
      } else {
        showSnackbar("Failed to generate OTP");
      }
    } catch (e) {
      print('error $e');
      showSnackbar(e.toString());
      hideLoading();
    }
  }

  // Future sendMobileNumberOTP() async {
  //   try {
  //     showLoading('Loading..');
  //     var catchaToken = loginPlugin.value.secretKey;
  //     var apiKey = loginPlugin.value.code;
  //     var phoneNumber = phoneNumberController!.text;
  //     // var token = await FirebaseAppCheck.instance.getToken(true);
  //     print('captcha token ${catchaToken}');
  //     RecaptchaClient client = await Recaptcha.fetchClient(
  //         "6LefuowrAAAAALiNkcJwzM-DqSGoM09Q-q5p4bvS");
  //     print('app token ----------> ${client}');

  //     String token = await client.execute(RecaptchaAction.LOGIN());

  //     print('app token ----------> ${token}');
  //     var params = {"captchaToken": token};
  //     var body = {"phoneNumber": "+91${phoneNumber.trim()}"};

  //     // User? user = FirebaseAuth.instance.currentUser;
  //     // print('userrrrr $user');

  //     var resultData = await otpRepo!.generatePrizmaOTP(params, body, apiKey);
  //     hideLoading();
  //     if (resultData != null) {
  //       otpId = resultData['id'];
  //       showSnackbar("OTP sent successfully");
  //       isOtp.value = true;
  //     } else {
  //       showSnackbar("Failed to generate OTP");
  //     }
  //   } catch (e) {
  //     print('error $e');
  //     showSnackbar(e.toString());
  //     hideLoading();
  //   }
  // }

  showSnackbar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  navigateByArgument() async {
    if (arguments != null) {
      var path = arguments['path'];
      var pathArgs = arguments['arguments'];
      if (pathArgs != null) {
        await Get.offAllNamed(path, arguments: pathArgs);
      } else {
        await Get.offAllNamed(path);
      }
    } else {
      await Get.offAllNamed("/home");
    }
  }

  getWishlist() {
    if (platform == 'shopify') {
      commonWishlistController.getAllWishilst();
    }
  }

  Future getProfile(String id) async {
    var result = await userRepo!.getUserById(id, []);
    if (result != null) {
      var userData = userDetailsVMFromJson(result);
      GetStorage().write("customerId", userData.sId);
      // print("getProfile userData ${userData.toJson()}");
      var newUser = await createShopifyUser(userData);
      return newUser;
    }
  }

  Future createShopifyUser(userData) async {
    var user = {"customerId": userData.sId};
    if (userData.emailId != null) user['emailId'] = userData.emailId;
    if (userData.firstName != null) user['firstName'] = userData.firstName;
    if (userData.lastName != null) user['lastName'] = userData.lastName;
    if (userData.mobileNumber != null)
      user['mobileNumber'] = userData.mobileNumber;
    var token = await _notificationController.checkPermissionAndGetToken();
    user['deviceToken'] = token;
    print('user  $user');
    var result = await loginRepo!.verifyAndRegisterUser(user);
    if (result != null) {
      var response = userRegisterVMFromJson(result);
      // if (response.userId != null) {
      //   var token = await _notificationController.checkPermissionAndGetToken();
      //   await registrationRepo!
      //       .updateShopifyUserDeviceToken(response.userId, token);
      // }
      return response;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
