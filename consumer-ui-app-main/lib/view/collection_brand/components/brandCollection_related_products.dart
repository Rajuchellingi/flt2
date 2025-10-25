// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/collection/components/collection_related_product_design1.dart';
import 'package:black_locust/view/collection/components/collection_related_product_design2.dart';
import 'package:black_locust/view/collection/components/collection_related_product_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandCollectionRelatedProducts extends StatelessWidget {
  BrandCollectionRelatedProducts(
      {Key? key,
      required controller,
      required this.design,
      required this.products})
      : _controller = controller,
        super(key: key);

  final design;
  final products;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var instanceId = design['instanceId'];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (instanceId == 'design1')
        CollectionRelatedProductDesign1(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design2')
        CollectionRelatedProductDesign2(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design3')
        CollectionRelatedProductDesign3(
            controller: _controller, design: design, products: products)
    ]);
  }
}
