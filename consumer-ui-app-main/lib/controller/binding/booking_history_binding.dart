import 'package:black_locust/controller/booking_history_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingHistoryController>(() => BookingHistoryController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
