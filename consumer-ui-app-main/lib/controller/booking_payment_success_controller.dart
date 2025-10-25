// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';

class BookingPaymentSuccessController extends GetxController
    with BaseController {
  BookingRepo? bookingRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var bookingId = '';
  var isBooked = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    bookingRepo = BookingRepo();
    var arguments = Get.arguments;
    getTemplate();
    if (arguments != null) {
      bookingId = arguments['id'];
      getSingleBookingById();
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'payment-confirmed');
    isTemplateLoading.value = false;
  }

  Future getSingleBookingById() async {
    isLoading.value = true;
    var result = await bookingRepo!.getSingleBookingById(bookingId);
    isLoading.value = false;
    if (result['error'] == false) isBooked.value = true;
  }

  @override
  void onClose() {
    isLoading.close();
    isBooked.close();
    template.close();
    isTemplateLoading.close();
    super.onClose();
  }
}
