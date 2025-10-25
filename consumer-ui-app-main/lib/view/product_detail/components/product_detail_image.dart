// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design6.dart';
import 'package:black_locust/view/product_detail/components/product_detail_image_design7.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailImage extends StatelessWidget {
  ProductDetailImage({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductDetailImageDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        ProductDetailImageDesign2(controller: _controller)
      else if (design['instanceId'] == 'design3')
        ProductDetailImageDesign3(controller: _controller, design: design)
      else if (design['instanceId'] == 'design4')
        ProductDetailImageDesign4(controller: _controller, design: design)
      else if (design['instanceId'] == 'design5')
        ProductDetailImageDesign5(controller: _controller, design: design)
      else if (design['instanceId'] == 'design6')
        ProductDetailImageDesign6(controller: _controller)
      else if (design['instanceId'] == 'design7')
        ProductDetailImageDesign7(controller: _controller, design: design)
    ]);
  }
}
