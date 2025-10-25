// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_related_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandCollectionRelatedProductsByCollection extends StatelessWidget {
  BrandCollectionRelatedProductsByCollection({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          for (var design in _controller.productCollections.value) ...[
            ProductDetailRelatedProducts(
              controller: _controller,
              design: design,
              products: design['source']['products'],
            )
          ]
        ]));
  }
}
