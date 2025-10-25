import 'package:black_locust/controller/booking_payment_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingPaymentController>(() => BookingPaymentController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
