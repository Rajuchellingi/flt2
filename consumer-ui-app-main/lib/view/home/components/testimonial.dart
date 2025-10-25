// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/view/home/components/explainer_banner_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class Testimonial extends StatelessWidget {
  Testimonial({
    Key? key,
    required dynamic controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  /// The design configuration for the banner
  final Map<String, dynamic> design;

  /// The home controller instance
  final dynamic _controller;

  /// The theme controller instance
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    // Memoize the instanceId calculation
    final String instanceId =
        _themeController.instanceId(design['componentId']);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (instanceId == 'design1')
          ExplainerBannerDesign1(
            controller: _controller,
            design: design,
          )
      ],
    );
  }
}
