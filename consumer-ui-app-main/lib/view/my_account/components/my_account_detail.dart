// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/my_account/components/my_account_detail_design2.dart';
import 'package:black_locust/view/my_account/components/my_account_detail_design3.dart';
import 'package:black_locust/view/my_account/components/my_account_detail_design4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_account_detail_design1.dart';

class MyAccountDetail extends StatelessWidget {
  MyAccountDetail({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        MyAccountDetailDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        MyAccountDetailDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        MyAccountDetailDesign1a(controller: _controller, design: design)
      else if (design['instanceId'] == 'design4')
        MyAccountDetailDesign4(controller: _controller, design: design)
    ]);
  }
}
