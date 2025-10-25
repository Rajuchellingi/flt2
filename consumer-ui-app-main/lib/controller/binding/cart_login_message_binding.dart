import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class CartLoginMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CartLoginMessageController>(() => CartLoginMessageController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
