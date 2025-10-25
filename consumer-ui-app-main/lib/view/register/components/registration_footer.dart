// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationFooter extends StatelessWidget {
  RegistrationFooter({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      var bottomBarDesign = themeController.bottomBarType.value;

      return Column(mainAxisSize: MainAxisSize.min, children: [
        if (_controller.isUserType.value == true &&
            _controller.userType.value != null &&
            _controller.userType.value.isNotEmpty) ...[
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: DefaultButton(
                text: "Proceed",
                press: () {
                  if (_controller.userType.value.isNotEmpty) {
                    _controller.getRegistrationFormByType();
                  } else {
                    _controller.isError.value = true;
                  }
                },
              )),
        ] else if (footer['componentId'] == 'footer-navigation') ...[
          if (bottomBarDesign == 'design1')
            FooterDesign1(template: _controller.template.value)
          else if (bottomBarDesign == 'design2')
            FooterDesign2(template: _controller.template.value)
          else if (bottomBarDesign == 'design3')
            FooterDesign3(template: _controller.template.value)
          else if (bottomBarDesign == 'design4')
            FooterDesign4(template: _controller.template.value)
          else if (bottomBarDesign == 'design5')
            FooterDesign5(template: _controller.template.value)
        ]
      ]);
    });
  }
}
