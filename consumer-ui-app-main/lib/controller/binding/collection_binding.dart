import 'package:black_locust/controller/collection_controller.dart';
import 'package:black_locust/controller/collection_v1_controller.dart';
import 'package:black_locust/controller/collection_v2_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class CollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CollectionController>(() => CollectionController());
    Get.create<CollectionV1Controller>(() => CollectionV1Controller());
    Get.create<CollectionV1ControllerV2>(() => CollectionV1ControllerV2());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
