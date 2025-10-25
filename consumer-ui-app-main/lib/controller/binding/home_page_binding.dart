import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<HomeController>(() => HomeController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
