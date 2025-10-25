import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controller/cart_controller.dart';

class FooterDesign5 extends StatelessWidget {
  FooterDesign5({
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
    return Obx(() => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
            padding: EdgeInsets.zero,
            height: 60,
            surfaceTintColor: themeController.footerStyle(
                'backgroundColor', footer['style']['root']['backgroundColor']),
            color: themeController.footerStyle(
                'backgroundColor', footer['style']['root']['backgroundColor']),
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  for (var i = 0; i < children.length; i++) ...[
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              themeController.footerNavigationByType(
                                  footer['options'][children[i]['key']]
                                      ['screenId'],
                                  i);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (children[i]['key'] == 'cart-button') ...[
                                  Badge(
                                      backgroundColor: Colors.red,
                                      isLabelVisible:
                                          _cController.cartCount.value > 0,
                                      child: themeController.pageIndex.value ==
                                              i
                                          ? themeController.filledIcon(
                                              footer['options']
                                                  [children[i]['key']]['icon'],
                                              themeController.footerStyle(
                                                  'color',
                                                  footer['style']
                                                          [children[i]['key']]
                                                      ['color']))
                                          : themeController.iconByTheme(
                                              footer['options']
                                                  [children[i]['key']]['icon'],
                                              themeController.footerStyle(
                                                  'color',
                                                  footer['style']['root']
                                                      ['color']),
                                            ))
                                ] else if (children[i]['key'] ==
                                    'notification-button') ...[
                                  Badge(
                                      backgroundColor: Colors.red,
                                      isLabelVisible: _notificationController
                                              .notificationCount.value >
                                          0,
                                      child: themeController.pageIndex.value ==
                                              i
                                          ? themeController.filledIcon(
                                              footer['options']
                                                  [children[i]['key']]['icon'],
                                              themeController.footerStyle(
                                                  'color',
                                                  footer['style']
                                                          [children[i]['key']]
                                                      ['color']))
                                          : themeController.iconByTheme(
                                              footer['options']
                                                  [children[i]['key']]['icon'],
                                              themeController.footerStyle(
                                                  'color',
                                                  footer['style']['root']
                                                      ['color']),
                                            ))
                                ] else ...[
                                  if (themeController.pageIndex.value == i) ...[
                                    themeController.filledIcon(
                                        footer['options'][children[i]['key']]
                                            ['icon'],
                                        themeController.footerStyle(
                                            'color',
                                            footer['style'][children[i]['key']]
                                                ['color']))
                                  ] else ...[
                                    themeController.iconByTheme(
                                      footer['options'][children[i]['key']]
                                          ['icon'],
                                      themeController.footerStyle('color',
                                          footer['style']['root']['color']),
                                    )
                                  ]
                                ],
                                if (footer['options'][children[i]['key']]['label'] != null)
                                  Container(
                                      child: Text(
                                          footer['options'][children[i]['key']]
                                              ['label'],
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeController.pageIndex.value == i
                                                  ? themeController.footerStyle(
                                                      'color',
                                                      footer['style']
                                                              [children[i]['key']]
                                                          ['color'])
                                                  : themeController.footerStyle(
                                                      'color',
                                                      footer['style']['root']
                                                          ['color']))))
                              ],
                            ))),
                  ]
                ],
              ),
            ))));
  }
}
