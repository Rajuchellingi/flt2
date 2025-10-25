import 'package:black_locust/controller/html_web_view_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class HtmlWebViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<HtmlWebviewController>(() => HtmlWebviewController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
