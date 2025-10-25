// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/search_header_input.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/policy_page_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyPageHeader extends StatelessWidget {
  PolicyPageHeader({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final PolicyPageController _controller;
  final themeController = Get.find<ThemeController>();
  final _cController = Get.find<CartCountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout']['header'];
      var navbar = headerNavbar(header);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 55,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: themeController.headerStyle(
              'backgroundColor', header['style']['root']['backgroundColor']),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     spreadRadius: 1,
          //     blurRadius: 15,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(children: [
          if (navbar['left'] != null && navbar['left'].length > 0) ...[
            if (navbar['center'] != null && navbar['center'].length > 0) ...[
              Row(children: [
                for (var item in navbar['left']) ...[
                  if (item['kind'] == 'text') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    SearchHeaderInput(
                        header: header,
                        headerOption: header['options']['search-input']),
                  ]
                ]
              ])
            ] else ...[
              Expanded(
                  child: Row(children: [
                for (var item in navbar['left']) ...[
                  if (item['kind'] == 'text') ...[
                    Expanded(child: titleContainer(header, item))
                  ] else if (item['kind'] == 'image') ...[
                    Expanded(child: logoContainer(header, item))
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    SearchHeaderInput(
                        header: header,
                        headerOption: header['options']['search-input']),
                  ]
                ]
              ]))
            ]
          ],
          if (navbar['right'] != null && navbar['right'].length > 0) ...[
            if (navbar['center'] != null && navbar['center'].length > 0) ...[
              Expanded(
                  child: Row(children: [
                for (var item in navbar['right']) ...[
                  if (item['kind'] == 'text') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(
                        child: SearchHeaderInput(
                            header: header,
                            headerOption: header['options']['search-input'])),
                  ]
                ]
              ]))
            ] else ...[
              Row(children: [
                for (var item in navbar['right']) ...[
                  if (item['kind'] == 'text') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(
                        child: SearchHeaderInput(
                            header: header,
                            headerOption: header['options']['search-input'])),
                  ]
                ]
              ])
            ],
          ]
        ]),
      );
    });
  }

  Container iconContainer(header, item) {
    return Container(
        padding: themeController.headerStyle(
            'padding', header['style'][item['key']]['padding']),
        child: InkWell(
            onTap: () {
              themeController
                  .navigateByType(header['options'][item['key']]['screenId']);
            },
            child: header['options'][item['key']]['icon'] == 'wishlist-1'
                ? Badge(
                    backgroundColor: Colors.red,
                    isLabelVisible: _cController.wishlisCount.value > 0,
                    child: themeController.iconByTheme(
                        header['options'][item['key']]['icon'],
                        themeController.headerStyle(
                            'color', header['style'][item['key']]['color'])))
                : header['options'][item['key']]['icon'] == 'cart-1'
                    ? Badge(
                        backgroundColor: Colors.red,
                        isLabelVisible: _cController.cartCount.value > 0,
                        child: themeController.iconByTheme(
                            header['options'][item['key']]['icon'],
                            themeController.headerStyle('color',
                                header['style'][item['key']]['color'])),
                      )
                    : themeController.iconByTheme(
                        header['options'][item['key']]['icon'],
                        themeController.headerStyle(
                            'color', header['style'][item['key']]['color']))));
  }

  Container titleContainer(header, item) {
    return Container(
        padding: themeController.headerStyle(
            'padding', header['style'][item['key']]['padding']),
        child: Text(
          _controller.dataName.value,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          textAlign: themeController.headerStyle(
              'textAlign', header['style'][item['key']]['textAlign']),
          style: TextStyle(
              color: themeController.headerStyle(
                  'color', header['style'][item['key']]['color']),
              fontWeight: themeController.headerStyle(
                  'fontWeight', header['style'][item['key']]['fontWeight']),
              fontSize: themeController.headerStyle(
                  'fontSize', header['style'][item['key']]['fontSize'])),
        ));
  }

  Container logoContainer(header, item) {
    final brightness = Theme.of(Get.context!).brightness;
    return Container(
        alignment: themeController
            .alignment(header['style'][item['key']]['alignment']),
        height: 50,
        child: CachedNetworkImage(
            color: brightness == Brightness.dark ? Colors.white : null,
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: themeController.logo.value));
  }

  headerNavbar(header) {
    var leftContent = header['layout']['children'].where((element) =>
        element['kind'] == 'text' ||
        element['kind'] == 'image' ||
        (element['kind'] == 'link_button' && element['key'] == 'back-button'));
    var rightContent = header['layout']['children'].where((element) =>
        element['kind'] != 'text' &&
        element['key'] != 'back-button' &&
        element['kind'] != 'image');
    var centerContent = header['layout']['children']
        .where((element) => element['kind'] == 'input');
    var navbarList = {
      "left": leftContent,
      "center": centerContent,
      "right": rightContent
    };
    return navbarList;
  }
}
