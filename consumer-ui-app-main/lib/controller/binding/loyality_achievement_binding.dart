import 'package:black_locust/controller/loyality_achievement_controller.dart';
import 'package:get/get.dart';

import '../subscription_controller.dart';

class LoyalityAchievementBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<LoyalityAchievementController>(
        () => LoyalityAchievementController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
