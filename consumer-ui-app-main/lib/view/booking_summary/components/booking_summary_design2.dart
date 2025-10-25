// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_summary_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/booking_summary/components/booking_payment_summary_design2.dart';
import 'package:black_locust/view/booking_summary/components/booking_summary_product_details_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSummaryDesign2 extends StatelessWidget {
  BookingSummaryDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingSummaryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const SizedBox(height: 10),
                BookingSummaryProductDetailsDesign2(
                    products: _controller.checkoutData.value.products),
                const SizedBox(height: 15),
                BookingPaymentSummaryDesign2(
                    productCount:
                        _controller.checkoutData.value.products.length,
                    orderSummary: _controller.checkoutData.value.orderSummary!),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                      _controller.createBooking();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text('Submit Booking form',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold)))),
                const SizedBox(height: 15),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text('Cancel',
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)))),
              ])));
    });
  }
}
