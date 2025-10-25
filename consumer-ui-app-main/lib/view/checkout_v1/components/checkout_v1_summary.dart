// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/controller/order_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_payment_summary.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_product_details.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_summary_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1Summary extends StatelessWidget {
  CheckoutV1Summary({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CheckoutV1Controller _controller;
  final themeController = Get.find<ThemeController>();
  final orderSettingController = Get.find<OrderSettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            if (orderSettingController.orderSetting.value.orderType ==
                'order') {
              _controller.placeOrder();
            } else {
              _controller.createBooking();
            }
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            side: const BorderSide(color: kPrimaryColor),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            orderSettingController.orderSetting.value.orderType == 'order'
                ? 'Place Order'
                : 'Book Now',
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
        // if (orderSettingController.orderSetting.value.orderType == 'order') ...[
        //   CheckoutV1PaymentOption(controller: _controller),
        //   Container(
        //       margin: const EdgeInsets.symmetric(vertical: 10),
        //       child: const Divider()),
        // ],
        CheckoutV1SummaryAddress(address: _controller.selectedAddress.value),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Divider()),
        CheckoutV1ProductDetails(
            products: _controller.checkoutData.value.products),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: () {
            if (orderSettingController.orderSetting.value.orderType ==
                'order') {
              _controller.placeOrder();
            } else {
              _controller.createBooking();
            }
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            side: const BorderSide(color: kPrimaryColor),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            orderSettingController.orderSetting.value.orderType == 'order'
                ? 'Place Order'
                : 'Book Now',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        if (footer != null &&
            footer.isNotEmpty &&
            themeController.bottomBarType.value == 'design1' &&
            footer['componentId'] == 'footer-navigation')
          const SizedBox(height: 80),
      ]));
    });
  }
}
