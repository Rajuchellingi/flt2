// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, deprecated_member_use, unnecessary_null_comparison

import 'package:black_locust/common_component/search_header_input.dart';
import 'package:black_locust/common_component/search_header_input_design2.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHeader extends StatelessWidget {
  SearchHeader({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          if (navbar['left'] != null && navbar['left'].length > 0) ...[
            if (navbar['center'] != null && navbar['center'].length > 0) ...[
              Row(children: [
                for (var item in navbar['left']) ...[
                  if (item['kind'] == 'search-title') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(child: searchInputContainer(header, item)),
                  ]
                ]
              ])
            ] else ...[
              Expanded(
                  child: Row(children: [
                for (var item in navbar['left']) ...[
                  if (item['kind'] == 'search-title') ...[
                    Expanded(child: titleContainer(header, item))
                  ] else if (item['kind'] == 'image') ...[
                    Expanded(
                        flex: header['options'][item['key']]['flex'] ?? 1,
                        child: logoContainer(header, item))
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(child: searchInputContainer(header, item)),
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
                  if (item['kind'] == 'search-title') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(child: searchInputContainer(header, item)),
                  ]
                ]
              ]))
            ] else ...[
              Row(children: [
                for (var item in navbar['right']) ...[
                  if (item['kind'] == 'search-title') ...[
                    titleContainer(header, item)
                  ] else if (item['kind'] == 'image') ...[
                    logoContainer(header, item)
                  ] else if (item['kind'] == 'link_button') ...[
                    iconContainer(header, item)
                  ] else if (item['kind'] == 'input') ...[
                    Expanded(child: searchInputContainer(header, item)),
                  ]
                ]
              ])
            ]
          ]
        ]),
      );
    });
  }

  Widget searchInputContainer(header, item) {
    if (header['options'][item['key']]['instanceId'] == 'design2') {
      return SearchHeaderInputDesign2(
          header: header,
          headerOption: header['options'][item['key']],
          style: header['style'][item['key']]);
    } else {
      return SearchHeaderInput(
          header: header, headerOption: header['options'][item['key']]);
    }
  }

  Container logoContainer(header, item) {
    final brightness = Theme.of(Get.context!).brightness;
    return Container(
        alignment: themeController
            .alignment(header['style'][item['key']]['alignment']),
        height: 50,
        child: CachedNetworkImage(
            color: (brightness == Brightness.dark &&
                    themeController.logo.value != null &&
                    themeController.logo.value.contains('.png'))
                ? Colors.white
                : null,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: (item['key'] == 'secondary-logo' &&
                    themeController.secondaryLogo.value.isNotEmpty)
                ? themeController.secondaryLogo.value
                : themeController.logo.value));
  }

  Widget iconContainer(header, item) {
    return InkWell(
        onTap: () {
          if (item['key'] == 'filter-button') {
            _controller.openFilter();
          } else {
            themeController
                .navigateByType(header['options'][item['key']]['screenId']);
          }
        },
        child: Container(
            padding: themeController.headerStyle(
                'padding', header['style'][item['key']]['padding']),
            child: header['options'][item['key']]['icon'] == 'wishlist-1'
                ? Badge(
                    backgroundColor: Colors.red,
                    isLabelVisible: _cController.wishlisCount.value > 0,
                    child: themeController.iconByTheme(
                        header['options'][item['key']]['icon'],
                        themeController.headerStyle(
                            'color', header['style'][item['key']]['color'])))
                : item['key'] == 'cart-button'
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
          _controller.selectedCategoryName.value,
          overflow: TextOverflow.ellipsis,
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

  headerNavbar(header) {
    var leftContent = header['layout']['children'].where((element) =>
        element['kind'] == 'search-title' ||
        element['kind'] == 'image' ||
        (element['kind'] == 'link_button' && element['key'] == 'back-button'));
    var rightContent = header['layout']['children'].where((element) =>
        element['kind'] != 'search-title' &&
        element['key'] != 'back-button' &&
        element['kind'] != 'image');
    var centerContent = header['layout']['children']
        .where((element) => element['kind'] == 'input');
    var navbarList = {
      "left": leftContent,
      "center": centerContent,
      "right": rightContent
    };
    print('header ---------> ${header['layout']['children']}');
    return navbarList;
  }
}
