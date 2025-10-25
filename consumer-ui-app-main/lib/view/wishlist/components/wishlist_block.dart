// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_controller.dart';
import 'package:black_locust/view/wishlist/components/wishlist_product_design1.dart';
import 'package:black_locust/view/wishlist/components/wishlist_product_design2.dart';
import 'package:black_locust/view/wishlist/components/wishlist_product_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistBlock extends StatelessWidget {
  WishlistBlock({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final WishlistController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      return Column(children: [
        for (var item in blocks)
          if (item['componentId'] == 'product-list-component') ...[
            if (item['instanceId'] == 'design1' &&
                item['visibility']['hide'] == false)
              Expanded(
                  child: WishlistProductDesign1(
                      controller: _controller, design: item))
            else if (item['instanceId'] == 'design2' &&
                item['visibility']['hide'] == false)
              Expanded(
                  child: WishlistProductDesign2(
                      controller: _controller, design: item))
            else if (item['instanceId'] == 'design3' &&
                item['visibility']['hide'] == false)
              Expanded(
                  child: WishlistProductDesign3(
                      controller: _controller, design: item))
          ]
      ]);
    });
  }
}
