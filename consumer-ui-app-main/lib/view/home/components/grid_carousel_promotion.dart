// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/grid_carousel_promotion_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridCarouselPromotion extends StatelessWidget {
  GridCarouselPromotion({
    Key? key,
    required this.controller,
    required this.design,
  }) : super(key: key);

  final Map<String, dynamic> design;
  final dynamic controller;
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final String instanceId = design['instanceId'] == 'design1'
        ? _themeController.instanceId(design['componentId'])
        : design['instanceId'];

    if (instanceId == 'design1') {
      return GridCarouselPromotionDesign1(
        controller: controller,
        design: design,
      );
    }

    return const SizedBox.shrink();
  }
}
