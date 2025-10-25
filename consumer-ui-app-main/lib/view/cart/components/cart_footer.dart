// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_footer_design1.dart';
import 'package:black_locust/view/cart/components/cart_footer_design2.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooter extends StatelessWidget {
  CartFooter({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      var bottomBarDesign = themeController.bottomBarType.value;

      return Column(mainAxisSize: MainAxisSize.min, children: [
        if (footer['componentId'] == 'cart-summary') ...[
          if (footer['instanceId'] == 'design1' &&
              _controller.productCart.value.length > 0)
            CartFooterDesign1(
                template: _controller.template.value, controller: _controller)
          else if (footer['instanceId'] == 'design2' &&
              _controller.productCart.value.length > 0)
            CartFooterDesign2(
                template: _controller.template.value, controller: _controller)
        ] else if (footer['componentId'] == 'footer-navigation') ...[
          if (bottomBarDesign == 'design1')
            FooterDesign1(template: _controller.template.value)
          else if (bottomBarDesign == 'design2')
            FooterDesign2(template: _controller.template.value)
          else if (bottomBarDesign == 'design3')
            FooterDesign3(template: _controller.template.value)
          else if (bottomBarDesign == 'design4')
            FooterDesign4(template: _controller.template.value)
          else if (bottomBarDesign == 'design5')
            FooterDesign5(template: _controller.template.value)
        ]
      ]);
    });
  }
}
