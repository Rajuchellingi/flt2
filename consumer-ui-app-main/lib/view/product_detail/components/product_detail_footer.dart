// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailFooter extends StatelessWidget {
  ProductDetailFooter({
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
        if (footer['componentId'] == 'add-to-cart-bar') ...[
          if (footer['instanceId'] == 'design1')
            ProductDetailFooterDesign1(controller: _controller)
          else if (footer['instanceId'] == 'design2')
            ProductDetailFooterDesign2(controller: _controller)
          else if (footer['instanceId'] == 'design3')
            ProductDetailFooterDesign3(controller: _controller)
          else if (footer['instanceId'] == 'design4')
            ProductDetailFooterDesign4(controller: _controller)
          else if (footer['instanceId'] == 'design5')
            ProductDetailFooterDesign5(controller: _controller, design: footer)
          else if (footer['instanceId'] == 'design6')
            ProductDetailFooterDesign6(controller: _controller)
        ] else if (footer['componentId'] == 'footer-navigation')
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
      ]);
    });
  }
}
