import 'package:black_locust/controller/address_controller.dart';
import 'package:black_locust/controller/address_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class AddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<AddressController>(() => AddressController());
    Get.create<AddressV1Controller>(() => AddressV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
