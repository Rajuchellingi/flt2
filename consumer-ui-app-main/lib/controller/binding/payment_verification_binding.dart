import 'package:black_locust/controller/payment_verification_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class PaymentVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<PaymentVerificationController>(
        () => PaymentVerificationController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
