// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingPaymentController extends GetxController with BaseController {
  BookingRepo? bookingRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var isReload = false.obs;
  var bookingId = '';
  var paymentMode = 'online'.obs;
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
  Timer? _timer;
  var duration = 60.obs;
  late Razorpay _razorpay;
  var initiatePaymentData = new BookingPaymentVM(
    key: null,
    paymentId: null,
    userId: null,
    link: null,
    type: null,
    tempTransactionId: null,
    signature: null,
    payload: null,
    error: null,
    storeUrl: null,
    environment: null,
    message: null,
  ).obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  TriggerRepo? triggerRepo;

  @override
  void onInit() {
    triggerRepo = TriggerRepo();
    bookingRepo = BookingRepo();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    var arguments = Get.arguments;
    if (arguments != null) {
      bookingId = arguments['id'];
      getSingleBookingById();
    }
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'checkout');
    isTemplateLoading.value = false;
  }

  Future getSingleBookingById() async {
    isLoading.value = true;
    var result = await bookingRepo!.getSingleBookingDetail(bookingId);
    isLoading.value = false;
    if (result != null) {
      bookingDetail.value = myBookingDetailVMFromJson(result);
    }
  }

  changePaymentMode(mode) {
    paymentMode.value = mode;
  }

  placeOrder() {
    if (paymentMode.value == 'online')
      initiatePayment();
    else if (paymentMode.value == 'cash-on-delivery') createCODOrder();
  }

  Future createCODOrder() async {
    showLoading("Loading...");
    var result = await bookingRepo!.createCODOrderByBooking(bookingId);
    hideLoading();
    if (result != null) {
      if (result['error'] == false) {
        await triggerRepo!.cancelTriggerNotification('abandoned-cart');

        Get.offAndToNamed('/orderConfirmation',
            arguments: {'id': result['orderId']});
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future initiatePayment() async {
    showLoading("Loading...");
    var result = await bookingRepo!.intiatePaymentByBooking(bookingId);
    hideLoading();
    if (result != null) {
      var response = bookingPaymentVMFromJson(result);
      initiatePaymentData.value = response;
      if (response.error == false) {
        if (response.type == 'razorpay')
          openPaymentGateway(response);
        else if (response.type == 'phonepe')
          Get.toNamed('/paymentWebView', arguments: {
            "url": response.link,
            "type": "booking",
            "bookingId": bookingId
          });
        else if (response.type == 'hdfc')
          Get.toNamed('/paymentWebView', arguments: {
            "url": response.link,
            "type": "booking",
            "bookingId": bookingId
          });
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(response.message.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void openPaymentGateway(response) async {
    var prefill = {};
    prefill['email'] = bookingDetail.value.billingAddress!.emailId;
    prefill['contact'] = bookingDetail.value.billingAddress!.mobileNumber;

    var options = {
      "key": response.key,
      'order_id': response.paymentId,
      "amount": "50000",
      "currency": "INR",
      "name": "To Automation",
      "description": "Transaction",
      "prefill": prefill,
      "notes": {"address": "Razorpay Corporate Office"},
      "theme": {"color": "#3399cc"}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    createOrder();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // updatePaymentByResponse();
  }

  Future createOrder() async {
    showLoading("Loading...");
    var result = await bookingRepo!.checkPaymentAndCreateOrder(
        initiatePaymentData.value.tempTransactionId);
    if (result['error'] == false) {
      fetchOrderStatus();
    } else {
      hideLoading();
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
        var result = await bookingRepo!.checkTransactionIsCompleted(
            initiatePaymentData.value.tempTransactionId);
        // var result = await bookingRepo!
        //     .checkOrderIsConfirmed(initiatePaymentData.value.tempTransactionId);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
            Get.offAndToNamed('/paymentSuccess', arguments: {"id": bookingId});
            isReload.value = false;
          } else {
            isReload.value = false;
          }
        }
      }
    } else {
      hideLoading();
      _timer?.cancel();
    }
  }

  @override
  void onClose() {
    _razorpay.clear();
    isLoading.close();
    paymentMode.close();
    isReload.close();
    bookingDetail.close();
    template.close();
    isTemplateLoading.close();
    initiatePaymentData.close();
    _timer?.cancel();
    duration.close();
    super.onClose();
  }
}
