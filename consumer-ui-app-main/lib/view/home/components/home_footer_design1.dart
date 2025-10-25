// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/notification_controller.dart';

class HomeFooterDesign1 extends StatelessWidget {
  HomeFooterDesign1({
    Key? key,
    required this.template,
  }) : super(key: key);
  final template;
  final _notificationController = Get.find<NotificationController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var footer = template.value['layout']['footer'];
    var children = footer['layout']['children'];
    return Obx(() {
      return Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: themeController.defaultStyle(
              'backgroundColor', footer['style']['root']['backgroundColor']),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30.0), right: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              CircleAvatar(
                  backgroundColor: themeController.pageIndex.value == i
                      ? themeController.defaultStyle(
                          'backgroundColor',
                          footer['style'][children[i]['key']]
                              ['backgroundColor'])
                      : themeController.defaultStyle('backgroundColor',
                          footer['style']['root']['backgroundColor']),
                  child: IconButton(
                    color: themeController.pageIndex.value == i
                        ? themeController.defaultStyle('color',
                            footer['style'][children[i]['key']]['color'])
                        : themeController.defaultStyle(
                            'color', footer['style']['root']['color']),
                    icon: Badge(
                        isLabelVisible:
                            _notificationController.notificationCount.value > 0,
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
