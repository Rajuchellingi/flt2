// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailRelatedProducts extends StatelessWidget {
  ProductDetailRelatedProducts(
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
    var instanceId = themeController.instanceId('product');
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (instanceId == 'design1')
        ProductDetailRelatedProductsDesign1(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design2')
        ProductDetailRelatedProductsDesign2(
            controller: _controller, design: design)
      else if (instanceId == 'design3')
        ProductDetailRelatedProductsDesign3(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design4')
        ProductDetailRelatedProductsDesign4(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design5')
        ProductDetailRelatedProductsDesign5(
            controller: _controller, design: design, products: products)
      else if (instanceId == 'design6')
        ProductDetailRelatedProductsDesign6(
            controller: _controller, design: design, products: products)
    ]);
  }
}
