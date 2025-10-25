// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailV1Header extends StatelessWidget {
  OrderDetailV1Header({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final OrderDetailV1Controller _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout']['header'];
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: themeController.headerStyle(
                'backgroundColor', header['style']['root']['backgroundColor']),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              for (var item in header['layout']['children']) ...[
                if (item['kind'] == 'text') ...[
                  Container(
                    padding: themeController.headerStyle(
                        'padding', header['style'][item['key']]['padding']),
                    child: Text(
                      header['options'][item['key']]['text'],
                      maxLines: header['options'][item['key']]['numberOfLines'],
                      style: TextStyle(
                          color: themeController.headerStyle(
                              'color', header['style'][item['key']]['color']),
                          fontWeight: themeController.headerStyle('fontWeight',
                              header['style'][item['key']]['fontWeight']),
                          fontSize: themeController.headerStyle('fontSize',
                              header['style'][item['key']]['fontSize'])),
                    ),
                  ),
                  Spacer()
                ] else if (item['kind'] == 'link_button')
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: InkWell(
                          onTap: () {
                            themeController.navigateByType(
                                header['options'][item['key']]['screenId']);
                          },
                          child: themeController.iconByTheme(
                              header['options'][item['key']]['icon'],
                              themeController.headerStyle('color',
                                  header['style'][item['key']]['color']))))
              ]
            ],
          ));
    });
  }
}
