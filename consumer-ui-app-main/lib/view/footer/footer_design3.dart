// ignore_for_file: unused_field

import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FooterDesign3 extends StatelessWidget {
  FooterDesign3({
    Key? key,
    required this.template,
  }) : super(key: key);
  final template;
  final _notificationController = Get.find<NotificationController>();
  final themeController = Get.find<ThemeController>();
  final _cController = Get.find<CartCountController>();

  @override
  Widget build(BuildContext context) {
    var footer = template['layout']['footer'];
    var children = footerChildrens(footer);
    return Obx(() => BottomAppBar(
          padding: EdgeInsets.zero,
          height: 55,
          // color: kPrimaryColor,
          surfaceTintColor: themeController.footerStyle(
              'backgroundColor', footer['style']['root']['backgroundColor']),
          color: themeController.footerStyle(
              'backgroundColor', footer['style']['root']['backgroundColor']),
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (var i = 0; i < children.length; i++) ...[
                InkWell(
                    onTap: () {
                      themeController.footerNavigationByType(
                          footer['options'][children[i]['key']]['screenId'], i);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (children[i]['key'] == 'cart-button') ...[
                          Badge(
                              backgroundColor: Colors.red,
                              isLabelVisible: _cController.cartCount.value > 0,
                              child: themeController.iconByTheme(
                                  footer['options'][children[i]['key']]['icon'],
                                  themeController.pageIndex.value == i
                                      ? themeController.footerStyle(
                                          'color',
                                          footer['style'][children[i]['key']]
                                              ['color'])
                                      : themeController.footerStyle('color',
                                          footer['style']['root']['color']))),
                        ] else if (children[i]['key'] ==
                            'notification-button') ...[
                          Badge(
                              backgroundColor: Colors.red,
                              isLabelVisible: _notificationController
                                      .notificationCount.value >
                                  0,
                              child: themeController.iconByTheme(
                                  footer['options'][children[i]['key']]['icon'],
                                  themeController.pageIndex.value == i
                                      ? themeController.footerStyle(
                                          'color',
                                          footer['style'][children[i]['key']]
                                              ['color'])
                                      : themeController.footerStyle('color',
                                          footer['style']['root']['color']))),
                        ] else ...[
                          themeController.iconByTheme(
                              footer['options'][children[i]['key']]['icon'],
                              themeController.pageIndex.value == i
                                  ? themeController.footerStyle(
                                      'color',
                                      footer['style'][children[i]['key']]
                                          ['color'])
                                  : themeController.footerStyle('color',
                                      footer['style']['root']['color']))
                        ],
                      ],
                    ))
              ],
            ],
          ),
        ));
  }

  footerChildrens(footer) {
    var result = [];
    if (footer != null) {
      if (footer['layout'] != null &&
          footer['layout']['children'] != null &&
          footer['layout']['children'].length > 0) {
        result = footer['layout']['children'].where((element) {
          var key = element['key'];
          return footer['options'][key]['isCenterButton'] != true;
        }).toList();
      }
    }
    return result;
  }
}

class CustomFAB extends StatelessWidget {
  CustomFAB({Key? key, required this.template, required this.actionButton})
      : super(key: key);
  final template;
  final actionButton;
  final _notificationController = Get.find<NotificationController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    var footer = template['layout']['footer'];
    return Obx(() {
      var isBadge = _notificationController.notificationCount.value > 0;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: themeController.footerStyle('backgroundColor',
                  footer['style'][actionButton['key']]['color']),
              onPressed: () {},
              child: Badge(
                backgroundColor: Colors.red,
                isLabelVisible:
                    (actionButton['key'] == 'notification-button' && isBadge),
                child: themeController.iconByTheme(
                  footer['options'][actionButton['key']]['icon'],
                  themeController.footerStyle(
                      'backgroundColor', footer['style']['root']['color']),
                  size: 30.0,
                ),
              )),
        ],
      );
    });
  }
}
