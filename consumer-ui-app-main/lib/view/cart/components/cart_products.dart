// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_products_design1.dart';
import 'package:black_locust/view/cart/components/cart_products_design2.dart';
import 'package:black_locust/view/cart/components/cart_products_design3.dart';
import 'package:black_locust/view/cart/components/cart_products_design4.dart';
import 'package:black_locust/view/cart/components/cart_products_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProducts extends StatelessWidget {
  CartProducts({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        CartProductsDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        CartProductsDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        CartProductsDesign3(controller: _controller, design: design)
      else if (design['instanceId'] == 'design4')
        CartProductsDesign4(controller: _controller, design: design)
      else if (design['instanceId'] == 'design5')
        CartProductsDesign5(controller: _controller, design: design)
    ]);
  }
}
