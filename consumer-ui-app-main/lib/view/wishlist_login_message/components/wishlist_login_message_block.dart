// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, unnecessary_null_comparison

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_login_message_controller.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_login_message.dart';
import 'package:black_locust/view/wishlist_login_message/components/wishlist_related_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistLoginMessageBlock extends StatelessWidget {
  WishlistLoginMessageBlock({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final WishlistLoginMessageController _controller;
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
            WishlistLoginMessage(design: item, controller: _controller)
          ],
          if (item['componentId'] == 'related-products' &&
              item['visibility']['hide'] == false &&
              _controller.collectionProduct.value != null &&
              _controller.collectionProduct.value.length > 0)
            WishlistRelatedProducts(
                title: item['source']['title'],
                design: item,
                controller: _controller,
                products: _controller.collectionProduct.value)
        ]
      ]));
    });
  }
}
