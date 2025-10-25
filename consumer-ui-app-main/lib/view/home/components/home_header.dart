// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/common_component/search_header_input.dart';
import 'package:black_locust/common_component/search_header_input_design2.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final themeController = Get.find<ThemeController>();
  final _cController = Get.find<CartCountController>();

  @override
  Widget build(BuildContext context) {
    // final brightness = Theme.of(context).brightness;
    var utoken = GetStorage().read('utoken');
    return Obx(() {
      var header = _controller.template.value['layout']['header'];
      var navbar = headerNavbar(header);
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: header['style']['root']['height'] != null
              ? header['style']['root']['height'].toDouble()
              : 60,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: header['source']['transparent'] == true
                ? Colors.transparent
                : themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (navbar['left'] != null && navbar['left'].length > 0) ...[
                if (navbar['center'] != null &&
                    navbar['center'].length > 0) ...[
                  Row(children: [
                    for (var item in navbar['left']) ...[
                      if (item['kind'] == 'text') ...[
                        if (item['key'] == 'welcome-text') ...[
                          if (utoken != null) ...[
                            titleContainer(header, item)
                          ] else ...[
                            Expanded(child: Container())
                          ]
                        ] else ...[
                          titleContainer(header, item)
                        ]
                      ] else if (item['kind'] == 'image') ...[
                        logoContainer(header, item)
                      ] else if (item['kind'] == 'link_button') ...[
                        iconContainer(header, item)
                      ] else if (item['kind'] == 'input') ...[
                        Expanded(child: searchInputContainer(header, item))
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
                        logoContainer(header, item)
                      ] else if (item['kind'] == 'link_button') ...[
                        iconContainer(header, item)
                      ] else if (item['kind'] == 'input') ...[
                        Expanded(child: searchInputContainer(header, item))
                      ]
                    ]
                  ]))
                ]
              ],
              if (navbar['right'] != null && navbar['right'].length > 0) ...[
                if (navbar['center'] != null &&
                    navbar['center'].length > 0) ...[
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
                        Expanded(child: searchInputContainer(header, item))
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
                        Expanded(child: searchInputContainer(header, item))
                      ]
                    ]
                  ])
                ],
              ]
              // for (var item in header['layout']['children']) ...[
              //   if (item['kind'] == 'text') ...[
              //     if (item['key'] == 'welcome-text') ...[
              //       if (utoken != null) ...[
              //         _buildTitleField(header, item)
              //       ] else ...[
              //         Expanded(child: Container())
              //       ]
              //     ] else ...[
              //       _buildTitleField(header, item)
              //     ],
              //   ] else if (item['kind'] == 'image') ...[
              //     Container(
              //         alignment: Alignment.centerLeft,
              //         height: 50,
              //         child: CachedNetworkImage(
              //             color: (brightness == Brightness.dark &&
              //                     header['options'][item['key']]["image"] !=
              //                         null &&
              //                     header['options'][item['key']]["image"]
              //                         .contains(".png"))
              //                 ? Colors.white
              //                 : null,
              //             errorWidget: (context, url, error) =>
              //                 Icon(Icons.error),
              //             imageUrl: header['options'][item['key']]["image"])),
              //     const Spacer()
              //   ] else if (item['kind'] == 'link_button') ...[
              //     InkWell(
              //         onTap: () {
              //           themeController.navigateByType(
              //               header['options'][item['key']]['screenId'],
              //               link: header['options'][item['key']]['link']);
              //         },
              //         child: Container(
              //             margin: themeController.headerStyle(
              //                 'margin', header['style'][item['key']]['margin']),
              //             decoration: BoxDecoration(
              //               borderRadius: themeController.headerStyle(
              //                   'borderRadius',
              //                   header['style'][item['key']]['borderRadius']),
              //               color: themeController.headerStyle(
              //                   'backgroundColor',
              //                   header['style'][item['key']]
              //                       ['backgroundColor']),
              //             ),
              //             padding: themeController.headerStyle('padding',
              //                 header['style'][item['key']]['padding']),
              //             child: header['options'][item['key']]['icon'] ==
              //                     'wishlist-1'
              //                 ? Badge(
              //                     backgroundColor: Colors.red,
              //                     isLabelVisible:
              //                         _cController.wishlisCount.value > 0,
              //                     child: themeController.iconByTheme(
              //                         header['options'][item['key']]['icon'],
              //                         themeController.headerStyle(
              //                             'color',
              //                             header['style'][item['key']]
              //                                 ['color'])))
              //                 : header['options'][item['key']]['icon'] ==
              //                         'cart-1'
              //                     ? Badge(
              //                         backgroundColor: Colors.red,
              //                         isLabelVisible:
              //                             _cController.cartCount.value > 0,
              //                         child: themeController.iconByTheme(
              //                             header['options'][item['key']]
              //                                 ['icon'],
              //                             themeController.headerStyle(
              //                                 'color',
              //                                 header['style'][item['key']]
              //                                     ['color'])),
              //                       )
              //                     : themeController.iconByTheme(
              //                         header['options'][item['key']]['icon'],
              //                         themeController.headerStyle(
              //                             'color',
              //                             header['style'][item['key']]
              //                                 ['color']))))
              //   ] else if (item['kind'] == 'input') ...[
              //     Expanded(
              //         child: SearchHeaderInput(
              //             header: header,
              //             headerOption: header['options']['search-input'])),
              //   ]
              // ]
            ],
          ));
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

  Widget iconContainer(header, item) {
    return InkWell(
        onTap: () {
          themeController
              .navigateByType(header['options'][item['key']]['screenId']);
        },
        child: Container(
            margin: themeController.headerStyle(
                'margin', header['style'][item['key']]['margin']),
            decoration: BoxDecoration(
              borderRadius: themeController.headerStyle(
                  'borderRadius', header['style'][item['key']]['borderRadius']),
              color: themeController.headerStyle('backgroundColor',
                  header['style'][item['key']]['backgroundColor']),
            ),
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

  Widget titleContainer(header, item) {
    return Expanded(
        child: Container(
            padding: themeController.headerStyle(
                'padding', header['style'][item['key']]['padding']),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                  if (header['options'][item['key']]['subTitleType'] ==
                      'username') ...[
                    // const SizedBox(height: 5),
                    Text(getUserName(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500))
                  ]
                ])));
  }

  Container logoContainer(header, item) {
    final brightness = Theme.of(Get.context!).brightness;
    return Container(
        alignment: themeController
            .alignment(header['style'][item['key']]['alignment']),
        height: 50,
        width: themeController.headerStyle(
            'width', header['style'][item['key']]['width']),
        child: CachedNetworkImage(
            cacheKey: themeController.logo.value,
            color: (brightness == Brightness.dark &&
                    themeController.logo.value != null &&
                    themeController.logo.value.contains('.png'))
                ? Colors.white
                : null,
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: themeController.logo.value));
  }

  // Widget _buildTitleField(header, item) {
  //   return Expanded(
  //       child: Container(
  //           padding: themeController.headerStyle(
  //               'padding', header['style'][item['key']]['padding']),
  //           child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   child: Text(
  //                     header['options'][item['key']]['text'],
  //                     maxLines: header['options'][item['key']]['numberOfLines'],
  //                     style: TextStyle(
  //                         color: themeController.headerStyle(
  //                             'color', header['style'][item['key']]['color']),
  //                         fontWeight: themeController.headerStyle('fontWeight',
  //                             header['style'][item['key']]['fontWeight']),
  //                         fontSize: themeController.headerStyle('fontSize',
  //                             header['style'][item['key']]['fontSize'])),
  //                   ),
  //                 ),
  //                 if (header['options'][item['key']]['subTitleType'] ==
  //                     'username') ...[
  //                   // const SizedBox(height: 5),
  //                   Text(getUserName(),
  //                       style: TextStyle(
  //                           color: Colors.grey,
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w500))
  //                 ]
  //               ])));
  // }

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

  String getUserName() {
    if (_controller.userProfile.value.firstName != null &&
        _controller.userProfile.value.lastName != null) {
      return _controller.userProfile.value.firstName! +
          " " +
          _controller.userProfile.value.lastName!;
    } else {
      return _controller.userProfile.value.firstName ?? '';
    }
  }
}
