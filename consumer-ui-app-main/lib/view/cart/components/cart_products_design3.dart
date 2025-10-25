import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_product_item_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductsDesign3 extends StatelessWidget {
  CartProductsDesign3({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              design['source']['title'],
              textAlign: themeController.defaultStyle(
                  'textAlign', design['style']['textAlign']),
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontSize: themeController.defaultStyle(
                      'fontSize', design['style']['fontSize']),
                  fontWeight: themeController.defaultStyle(
                      'fontWeight', design['style']['fontWeight'])),
            ),
          ),
          for (var i = 0; i < _controller.productCart.length; i++)
            CartProductItemDesign3(
              index: i,
              isCheckoutPage: false,
              controller: _controller,
            ),
        ])));
  }
}
