import 'package:black_locust/controller/booking_payment_success_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingPaymentSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingPaymentSuccessController>(
        () => BookingPaymentSuccessController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
