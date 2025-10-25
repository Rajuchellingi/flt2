import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/controller/welcome_screen_controller.dart';
import 'package:get/get.dart';

class WelcomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<WelcomeScreenController>(() => WelcomeScreenController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
