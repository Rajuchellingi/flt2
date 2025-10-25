// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/view/home/components/fixed_banner_design1a.dart';
import 'package:black_locust/view/home/components/fixed_banner_design2.dart';
import 'package:black_locust/view/home/components/fixed_banner_design3.dart';
import 'package:black_locust/view/home/components/fixed_banner_design5.dart';
import 'package:black_locust/view/home/components/fixed_banner_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class FixedBanner extends StatelessWidget {
  const FixedBanner({
    Key? key,
    required dynamic controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  final Map<String, dynamic> design;
  final dynamic _controller;

  // Cache the theme controller instance
  static final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    // Memoize the instanceId calculation
    final String instanceId = design['instanceId'] == 'design1'
        ? _themeController.instanceId(design['componentId'])
        : design['instanceId'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (instanceId == 'design1')
        //   FixedBannerDesign1(
        //     controller: _controller,
        //     design: design,
        //   )
        if (instanceId == 'design1')
          FixedBannerDesign1a(controller: _controller, design: design)
        else if (instanceId == 'design2')
          FixedBannerDesign2(controller: _controller, design: design)
        else if (instanceId == 'design3')
          FixedBannerDesign3(controller: _controller, design: design)
        else if (instanceId == 'design5')
          FixedBannerDesign5(controller: _controller, design: design)
        else if (instanceId == 'design6')
          FixedBannerDesign6(controller: _controller, design: design)
      ],
    );
  }
}
