// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/welcome_screen_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/welcom_screen/components/welcome_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeScreenController controller =
      Get.find<WelcomeScreenController>();
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final template = controller.template.value;
      final header = template['layout']?['header'];
      var block = template['layout']['blocks'][controller.currentIndex.value];

      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(header, themeController),
          backgroundColor: themeController.defaultStyle(
              'backgroundColor', block['style']['backgroundColor']),
          body: WelcomeScreenBody(
              controller: controller, themeController: themeController),
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
