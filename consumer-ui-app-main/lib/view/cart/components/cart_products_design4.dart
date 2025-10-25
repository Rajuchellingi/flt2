import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_product_item_design4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductsDesign4 extends StatelessWidget {
  CartProductsDesign4({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (var i = 0; i < _controller.productCart.length; i++)
                CartProductItemDesign4(
                  index: i,
                  isCheckoutPage: false,
                  controller: _controller,
                ),
            ]));
  }
}
