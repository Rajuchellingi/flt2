// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/card_banner_design1.dart';
import 'package:black_locust/view/home/components/card_banner_design2.dart';
import 'package:black_locust/view/home/components/card_banner_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardBanner extends StatelessWidget {
  const CardBanner({
    Key? key,
    required this.controller,
    required this.design,
  }) : super(key: key);

  final Map<String, dynamic> design;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String instanceId = design['instanceId'] == 'design1'
        ? themeController.instanceId(design['componentId'])
        : design['instanceId'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (instanceId == 'design1')
          CardBannerDesign1(
            controller: controller,
            design: design,
          ),
        if (instanceId == 'design2')
          CardBannerDesign2(
            controller: controller,
            themeController: themeController,
            design: design,
          ),
        if (instanceId == 'design3')
          CardBannerDesign3(
            controller: controller,
            design: design,
          ),
      ],
    );
  }
}
