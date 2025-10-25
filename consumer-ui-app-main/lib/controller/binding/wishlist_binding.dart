import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/controller/wishlist_controller.dart';
import 'package:black_locust/controller/wishlist_v1_controller.dart';
import 'package:get/get.dart';

class WishlistBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<WishlistController>(() => WishlistController());
    Get.create<WishlistV1Controller>(() => WishlistV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
