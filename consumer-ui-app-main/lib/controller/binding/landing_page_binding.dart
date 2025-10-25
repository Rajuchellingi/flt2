import 'package:black_locust/controller/landing_page_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class LandingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<LandingPageController>(() => LandingPageController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
