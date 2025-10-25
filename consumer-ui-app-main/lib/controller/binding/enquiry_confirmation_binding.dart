import 'package:black_locust/controller/enquiry_confirmation_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class EnquiryConfirmationBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<EnquiryConfirmationController>(
        () => EnquiryConfirmationController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
