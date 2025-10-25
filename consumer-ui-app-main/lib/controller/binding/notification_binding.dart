import 'package:black_locust/controller/notification_history_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<NotificationHistoryController>(
        () => NotificationHistoryController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
