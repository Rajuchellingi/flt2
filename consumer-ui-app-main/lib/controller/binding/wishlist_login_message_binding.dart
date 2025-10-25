import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/controller/wishlist_login_message_controller.dart';
import 'package:get/get.dart';

class WishlistLoginMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<WishlistLoginMessageController>(
        () => WishlistLoginMessageController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
