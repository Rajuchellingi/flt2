// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/my_account/components/my_account_menu_design2.dart';
import 'package:black_locust/view/my_account/components/my_account_menu_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_account_menu_design1.dart';

class MyAccountMenu extends StatelessWidget {
  MyAccountMenu({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        MyAccountMenuDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        MyAccountMenuDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        MyAccountMenuDesign3(controller: _controller, design: design)
    ]);
  }
}
