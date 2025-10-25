// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPriceDetailsDesign1 extends StatelessWidget {
  CartPriceDetailsDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                design['source']['title'],
                style: headingStyle.copyWith(fontSize: 16),
              ),
              kDefaultHeight(kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal'),
                  Text(
                    CommonHelper.currencySymbol() +
                        _controller
                            .totalCartPrice.value.summary!.totalSellingPrice!
                            .toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              kDefaultHeight(kDefaultPadding / 2),
              Wrap(
                children: [
                  const Text(
                    'Taxes, discounts and shipping calculated at checkout',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 140, 140, 140),
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_controller.outOfStock.value)
                      _controller.navigateToCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _controller.outOfStock.value
                          ? Colors.grey
                          : kPrimaryColor),
                  child: const Text('CKECKOUT',
                      style: TextStyle(color: kSecondaryColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
