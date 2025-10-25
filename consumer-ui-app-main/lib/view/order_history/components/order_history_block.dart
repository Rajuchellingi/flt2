// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/order_history/components/order_history_body.dart';
import 'package:black_locust/view/order_history/components/order_list_design2.dart';
import 'package:black_locust/view/order_history/components/order_list_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryBlock extends StatelessWidget {
  OrderHistoryBlock({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      return Column(children: [
        for (var item in blocks)
          if (item['componentId'] == 'order-list-component') ...[
            if (item['instanceId'] == 'design1' &&
                item['visibility']['hide'] == false)
              Expanded(child: OrderHistoryBody(controller: _controller))
            else if (item['instanceId'] == 'design2' &&
                item['visibility']['hide'] == false)
              Expanded(child: OrderListDesign2(controller: _controller))
            else if (item['instanceId'] == 'design3' &&
                item['visibility']['hide'] == false)
              Expanded(child: OrderListDesign3(controller: _controller))
          ]
      ]);
    });
  }
}
