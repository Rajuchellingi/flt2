// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_custom_variant_design1.dart';
import 'package:black_locust/view/product_detail/components/product_custom_variant_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCustomVariant extends StatelessWidget {
  ProductCustomVariant({Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductCustomVariantDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        ProductCustomVariantDesign2(controller: _controller, design: design)
    ]);
  }
}
