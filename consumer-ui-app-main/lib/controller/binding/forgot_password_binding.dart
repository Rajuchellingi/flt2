import 'package:black_locust/controller/forgot_password_v1_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<ForgotPasswordV1Controller>(() => ForgotPasswordV1Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
