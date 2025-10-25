import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/login/components/login_blocks.dart';
import 'package:black_locust/view/login/components/login_body_v1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final dynamic controller = platform == 'shopify'
      ? Get.find<LogInController>()
      : Get.find<LoginV1Controller>();
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final template = controller.template.value;
      final header = template['layout']?['header'];

      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(header, themeController),
          body: platform == 'shopify'
              ? LoginBlocks(controller: controller)
              : LoginBodyV1(),
        ),
      );
    });
  }

  PreferredSizeWidget? _buildAppBar(
      Map<String, dynamic>? header, ThemeController themeController) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: CommonHeader(header: header),
    );
  }
}
