import 'package:black_locust/controller/loyality_coupon_wallet_controller.dart';
import 'package:get/get.dart';

import '../subscription_controller.dart';

class LoyalityCouponWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<LoyalityCouponWalletController>(
        () => LoyalityCouponWalletController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
