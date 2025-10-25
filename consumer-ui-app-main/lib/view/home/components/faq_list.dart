// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/faq_list_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQList extends StatelessWidget {
  const FAQList({
    Key? key,
    required dynamic controller,
    required Map<String, dynamic> design,
  })  : _controller = controller,
        _design = design,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> _design;
  static final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final String instanceId = _design['instanceId'] == 'design1'
        ? _themeController.instanceId(_design['componentId'])
        : _design['instanceId'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (instanceId == 'design1')
          FAQListDesign1(
            controller: _controller,
            design: _design,
          ),
      ],
    );
  }
}
