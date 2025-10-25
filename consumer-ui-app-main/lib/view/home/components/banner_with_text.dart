// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/banner_with_text_design1.dart';
import 'package:black_locust/view/home/components/banner_with_text_design2.dart';
import 'package:black_locust/view/home/components/banner_with_text_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWithText extends StatelessWidget {
  const BannerWithText({
    Key? key,
    required this.controller,
    required this.design,
  }) : super(key: key);

  final Map<String, dynamic> design;
  final dynamic controller;

  // Move themeController to a static field to avoid recreating it on each build
  static final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    // Cache the instanceId calculation
    final String instanceId = design['instanceId'] == 'design1'
        ? themeController.instanceId(design['componentId'])
        : design['instanceId'];

    // Use const constructor where possible
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (instanceId == 'design1')
          BannerWithTextDesign1(
            controller: controller,
            design: design,
          )
        else if (instanceId == 'design2')
          BannerWithTextDesign2(
            controller: controller,
            design: design,
          )
        else if (instanceId == 'design3')
          BannerWithTextDesign3(
            controller: controller,
            design: design,
          )
      ],
    );
  }
}
