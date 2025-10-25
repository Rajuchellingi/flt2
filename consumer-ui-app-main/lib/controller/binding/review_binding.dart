import 'package:black_locust/controller/review_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ReviewController>(() => ReviewController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
