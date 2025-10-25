import 'package:black_locust/controller/order_history_controller.dart';
import 'package:black_locust/controller/order_history_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class OrderHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<OrderHistoryController>(() => OrderHistoryController());
    Get.create<OrderHistoryV1Controller>(() => OrderHistoryV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
