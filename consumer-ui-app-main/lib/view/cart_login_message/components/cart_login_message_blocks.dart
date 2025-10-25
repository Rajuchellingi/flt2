// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, unnecessary_null_comparison

import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_message.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_related_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartLoginMessageBlocks extends StatelessWidget {
  CartLoginMessageBlocks({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CartLoginMessageController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      return SingleChildScrollView(
          child: Column(children: [
        for (var item in blocks) ...[
          if (item['componentId'] == 'login-message' &&
              item['visibility']['hide'] == false) ...[
            CartLoginMessage(design: item, controller: _controller)
          ],
          if (item['componentId'] == 'related-products' &&
              item['visibility']['hide'] == false &&
              _controller.collectionProduct.value != null &&
              _controller.collectionProduct.value.length > 0)
            CartLoginRelatedProducts(
                title: item['source']['title'],
                design: item,
                controller: _controller,
                products: _controller.collectionProduct.value)
        ]
      ]));
    });
  }
}
