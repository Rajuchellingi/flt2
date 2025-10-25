// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/view/home/components/announcement_bar_design1.dart';
import 'package:black_locust/view/home/components/announcement_bar_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class AnnouncementBar extends StatelessWidget {
  const AnnouncementBar({
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
          AnnouncementBarDesign1(controller: _controller, design: design)
        else if (instanceId == 'design2')
          AnnouncementBarDesign2(controller: _controller, design: design)
        else
          AnnouncementBarDesign1(controller: _controller, design: design)
      ],
    );
  }
}
