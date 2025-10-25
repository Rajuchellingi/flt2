// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_collapse.dart';
import 'package:black_locust/view/product_detail/components/product_detail_collapse_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_rich_text_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdcutDetailRichText extends StatelessWidget {
  ProdcutDetailRichText({Key? key, required this.design}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  final design;

  @override
  Widget build(BuildContext context) {
    var instanceId = themeController.instanceId('rich-text-block');
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (instanceId == 'design1')
        ProductDetailCollapse(
          designBlock: design,
          title: design['source']['title'],
          description: design['source']['html'],
        )
      else if (instanceId == 'design2')
        ProductDetailCollapseDesign2(
          designBlock: design,
          title: design['source']['title'],
          description: design['source']['html'],
        )
      else if (instanceId == 'design3')
        ProductDetailRichTextDesign3(
          designBlock: design,
          title: design['source']['title'],
          description: design['source']['html'],
        )
    ]);
  }
}
