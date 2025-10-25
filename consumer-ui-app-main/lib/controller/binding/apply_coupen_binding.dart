import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ApplyCoupenBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ApplyCoupenController>(() => ApplyCoupenController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
