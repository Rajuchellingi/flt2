import 'package:black_locust/controller/add_review_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class AddReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<AddReviewController>(() => AddReviewController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
