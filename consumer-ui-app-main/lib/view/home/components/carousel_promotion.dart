// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design1a.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design2.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design3.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design4.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design5.dart';
import 'package:black_locust/view/home/components/carousel_promotion_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselPromotion extends StatelessWidget {
  CarouselPromotion({
    Key? key,
    required this.controller,
    required this.design,
  }) : super(key: key);

  final dynamic controller;
  final Map<String, dynamic> design;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final String _instanceId = design['instanceId'] == 'design1'
        ? themeController.instanceId(design['componentId'])
        : design['instanceId'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (_instanceId == 'design1')
        //   CarouselPromotionDesign1(
        //     key: const ValueKey('design1'),
        //     controller: controller,
        //     design: design,
        //   )
        if (_instanceId == 'design1')
          CarouselPromotionDesign1a(
            key: const ValueKey('design1'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design2')
          CarouselPromotionDesign2(
            key: const ValueKey('design2'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design3')
          CarouselPromotionDesign3(
            key: const ValueKey('design3'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design4')
          CarouselPromotionDesign4(
            key: const ValueKey('design4'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design5')
          CarouselPromotionDesign5(
            key: const ValueKey('design5'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design6')
          CarouselPromotionDesign6(
            key: const ValueKey('design6'),
            controller: controller,
            design: design,
          )
      ],
    );
  }
}
