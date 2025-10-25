import 'package:black_locust/controller/return_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ReturnBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ReturnController>(() => ReturnController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
