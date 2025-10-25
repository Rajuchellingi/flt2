// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_v1/components/cart_products.dart';
import 'package:black_locust/view/cart_v1/components/cart_related_products_v1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartBlocksV1 extends StatelessWidget {
  CartBlocksV1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CartV1Controller _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return Container(
          color: kBackground,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
              child: Column(children: [
            for (var design in blocks) ...[
              if (design['componentId'] == 'cart-products' &&
                  design['visibility']['hide'] == false)
                CartProducts(
                  controller: _controller,
                  design: design,
                ),
              if (design['componentId'] == 'related-products' &&
                  design['visibility']['hide'] == false)
                CartRelatedProductsV1(controller: _controller),
            ],
            if (footer != null &&
                footer.isNotEmpty &&
                themeController.bottomBarType.value == 'design1' &&
                footer['componentId'] == 'footer-navigation')
              const SizedBox(height: 80),
          ])));
    });
  }
}
