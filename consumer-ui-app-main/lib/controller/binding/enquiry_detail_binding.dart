import 'package:black_locust/controller/order_enquiry_details_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class EnquiryDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<EnquiryDetailController>(() => EnquiryDetailController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
