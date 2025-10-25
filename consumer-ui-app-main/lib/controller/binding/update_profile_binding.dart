import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:get/get.dart';

class UpdateProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<UpdateProfileController>(() => UpdateProfileController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
