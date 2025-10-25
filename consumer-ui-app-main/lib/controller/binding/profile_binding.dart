import 'package:black_locust/controller/profile_controller.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ProfileController>(() => ProfileController());
    Get.create<ProfileV1Controller>(() => ProfileV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
