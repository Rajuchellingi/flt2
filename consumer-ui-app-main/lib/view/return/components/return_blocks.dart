// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/return/components/return_product_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReturnBlocks extends StatelessWidget {
  ReturnBlocks({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      var blocks = _controller.template.value['layout']['blocks'];
      return Column(children: [
        for (var item in blocks) ...[
          if (item['componentId'] == 'return-order-component') ...[
            if (item['instanceId'] == 'design1' &&
                item['visibility']['hide'] == false)
              Expanded(child: ReturnProductDesign1(controller: _controller))
          ]
        ],
        if (footer != null &&
            footer.isNotEmpty &&
            themeController.bottomBarType.value == 'design1' &&
            footer['componentId'] == 'footer-navigation')
          const SizedBox(height: 80),
      ]);
    });
  }
}
