// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_login_message_controller.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products_design1.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products_design2.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products_design3.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products_design4.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistRelatedProducts extends StatelessWidget {
  WishlistRelatedProducts({
    Key? key,
    required this.title,
    required this.design,
    required controller,
    required this.products,
  })  : _controller = controller,
        super(key: key);

  final title;
  final design;
  final WishlistLoginMessageController _controller;
  final products;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var instanceId = themeController.instanceId('product');
    if (instanceId == 'design1') {
      return WishlistRelatedProductsDesign1(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design2') {
      return WishlistRelatedProductsDesign2(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design3') {
      return WishlistRelatedProductsDesign3(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design4') {
      return WishlistRelatedProductsDesign4(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design5') {
      return WishlistRelatedProductsDesign4(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design6') {
      return WishlistRelatedProductsDesign6(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else {
      return Container();
    }
  }
}
