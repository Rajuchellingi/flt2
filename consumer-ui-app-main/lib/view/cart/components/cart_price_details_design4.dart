// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPriceDetailsDesign4 extends StatelessWidget {
  CartPriceDetailsDesign4({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Obx(() =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (design['source']['title'] != null) ...[
                Text(
                  design['source']['title'],
                  style: headingStyle.copyWith(fontSize: 16),
                ),
                kDefaultHeight(kDefaultPadding)
              ],
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ),
                Text(
                  CommonHelper.currencySymbol() +
                      _controller
                          .totalCartPrice.value.summary!.totalSellingPrice!
                          .toString(),
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )
              ]),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Discount',
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ),
                Text(
                  CommonHelper.currencySymbol() +
                      (_controller.totalCartPrice.value.summary!
                                  .totalSellingPrice! -
                              _controller
                                  .totalCartPrice.value.summary!.totalMrpPrice!)
                          .toStringAsFixed(2),
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )
              ]),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ),
                Text(
                  "To be calculated at checkout",
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )
              ]),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Grand Total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ),
                Text(
                  CommonHelper.currencySymbol() +
                      _controller.totalCartPrice.value.summary!.totalMrpPrice!
                          .toString(),
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                )
              ])
            ])));
  }
}
