// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/view/login/components/design3/login_body_design3.dart';
import 'package:black_locust/view/login/components/login_body.dart';
import 'package:black_locust/view/login/components/design2/login_body_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginBlocks extends StatelessWidget {
  const LoginBlocks({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final LogInController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var intsanceId = _controller.template.value['instanceId'];
        if (intsanceId == 'design2') {
          return Center(child: LoginBodyDesign2());
        } else if (intsanceId == 'design3') {
          return LoginBodyDesign3();
        } else {
          return SingleChildScrollView(
              child: LoginBody(controller: _controller));
        }
      },
    );
  }
}
