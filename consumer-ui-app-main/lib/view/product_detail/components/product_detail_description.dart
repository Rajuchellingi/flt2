// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_description_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailDescription extends StatelessWidget {
  ProductDetailDescription(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductDetailDescriptionDesign1(
            product: _controller.product.value, designBlock: design)
      else if (design['instanceId'] == 'design2')
        ProductDetailDescriptionDesign2(controller: _controller)
      else if (design['instanceId'] == 'design3')
        ProductDetailDescriptionDesign3(
            product: _controller.product.value, designBlock: design)
      else if (design['instanceId'] == 'design4')
        ProductDetailDescriptionDesign4(
            product: _controller.product.value, designBlock: design)
      else if (design['instanceId'] == 'design5')
        ProductDetailDescriptionDesign5(
            product: _controller.product.value, designBlock: design)
    ]);
  }
}
