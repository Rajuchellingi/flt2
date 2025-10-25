// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/my_account/components/my_account_policy_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_account_policy_design1.dart';

class MyAccountPolicy extends StatelessWidget {
  MyAccountPolicy({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        MyAccountPolicyDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        MyAccountPolicyDesign2(controller: _controller, design: design)
    ]);
  }
}
