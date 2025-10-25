// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_body.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_footer.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1Screen extends StatelessWidget {
  final _controller = Get.find<CheckoutV1Controller>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final dynamic argument = Get.arguments;
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.grey[50],
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
        body: SafeArea(
          child: Obx(() => _controller.isLoading.value
              ? LoadingIcon(
                  logoPath: themeController.logo.value,
                )
              : CheckoutV1Body(controller: _controller)),
        ),
        bottomNavigationBar: CheckoutV1Footer(controller: _controller),
      ));
    });
  }
}
