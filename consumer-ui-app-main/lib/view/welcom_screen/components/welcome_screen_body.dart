// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/welcome_screen_controller.dart';
import 'package:black_locust/view/welcom_screen/components/welcome_screen_design1.dart';
import 'package:black_locust/view/welcom_screen/components/welcome_screen_design2.dart';
import 'package:black_locust/view/welcom_screen/components/welcome_screen_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody(
      {Key? key, required controller, required this.themeController})
      : _controller = controller,
        super(key: key);

  final WelcomeScreenController _controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var instanceId = _controller.template.value['instanceId'];
        if (instanceId == 'design1')
          return WelcomeScreenDesign1(
              controller: _controller, themeController: themeController);
        else if (instanceId == 'design2')
          return WelcomeScreenDesign2(
              controller: _controller, themeController: themeController);
        else if (instanceId == 'design3')
          return WelcomeScreenDesign3(
              controller: _controller, themeController: themeController);
        else
          return SizedBox.shrink();
      },
    );
  }
}
