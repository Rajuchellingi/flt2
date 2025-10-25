// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/icon_info_design1.dart';
import 'package:black_locust/view/home/components/icon_info_design2.dart';
import 'package:black_locust/view/home/components/icon_info_design3.dart';
import 'package:black_locust/view/home/components/icon_info_design4.dart';
import 'package:black_locust/view/home/components/icon_info_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconInfo extends StatelessWidget {
  const IconInfo({
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
        if (instanceId == 'design1')
          IconInfoDesign1(
            controller: _controller,
            design: design,
          )
        else if (instanceId == 'design2')
          IconInfoDesign2(
            controller: _controller,
            themeController: _themeController,
            design: design,
          )
        else if (instanceId == 'design3')
          IconInfoDesign3(
            controller: _controller,
            design: design,
          )
        else if (instanceId == 'design4')
          IconInfoDesign4(
            controller: _controller,
            themeController: _themeController,
            design: design,
          )
        else if (instanceId == 'design5')
          IconInfoDesign5(
            controller: _controller,
            themeController: _themeController,
            design: design,
          )
      ],
    );
  }
}
