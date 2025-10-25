import 'package:black_locust/controller/order_enquiry_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class EnquiryHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<OrderEnquiryController>(() => OrderEnquiryController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
