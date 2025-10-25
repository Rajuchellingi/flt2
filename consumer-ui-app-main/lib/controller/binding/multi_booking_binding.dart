import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:get/get.dart';

class MultiBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<MultiBookingController>(() => MultiBookingController());
  }
}
