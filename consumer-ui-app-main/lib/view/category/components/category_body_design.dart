// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/category/components/category_block_design1.dart';
import 'package:black_locust/view/category/components/category_block_design1a.dart';
import 'package:black_locust/view/category/components/category_block_design2.dart';
import 'package:black_locust/view/category/components/category_block_design3.dart';
import 'package:black_locust/view/category/components/category_block_design4.dart';
import 'package:black_locust/view/category/components/category_block_design5.dart';
import 'package:black_locust/view/category/components/category_block_design6.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBodyDesign extends StatelessWidget {
  CategoryBodyDesign({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CategoryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return Column(children: [
        for (var item in blocks) ...[
          if (item['componentId'] == 'collection-component') ...[
            if (item['instanceId'] == 'design1' &&
                item['visibility']['hide'] == false) ...[
              CategoryBlockDesign1(
                  controller: _controller,
                  menuLists: item['source']['lists'],
                  options: item['options'])
            ] else if (item['instanceId'] == 'design2' &&
                item['visibility']['hide'] == false) ...[
              Expanded(
                  child: CategoryBlockDesign2(
                controller: _controller,
                menuLists: item['source']['lists'],
                theme: item,
              ))
            ] else if (item['instanceId'] == 'design3' &&
                item['visibility']['hide'] == false) ...[
              Expanded(
                  child: CateogryBlockDesign3(
                controller: _controller,
                menuLists: item['source']['lists'],
              ))
            ] else if (item['instanceId'] == 'design4' &&
                item['visibility']['hide'] == false) ...[
              Expanded(
                  child: CategoryBlockDesign4(
                controller: _controller,
                menuLists: item['source']['lists'],
              ))
            ] else if (item['instanceId'] == 'design5' &&
                item['visibility']['hide'] == false) ...[
              Expanded(
                  child: CategoryBlockDesign5(
                controller: _controller,
                menuLists: item['source']['lists'],
              ))
            ] else if (item['instanceId'] == 'design6' &&
                item['visibility']['hide'] == false) ...[
              Expanded(
                  child: CategoryBlockDesign6(
                controller: _controller,
                menuLists: item['source']['lists'],
              )),
            ] else if (item['instanceId'] == 'design7' &&
                item['visibility']['hide'] == false) ...[
              CategoryBlockDesign1a(
                controller: _controller,
                menuLists: item['source']['lists'],
              )
            ],
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
