import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingDetailController>(() => BookingDetailController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
