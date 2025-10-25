// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products_design1.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products_design2.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products_design3.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products_design4.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartLoginRelatedProducts extends StatelessWidget {
  CartLoginRelatedProducts({
    Key? key,
    required this.title,
    required this.design,
    required controller,
    required this.products,
  })  : _controller = controller,
        super(key: key);

  final title;
  final design;
  final CartLoginMessageController _controller;
  final products;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var instanceId = themeController.instanceId('product');
    if (instanceId == 'design1') {
      return CartLoginRelatedProductsDesign1(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design2') {
      return CartLoginRelatedProductsDesign2(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design3') {
      return CartLoginRelatedProductsDesign3(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design4') {
      return CartLoginRelatedProductsDesign4(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design5') {
      return CartLoginRelatedProductsDesign4(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design6') {
      return CartLoginRelatedProductsDesign6(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else {
      return Container();
    }
  }
}
