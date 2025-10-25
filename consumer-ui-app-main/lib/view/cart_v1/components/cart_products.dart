// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_v1/components/cart_products_design2.dart';
import 'package:black_locust/view/cart_v1/components/cart_products_design3.dart';
import 'package:black_locust/view/cart_v1/components/cart_products_v1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProducts extends StatelessWidget {
  CartProducts({
    Key? key,
    required this.design,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final design;
  final CartV1Controller _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (design['instanceId'] == 'design2')
        CartProductDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        CartProductsV2Design3(controller: _controller)
      else
        CartProductsV1(controller: _controller)
    ]);
  }
}
