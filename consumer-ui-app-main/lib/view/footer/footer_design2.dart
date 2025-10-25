import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controller/cart_controller.dart';

class FooterDesign2 extends StatelessWidget {
  FooterDesign2({
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
    final brightness = Theme.of(Get.context!).brightness;

    return Obx(() => BottomAppBar(
          padding: EdgeInsets.zero,
          height: 60,
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
                          CircleAvatar(
                            backgroundColor: themeController.pageIndex.value ==
                                    i
                                ? brightness == Brightness.dark
                                    ? Colors.white
                                    : themeController.footerStyle(
                                        'backgroundColor',
                                        footer['style'][children[i]['key']]
                                            ['backgroundColor'])
                                : themeController.footerStyle('backgroundColor',
                                    footer['style']['root']['backgroundColor']),
                            child: Badge(
                                backgroundColor: Colors.red,
                                isLabelVisible:
                                    _cController.cartCount.value > 0,
                                child: themeController.iconByTheme(
                                    footer['options'][children[i]['key']]
                                        ['icon'],
                                    themeController.pageIndex.value == i
                                        ? brightness == Brightness.dark
                                            ? Colors.black
                                            : themeController.footerStyle(
                                                'color',
                                                footer['style']
                                                        [children[i]['key']]
                                                    ['color'])
                                        : themeController.footerStyle('color',
                                            footer['style']['root']['color']))),
                          )
                        ] else if (children[i]['key'] ==
                            'notification-button') ...[
                          CircleAvatar(
                            backgroundColor: themeController.pageIndex.value ==
                                    i
                                ? brightness == Brightness.dark
                                    ? Colors.white
                                    : themeController.footerStyle(
                                        'backgroundColor',
                                        footer['style'][children[i]['key']]
                                            ['backgroundColor'])
                                : themeController.footerStyle('backgroundColor',
                                    footer['style']['root']['backgroundColor']),
                            child: Badge(
                                backgroundColor: Colors.red,
                                isLabelVisible: _notificationController
                                        .notificationCount.value >
                                    0,
                                child: themeController.iconByTheme(
                                    footer['options'][children[i]['key']]
                                        ['icon'],
                                    themeController.pageIndex.value == i
                                        ? brightness == Brightness.dark
                                            ? Colors.black
                                            : themeController.footerStyle(
                                                'color',
                                                footer['style']
                                                        [children[i]['key']]
                                                    ['color'])
                                        : themeController.footerStyle('color',
                                            footer['style']['root']['color']))),
                          )
                        ] else ...[
                          CircleAvatar(
                              backgroundColor:
                                  themeController.pageIndex.value == i
                                      ? brightness == Brightness.dark
                                          ? Colors.white
                                          : themeController.footerStyle(
                                              'backgroundColor',
                                              footer['style']
                                                      [children[i]['key']]
                                                  ['backgroundColor'])
                                      : themeController.footerStyle(
                                          'backgroundColor',
                                          footer['style']['root']
                                              ['backgroundColor']),
                              child: themeController.iconByTheme(
                                  footer['options'][children[i]['key']]['icon'],
                                  themeController.pageIndex.value == i
                                      ? brightness == Brightness.dark
                                          ? Colors.black
                                          : themeController.footerStyle(
                                              'color',
                                              footer['style']
                                                  [children[i]['key']]['color'])
                                      : themeController.footerStyle('color',
                                          footer['style']['root']['color'])))
                        ],
                      ],
                    )),
              ]
            ],
          ),
        ));
  }
}
