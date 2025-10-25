// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/forgot_password_v1_controller.dart';
import 'package:black_locust/view/forgot_password_v1/components/forgot_password_design2.dart';
import 'package:black_locust/view/forgot_password_v1/components/forgot_password_v1_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordV1Blocks extends StatelessWidget {
  const ForgotPasswordV1Blocks({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final ForgotPasswordV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var intsanceId = _controller.template.value['instanceId'];
        if (intsanceId == 'design2') {
          return ForgotPasswordDesign2(controller: _controller);
        } else {
          return ForgotPasswordV1Body(controller: _controller);
        }
      },
    );
  }
}
