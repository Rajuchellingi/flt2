// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/view/register/components/design2/registration_body_design2.dart';
import 'package:black_locust/view/register/components/design3/registration_body_design3.dart';
import 'package:black_locust/view/register/components/registration_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationBlock extends StatelessWidget {
  const RegistrationBlock({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var intsanceId = _controller.template.value['instanceId'];
        if (intsanceId == 'design2') {
          return Center(child: RegistrationBodyDesign2());
        } else if (intsanceId == 'design3') {
          return RegistrationBodyDesign3();
        } else {
          return RegistrationBody();
        }
      },
    );
  }
}
