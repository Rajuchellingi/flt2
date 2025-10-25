// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/form_component_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormComponent extends StatelessWidget {
  const FormComponent({
    Key? key,
    required HomeController controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  final Map<String, dynamic> design;
  final HomeController _controller;

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
          FormComponentDesign1(
            controller: _controller,
            design: design,
          )
      ],
    );
  }
}
