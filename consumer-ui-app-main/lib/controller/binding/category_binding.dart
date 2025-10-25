import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CategoryController>(() => CategoryController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
