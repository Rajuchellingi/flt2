import 'package:black_locust/controller/subscription_controller.dart';
import 'package:black_locust/controller/wishlist_collection_controller.dart';
import 'package:get/get.dart';

class WishlistCollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<WishlistCollectionController>(
        () => WishlistCollectionController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
