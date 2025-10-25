import 'package:black_locust/controller/booking_confirmation_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class BookingConfirmedBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<BookingConfirmationController>(
        () => BookingConfirmationController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
