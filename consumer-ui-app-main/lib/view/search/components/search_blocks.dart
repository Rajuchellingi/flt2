// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/search/components/search_block_design1.dart';
import 'package:black_locust/view/search/components/search_block_design2.dart';
import 'package:black_locust/view/search/components/search_block_design3.dart';
import 'package:black_locust/view/search/components/search_block_design4.dart';
import 'package:black_locust/view/search/components/search_block_design5.dart';
import 'package:black_locust/view/search/components/search_block_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBlocks extends StatelessWidget {
  SearchBlocks({
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
          if (item['componentId'] == 'product-list-component' &&
              item['visibility']['hide'] == false)
            if (item['instanceId'] == 'design1')
              Expanded(
                  child:
                      SearchBlockDesign1(controller: _controller, design: item))
            else if (item['instanceId'] == 'design2')
              Expanded(
                  child:
                      SearchBlockDesign2(controller: _controller, design: item))
            else if (item['instanceId'] == 'design3')
              Expanded(
                  child:
                      SearchBlockDesign3(controller: _controller, design: item))
            else if (item['instanceId'] == 'design4')
              Expanded(
                  child:
                      SearchBlockDesign4(controller: _controller, design: item))
            else if (item['instanceId'] == 'design5')
              Expanded(
                  child:
                      SearchBlockDesign5(controller: _controller, design: item))
            else if (item['instanceId'] == 'design6')
              Expanded(
                  child:
                      SearchBlockDesign6(controller: _controller, design: item))
      ]);
    });
  }
}
