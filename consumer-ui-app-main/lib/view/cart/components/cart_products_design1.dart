import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductsDesign1 extends StatelessWidget {
  CartProductsDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              design['source']['title'],
              textAlign: themeController.defaultStyle(
                  'textAlign', design['style']['textAlign']),
              style: TextStyle(
                  fontWeight: themeController.defaultStyle(
                      'fontWeight', design['style']['fontWeight'])),
            ),
          ),
          for (var i = 0; i < _controller.productCart.length; i++)
            CartProductItem(
              index: i,
              isCheckoutPage: false,
              controller: _controller,
            ),
        ]));
  }
}
