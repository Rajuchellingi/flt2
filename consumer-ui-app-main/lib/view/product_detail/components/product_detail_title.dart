// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design6.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design7.dart';
import 'package:black_locust/view/product_detail/components/product_detail_title_design8.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitle extends StatelessWidget {
  ProductDetailTitle({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductDetailTitleDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        ProductDetailTitleDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        ProductDetailTitleDesign3(controller: _controller, design: design)
      else if (design['instanceId'] == 'design4')
        ProductDetailTitleDesign4(controller: _controller, design: design)
      else if (design['instanceId'] == 'design5')
        ProductDetailTitleDesign5(controller: _controller, design: design)
      else if (design['instanceId'] == 'design6')
        ProductDetailTitleDesign6(controller: _controller, design: design)
      else if (design['instanceId'] == 'design7')
        ProductDetailTitleDesign7(controller: _controller, design: design)
      else if (design['instanceId'] == 'design8')
        ProductDetailTitleDesign8(controller: _controller, design: design)
    ]);
  }
}
