// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_discount_progress_bar_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartDiscountProgressBar extends StatelessWidget {
  CartDiscountProgressBar({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        CartDiscountProgressBarDesign1(controller: _controller, design: design)
    ]);
  }
}
