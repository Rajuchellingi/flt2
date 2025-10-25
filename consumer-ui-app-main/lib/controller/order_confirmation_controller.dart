// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:b2b_graphql_package/modules/loyality/loyality_repo.dart';
import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/loyality.model.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:get/get.dart';

class OrderConfirmationController extends GetxController with BaseController {
  OrderRepo? orderRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var orderId;
  var orderToken;
  var isOrder = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final loyalityController = Get.find<LoyalityController>();
  CheckoutRepo? checkoutRepo;
  Timer? _timer;
  var duration = 60.obs;
  var isReload = false.obs;
  LoyalityRepo? loyalityRepo;
  var orderPoints = 0.obs;
  var loyalityOrder =
      new LoyaltyPointsRewardVM(points: 0, coinsToReward: 0).obs;
  @override
  void onInit() {
    orderRepo = OrderRepo();
    checkoutRepo = CheckoutRepo();
    loyalityRepo = LoyalityRepo();
    var arguments = Get.arguments;
    if (arguments != null) {
      orderId = arguments['id'];
      orderToken = arguments['token'];
      if (orderId != null) {
        getSingleOrder();
      } else if (orderToken != null) {
        orderId = arguments['orderId'];
        getShopifyOrder();
      }
    }
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'order-confirmed');
    isTemplateLoading.value = false;
  }

  Future getSingleOrder() async {
    isLoading.value = true;
    var result = await orderRepo!.getSingleOrderDetail(orderId);
    if (loyalityController.isLoyality.value) {
      var response = myOrderDetailVMFromJson(result);
      if (response.sId != null) isOrder.value = true;
      fetchLoyalityOrder();
    } else {
      isLoading.value = false;
      if (result != null) {
        var response = myOrderDetailVMFromJson(result);
        if (response.sId != null) isOrder.value = true;
      }
    }
  }

  void fetchLoyalityOrder() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => getLoyalityOrder());
  }

  void getLoyalityOrder() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await loyalityRepo!.getLoyalityOrder(
            loyalityController.userProfile.value.userTypeName, orderId);
        if (result != null) {
          loyalityOrder.value = loyalityOrderPointsVMFromJson(result);
          orderPoints.value =
              loyalityOrder.value.coinsToReward! + loyalityOrder.value.points!;
          loyalityController.getCurrentLoayalityData();
          _timer?.cancel();
          isLoading.value = false;
          isReload.value = false;
        } else {
          isReload.value = false;
        }
      }
    } else {
      isLoading.value = false;
      _timer?.cancel();
    }
  }

  Future getShopifyOrder() async {
    isLoading.value = true;
    var result = await checkoutRepo!.checkBookingIsConfirmed(orderToken);
    isLoading.value = false;
    if (result != null && result['error'] == false) {
      isOrder.value = true;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
