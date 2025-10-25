// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison
import 'dart:async';

import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';
import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentVerificationController extends GetxController with BaseController {
  var isLoading = false.obs;
  var tempTransactionId;
  var bookingId;
  final themeController = Get.find<ThemeController>();
  CheckoutRepo? checkoutRepo;
  TriggerRepo? triggerRepo;
  BookingRepo? bookingRepo;
  Timer? _timer;
  var duration = 60.obs;
  var isReload = false.obs;

  @override
  void onInit() {
    bookingRepo = BookingRepo();
    checkoutRepo = CheckoutRepo();
    triggerRepo = TriggerRepo();
    var args = Get.arguments;
    tempTransactionId = args['transactionId'];
    bookingId = args['bookingId'];
    if (tempTransactionId != null) {
      if (args['type'] == 'order')
        fetchPaymentStatus();
      else if (args['type'] == 'booking') fetchBookingPaymentStatus();
    }
    super.onInit();
  }

  void fetchPaymentStatus() async {
    var result =
        await checkoutRepo!.checkPaymentAndCreateOrder(tempTransactionId);
    if (result['error'] == false) {
      duration.value = 60;
      _timer = Timer.periodic(
          Duration(seconds: 1), (Timer t) => checkPaymentIsCompleted());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void checkPaymentIsCompleted() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result =
            await bookingRepo!.checkOrderIsConfirmed(tempTransactionId);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
            Get.offAndToNamed('/orderConfirmation',
                arguments: {"id": result['orderId']});
            isReload.value = false;
          } else {
            isReload.value = false;
          }
        }
      }
    } else {
      _timer?.cancel();
    }
  }

  Future fetchBookingPaymentStatus() async {
    var result =
        await bookingRepo!.checkPaymentAndCreateOrder(tempTransactionId);
    if (result['error'] == false) {
      fetchOrderStatus();
    }
  }

  void fetchOrderStatus() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => reloadOrderStatus());
  }

  void reloadOrderStatus() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result =
            await bookingRepo!.checkTransactionIsCompleted(tempTransactionId);
        // var result = await bookingRepo!
        //     .checkOrderIsConfirmed(initiatePaymentData.value.tempTransactionId);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
            Get.offAndToNamed('/paymentSuccess', arguments: {"id": bookingId});
            isReload.value = false;
          } else {
            isReload.value = false;
          }
        }
      }
    } else {
      _timer?.cancel();
    }
  }
}
