// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/account_controller.dart';
import 'package:flutter/material.dart';

import 'my_account_logout_design1.dart';

class MyAccountLogout extends StatelessWidget {
  const MyAccountLogout({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        MyAccountLogoutDesign1(controller: _controller, design: design)
    ]);
  }
}
