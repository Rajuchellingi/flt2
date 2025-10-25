// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionFooterDesign2 extends StatelessWidget {
  CollectionFooterDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var footer = _controller.template.value['layout']['footer'];
    var footerChildren = footer['layout']['children'];
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: SizeConfig.screenWidth,
      color: brightness == Brightness.dark ? Colors.black : Colors.white,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < footerChildren.length; i++) ...[
            Expanded(
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        if (footer['options'][footerChildren[i]['key']]
                                ['screenId'] ==
                            'sort')
                          _controller.openSort();
                        else if (footer['options'][footerChildren[i]['key']]
                                ['screenId'] ==
                            'filter') _controller.openFilter('design1');
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: themeController.iconByTheme(
                                footer['options'][footerChildren[i]['key']]
                                    ['icon'],
                                themeController.defaultStyle(
                                    'color',
                                    footer['style'][footerChildren[i]['key']]
                                        ['color']),
                                size: 20.0),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Text(
                              footer['options'][footerChildren[i]['key']]
                                  ['label'],
                              textAlign: themeController.defaultStyle(
                                  'textAlign',
                                  footer['style'][footerChildren[i]['key']]
                                      ['textAlign']),
                              style: TextStyle(
                                  fontSize: themeController.defaultStyle(
                                      'fontSize',
                                      footer['style'][footerChildren[i]['key']]
                                          ['fontSize']),
                                  fontWeight: themeController.defaultStyle(
                                      'fontWeight',
                                      footer['style'][footerChildren[i]['key']]
                                          ['fontWeight'])),
                            ),
                          ),
                        ],
                      ),
                    ))),
          ]
        ],
      ),
    );
  }

  String getSelectedName(footer, index) {
    var footerChildren = footer['layout']['children'];
    if (footer['options'][footerChildren[index]['key']]['screenId'] == 'sort')
      return _controller.selectedSort.value.name.toString();
    else if (footer['options'][footerChildren[index]['key']]['screenId'] ==
        'filter')
      return _controller.selectedFilter.value.length > 0
          ? "${_controller.selectedFilter.value.length} filters applied"
          : "No filters applied";
    else
      return '';
  }
}
