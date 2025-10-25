import 'package:black_locust/controller/booking_summary_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingSummaryController>(() => BookingSummaryController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
