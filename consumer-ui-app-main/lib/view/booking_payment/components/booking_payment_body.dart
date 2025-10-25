// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/controller/booking_payment_controller.dart';
// import 'package:black_locust/view/booking_payment/components/b2b_booking_payment_option.dart';
import 'package:black_locust/view/booking_payment/components/b2b_booking_payment_product_details.dart';
import 'package:black_locust/view/booking_payment/components/booking_payment_address.dart';
import 'package:black_locust/view/booking_payment/components/booking_payment_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPaymentBody extends StatelessWidget {
  const BookingPaymentBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingPaymentController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              BookingPaymentSummary(
                  orderSummary: _controller.bookingDetail.value.price!),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Divider()),
              // BookingPaymentOption(controller: _controller),
              // Container(
              //     margin: const EdgeInsets.symmetric(vertical: 10),
              //     child: const Divider()),
              BookingPaymentAddress(
                  address: _controller.bookingDetail.value.shippingAddress!),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Divider()),
              BookingPaymentProductDetails(
                  products: _controller.bookingDetail.value.products),
              const SizedBox(height: 15),
            ]))));
  }
}
