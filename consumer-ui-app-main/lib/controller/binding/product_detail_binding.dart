import 'package:black_locust/controller/product_detail_controller.dart';
import 'package:black_locust/controller/product_detail_v1_controller.dart';
import 'package:black_locust/controller/product_detail_v2_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ProductDetailController>(() => ProductDetailController());
    Get.create<ProductDetailV1Controller>(() => ProductDetailV1Controller());
    Get.create<ProductDetailV2Controller>(() => ProductDetailV2Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
