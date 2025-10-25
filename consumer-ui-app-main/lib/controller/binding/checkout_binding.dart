import 'package:black_locust/controller/checkout_controller.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CheckoutController>(() => CheckoutController());
    Get.create<CheckoutV1Controller>(() => CheckoutV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
