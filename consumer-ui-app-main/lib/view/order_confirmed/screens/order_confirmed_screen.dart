// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/order_confirmation_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/order_confirmed/components/loyality_order_confirmed.dart';
import 'package:black_locust/view/order_confirmed/components/order_confirmed_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConfirmedScreen extends StatelessWidget {
  final _controller = Get.find<OrderConfirmationController>();
  final themeController = Get.find<ThemeController>();
  final loyalityController = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
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
        body: _controller.isLoading.value
            ? LoadingIcon(
                logoPath: themeController.logo.value,
              )
            : loyalityController.isLoyality.value
                ? LoyalityOrderConfirmed(controller: _controller)
                : OrderConfirmedBody(controller: _controller),
      ));
    });
  }
}
