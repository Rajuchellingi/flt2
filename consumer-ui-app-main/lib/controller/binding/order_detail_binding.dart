import 'package:black_locust/controller/order_detail_controller.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<OrderDetailController>(() => OrderDetailController());
    Get.create<OrderDetailV1Controller>(() => OrderDetailV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
