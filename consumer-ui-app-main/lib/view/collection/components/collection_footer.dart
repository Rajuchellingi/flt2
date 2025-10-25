// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/collection/components/collection_footer_design1.dart';
import 'package:black_locust/view/collection/components/collection_footer_design2.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionFooter extends StatelessWidget {
  CollectionFooter({
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
        if (footer['componentId'] == 'sort-and-filter') ...[
          if (footer['instanceId'] == 'design1')
            CollectionFooterDesign1(controller: _controller)
          else if (footer['instanceId'] == 'design2')
            CollectionFooterDesign2(controller: _controller)
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
