// ignore_for_file: invalid_use_of_protected_member, sdk_version_since, unnecessary_null_comparison

import 'dart:async';

import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailController extends GetxController with BaseController {
  BookingRepo? bookingRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var bookingId = '';
  var bookingDetail = new MyBookingDetailVM(
      sId: null,
      billingAddress: null,
      shippingAddress: null,
      user: null,
      price: null,
      status: null,
      bookingNo: null,
      paymentStatus: null,
      creationDate: null,
      products: []).obs;
  var pageLimit = 20;
  var pageIndex = 1;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  TextEditingController? reasonController;

  @override
  void onInit() {
    reasonController = TextEditingController(text: '');
    bookingRepo = BookingRepo();
    var arguments = Get.arguments;
    getTemplate();
    if (arguments != null) {
      bookingId = arguments['id'];
      getSingleBookingById();
    }
    super.onInit();
  }

  Future getSingleBookingById() async {
    isLoading.value = true;
    var result = await bookingRepo!.getSingleBookingDetail(bookingId);
    isLoading.value = false;
    if (result != null) {
      bookingDetail.value = myBookingDetailVMFromJson(result);
    }
  }

  makePayment() {
    Get.toNamed('/bookingPayment',
        preventDuplicates: false, arguments: {'id': bookingId});
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'booking-detail');
    isTemplateLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    // orderDetail.value = '';
    pageIndex = 1;
    await Future.wait([getSingleBookingById()]);
    if (bookingDetail != null) {
      // orderDetail.addAll(newData);
      bookingDetail.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future cancelBooking() async {
    showLoading("Loading...");
    var result =
        await bookingRepo!.cancelBooking(bookingId, reasonController!.text);
    if (result != null) {
      var message = result['message'];
      if (message != null) {
        getSingleBookingById();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    hideLoading();
  }

  @override
  void onClose() {
    isLoading.close();
    bookingDetail.close();
    template.close();
    isTemplateLoading.close();
    reasonController!.dispose();
    super.onClose();
  }
}
