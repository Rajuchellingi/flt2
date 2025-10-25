// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_summary_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_payment_summary.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSummaryDesign1 extends StatelessWidget {
  BookingSummaryDesign1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingSummaryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    _controller.createBooking();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    side: const BorderSide(color: kPrimaryColor),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    'Book Now',
                    style: const TextStyle(color: kSecondaryColor),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                CheckoutV1PaymentSummary(
                    orderSummary: _controller.checkoutData.value.orderSummary!),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Divider()),
                CheckoutV1ProductDetails(
                    products: _controller.checkoutData.value.products),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    _controller.createBooking();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    side: const BorderSide(color: kPrimaryColor),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    'Book Now',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                if (footer != null &&
                    footer.isNotEmpty &&
                    themeController.bottomBarType.value == 'design1' &&
                    footer['componentId'] == 'footer-navigation')
                  const SizedBox(height: 80),
              ])));
    });
  }
}
