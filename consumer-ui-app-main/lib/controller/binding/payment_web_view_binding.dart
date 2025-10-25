import 'package:black_locust/controller/payment_web_view_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class PaymentWebViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<PaymentWebViewController>(() => PaymentWebViewController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
