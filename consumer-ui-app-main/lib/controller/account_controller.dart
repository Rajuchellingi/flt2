// ignore_for_file: invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/order_list_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController with BaseController {
  UserRepo? userRepo;
  OrderRepo? orderRepo;
  var userId;
  var isLoading = false.obs;
  var cartBagCount = 0.obs;
  var isLoggedIn = false.obs;
  var pageIndex = 0.obs;
  var recentOrder = new RecentOrderAndBookingVM(order: null, booking: null).obs;
  var phoneNumber;
  var nectarMenus = ['reward-button', 'referral-button', 'review-button'];
  var userProfile = new UserDetailsVM(
    sId: "",
    altIsdCode: 0,
    altMobileNumber: "",
    companyName: "",
    userTypeName: "",
    contactName: "",
    numberOfAddresses: 0,
    numberOfOrders: 0,
    emailId: "",
    firstName: "",
    gstNumber: "",
    metafields: null,
    isdCode: 0,
    lastName: "",
    mobileNumber: "",
  ).obs;
  final pluginController = Get.find<PluginsController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var isRewards = false.obs;
  final commonController = Get.find<CommonController>();

  @override
  void onInit() {
    userId = GetStorage().read('utoken');
    userRepo = new UserRepo();
    orderRepo = new OrderRepo();
    getTemplate();
    checkIsReward();
    if (userId != null) {
      getProfile(userId);
    }
    super.onInit();
  }

  checkIsReward() {
    var referralPlugin = pluginController.getPluginValue('nectar');
    if (referralPlugin != null) {
      isRewards.value = true;
    }
  }

  void onTabTapped(int index) {
    this.pageIndex.value = index;
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-account');
    isTemplateLoading.value = false;
  }

  Future getRecentOrder() async {
    var result = await orderRepo!.getRecentOrderAndBooking();
    if (result != null) {
      recentOrder.value = recentOrderAndBookingVMFromJson(result);
    }
  }

  Future logOut() async {
    commonController.logOut();
    // GetStorage().remove('utoken');
    // GetStorage().remove('customerId');
    // GetStorage().remove('wishlist');
    // CommonHelper.showSnackBarAddToBag("Logged out successfully. ");
    // _countController.onLogout();
    // _notificationController.onLogout();
    // commonWishlistController.clearAllWishlist();
    // Get.offAndToNamed('/home');
  }

  Future getProfile(String id) async {
    this.isLoading.value = true;
    var result = await userRepo!.getUserById(id, []);
    if (platform == 'to-automation') await getRecentOrder();
    if (result != null) {
      userProfile.value = userDetailsVMFromJson(result);
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

  Future openReferralPage() async {
    var customerId = getCustomerId();
    var referralPlugin = pluginController.getPluginValue('nectar');
    String htmlString = """
      <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nector Rewards</title>
          </head>
          <body>
            <script async src="https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js" data-op="referral"
              data-api_key=${referralPlugin.code}
              data-platform="shopify" data-customer_id=$customerId></script>
          </body>
        </html>
      """;
    await Get.toNamed('/webView', arguments: {'htmlData': htmlString});
  }

  Future openReviewPage() async {
    // var customerId = "8069234720921";
    var customerId = getCustomerId();
    var referralPlugin = pluginController.getPluginValue('nectar');
    String htmlString = """
      <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nector Rewards</title>
          </head>
          <body>
            <script async src="https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js"
              data-op="review_list" data-default_reviews_sort="image_count" data-view_type="image_optimized_grid"
              data-limit='20' data-api_key=${referralPlugin.code}
              data-platform="shopify" data-customer_id=$customerId></script>
          </body>
        </html>
      """;
    await Get.toNamed('/webView', arguments: {'htmlData': htmlString});
  }

  Future openRewardPage() async {
    // var customerId = "8069234720921";
    var customerId = getCustomerId();
    var referralPlugin = pluginController.getPluginValue('nectar');
    String htmlString = """
      <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nector Rewards</title>
          </head>
          <body>
            <script async src="https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js"
            	data-op="reward"
            	data-api_key=${referralPlugin.code}
            	data-customer_id=$customerId
            	data-platform="shopify"
            ></script>
          </body>
        </html>
      """;
    await Get.toNamed('/webView', arguments: {'htmlData': htmlString});
  }

  getCustomerId() {
    var customerId = GetStorage().read('customerId');
    if (customerId != null) {
      var splittedData = customerId.split('/');
      return splittedData.last;
    } else {
      return null;
    }
  }

  @override
  void onClose() {
    isLoading.close();
    cartBagCount.close();
    isLoggedIn.close();
    pageIndex.close();
    userProfile.close();
    template.close();
    isTemplateLoading.close();
    isRewards.close();
    super.onClose();
  }
}
