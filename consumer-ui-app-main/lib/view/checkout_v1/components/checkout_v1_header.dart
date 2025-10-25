// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/search_header_input.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1Header extends StatelessWidget {
  CheckoutV1Header({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CheckoutV1Controller _controller;
  final themeController = Get.find<ThemeController>();
  final _cController = Get.find<CartCountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout']['header'];
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 55,
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
                ] else if (item['kind'] == 'link_button') ...[
                  Container(
                      padding: themeController.headerStyle(
                          'padding', header['style'][item['key']]['padding']),
                      child: InkWell(
                          onTap: () {
                            themeController.navigateByType(
                                header['options'][item['key']]['screenId']);
                          },
                          child: header['options'][item['key']]['icon'] ==
                                  'wishlist-1'
                              ? Badge(
                                  backgroundColor: Colors.red,
                                  isLabelVisible:
                                      _cController.wishlisCount.value > 0,
                                  child: themeController.iconByTheme(
                                      header['options'][item['key']]['icon'],
                                      themeController.headerStyle(
                                          'color',
                                          header['style'][item['key']]
                                              ['color'])))
                              : header['options'][item['key']]['icon'] ==
                                      'cart-1'
                                  ? Badge(
                                      backgroundColor: Colors.red,
                                      isLabelVisible:
                                          _cController.cartCount.value > 0,
                                      child: themeController.iconByTheme(
                                          header['options'][item['key']]
                                              ['icon'],
                                          themeController.headerStyle(
                                              'color',
                                              header['style'][item['key']]
                                                  ['color'])),
                                    )
                                  : themeController.iconByTheme(
                                      header['options'][item['key']]['icon'],
                                      themeController.headerStyle(
                                          'color',
                                          header['style'][item['key']]
                                              ['color']))))
                ] else if (item['kind'] == 'input') ...[
                  Expanded(
                      child: SearchHeaderInput(
                          header: header,
                          headerOption: header['options']['search-input'])),
                ]
              ]
            ],
          ));
    });
  }
}
