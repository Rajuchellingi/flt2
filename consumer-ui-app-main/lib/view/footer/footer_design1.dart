// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/notification_controller.dart';

class FooterDesign1 extends StatelessWidget {
  FooterDesign1({
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
    var children = footer['layout']['children'];
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      return Container(
        height: 60.0,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: themeController.footerStyle(
              'backgroundColor', footer['style']['root']['backgroundColor']),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30.0), right: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              CircleAvatar(
                  backgroundColor: themeController.pageIndex.value == i
                      ? brightness == Brightness.dark
                          ? Colors.white
                          : themeController.footerStyle(
                              'backgroundColor',
                              footer['style'][children[i]['key']]
                                  ['backgroundColor'])
                      : themeController.footerStyle('backgroundColor',
                          footer['style']['root']['backgroundColor']),
                  child: IconButton(
                    color: themeController.pageIndex.value == i
                        ? brightness == Brightness.dark
                            ? Colors.black
                            : themeController.footerStyle('color',
                                footer['style'][children[i]['key']]['color'])
                        : themeController.footerStyle(
                            'color', footer['style']['root']['color']),
                    icon: Badge(
                        isLabelVisible: ((footer['options'][children[i]['key']]
                                        ['screenId'] ==
                                    'notification' &&
                                _notificationController
                                        .notificationCount.value >
                                    0) ||
                            (footer['options'][children[i]['key']]
                                        ['screenId'] ==
                                    'cart' &&
                                _cController.cartCount.value > 0)),
                        child: themeController.iconByTheme(
                            footer['options'][children[i]['key']]['icon'],
                            null)),
                    onPressed: () => {
                      themeController.footerNavigationByType(
                          footer['options'][children[i]['key']]['screenId'], i)
                    },
                  ))
            ],
          ],
        ),
      );
    });
  }
}
