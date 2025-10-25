import 'package:black_locust/controller/policy_page_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class PagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<PolicyPageController>(() => PolicyPageController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
