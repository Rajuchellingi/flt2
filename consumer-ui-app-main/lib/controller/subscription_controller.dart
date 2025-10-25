// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:async';

import 'package:b2b_graphql_package/modules/subscription/subscription_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/model/subscription.model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SubscriptionController extends GetxController {
  SubscriptionRepo? subscriptionRepo;
  UserRepo? userRepo;
  var isLoading = false.obs;
  var isAllowed = true.obs;
  var isOffline = false.obs;
  var isDataLoaded = false.obs;
  final commonController = Get.find<CommonController>();
  var subscriptionDetail = new SubscriptionModelVM(
          error: null,
          expiryDate: null,
          message: null,
          sId: null,
          sTypename: null,
          type: null)
      .obs;
  var shopDetail = new TokenConfigurationVM(
          accessToken: null,
          error: null,
          shop: null,
          name: null,
          storefrontAccessToken: null,
          message: null,
          sTypename: null)
      .obs;
  StreamSubscription? internetconnection;

  @override
  void onInit() {
    userRepo = new UserRepo();
    subscriptionRepo = SubscriptionRepo();
    listenSConnectivity();
    getSubscriptionDetail();
    checkUserValidity();
    super.onInit();
  }

  Future getSubscriptionDetail() async {
    if (platform == 'shopify') {
      isLoading.value = true;
      // var configuration = await subscriptionRepo!.getShopifyShopForUI();
      // if (configuration != null) {
      //   var configData = tokenConfigurationVMFromJson(configuration);
      //   if (configData.storefrontAccessToken != null) {
      //     GetStorage().write("accessToken", configData.storefrontAccessToken);
      //     GetStorage().write("shop", configData.shop);
      //   }
      // }

      var result = await subscriptionRepo!.getSubscriptionDetail();
      isLoading.value = false;
      if (result != null) {
        isDataLoaded.value = true;
        var response = subscriptionModelVMFromJson(result);
        isAllowed.value = response.error == true ? false : true;
        // var subscription = {
        //   "type": response.type,
        //   "expiryDate": response.expiryDate
        // };
        // if (response.error == false)
        //   GetStorage().write("subscription", subscription);
        subscriptionDetail.value = response;
      } else {
        isDataLoaded.value = false;
      }
    } else {
      isAllowed.value = true;
    }
  }

  Future getShopifyShopDetails() async {
    var configuration = await subscriptionRepo!.getShopifyShopForUI();
    if (configuration != null) {
      var configData = tokenConfigurationVMFromJson(configuration);
      shopDetail.value = configData;
      if (configData.storefrontAccessToken != null) {
        GetStorage().write("accessToken", configData.storefrontAccessToken);
        GetStorage().write("shop", configData.shop);
      }
      return configData.shop;
    } else {
      return '';
    }
  }

  checkSubscription() {
    // if (isLoading.value == false) {
    //   if (isDataLoaded.value == true) {
    //     var subscription = GetStorage().read("subscription");
    //     if (subscription != null) {
    //       if (subscription['type'] == 'one-time') {
    //         isAllowed.value = true;
    //       } else {
    //         DateTime date = DateTime.now();
    //         var currentTime = date.millisecondsSinceEpoch;
    //         if (subscription['expiryDate'] > currentTime) {
    //           isAllowed.value = true;
    //         } else {
    //           updateSubscriptionStatus();
    //           isAllowed.value = false;
    //         }
    //       }
    //     } else {
    //       isAllowed.value = false;
    //     }
    //   } else {
    getSubscriptionDetail();
    // }
    // }
  }

  Future checkUserValidity() async {
    if (platform == 'shopify') {
      var utoken = GetStorage().read("utoken");
      if (utoken != null) {
        var result = await userRepo!.getUserById(utoken, []);
        if (result == null) {
          await Future.delayed(Duration(milliseconds: 500));
          result = await userRepo!.getUserById(utoken, []);
        }
        print('result $result');
        if (result == null) {
          commonController.logOut(
              page: 'login',
              message: 'Your session has expired. Please log in again.');
        }
      }
    }
  }

  Future updateSubscriptionStatus() async {
    var result = await subscriptionRepo!
        .updateSubscriptionStatus(subscriptionDetail.value.sId);
  }

  checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      isOffline.value = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isOffline.value = false;
    } else if (connectivityResult == ConnectivityResult.none) {
      isOffline.value = true;
    }
  }

  listenSConnectivity() {
    checkConnectivity();
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> data) {
      var result = data.first;
      print('result $result');
      if (result == ConnectivityResult.none) {
        isOffline.value = true;
      } else if (result == ConnectivityResult.mobile) {
        // if (isOffline.value == true) reloadCurrentPage();
        isOffline.value = false;
      } else if (result == ConnectivityResult.wifi) {
        // if (isOffline.value == true) reloadCurrentPage();
        isOffline.value = false;
      }
    });
  }

  void reloadCurrentPage() {
    Get.back();
  }

  @override
  void onClose() {
    internetconnection!.cancel();
    super.onClose();
  }
}
