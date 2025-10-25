import 'package:black_locust/controller/order_confirmation_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class OrderConfirmedBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<OrderConfirmationController>(
        () => OrderConfirmationController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
