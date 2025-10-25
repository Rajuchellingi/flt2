// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design1.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design10.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design1a.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design2.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design3.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design4.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design6.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design7.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design8.dart';
import 'package:black_locust/view/home/components/fixed_promotion_design9.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FixedPromotion extends StatelessWidget {
  FixedPromotion({
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
        if (_instanceId == 'design1')
          FixedPromotionDesign1a(
            key: const ValueKey('design1'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design2')
          FixedPromotionDesign2(
            key: const ValueKey('design2'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design3')
          FixedPromotionDesign3(
            key: const ValueKey('design3'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design4')
          FixedPromotionDesign4(
            key: const ValueKey('design4'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design5')
          FixedPromotionDesign1(
            key: const ValueKey('design5'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design6')
          FixedPromotionDesign6(
            key: const ValueKey('design6'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design7')
          FixedPromotionDesign7(
            key: const ValueKey('design7'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design8')
          FixedPromotionDesign8(
            key: const ValueKey('design8'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design9')
          FixedPromotionDesign9(
            key: const ValueKey('design9'),
            controller: controller,
            design: design,
          )
        else if (_instanceId == 'design10')
          FixedPromotionDesign10(
            key: const ValueKey('design10'),
            controller: controller,
            design: design,
          )
      ],
    );
  }
}
