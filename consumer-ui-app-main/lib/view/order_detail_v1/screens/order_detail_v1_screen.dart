// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/order_detail_v1/components/order_detail_v1_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailV1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<OrderDetailV1Controller>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      return SafeArea(
          child: Scaffold(
        appBar: (header != null && header.isNotEmpty)
            ? AppBar(
                backgroundColor: themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                elevation: 0.0,
                forceMaterialTransparency: true,
                title: CommonHeader(header: header),
              )
            : null,
        body: OrderDetailV1Body(controller: _controller),
      ));
    });
  }
}
