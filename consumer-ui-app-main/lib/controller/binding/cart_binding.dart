import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CartController>(() => CartController());
    Get.create<CartV1Controller>(() => CartV1Controller());
    Get.create<ApplyCoupenController>(() => ApplyCoupenController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
