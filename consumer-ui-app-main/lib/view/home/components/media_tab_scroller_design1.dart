// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/vertical_media_scroller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaTabScrollerDesign1 extends StatelessWidget {
  MediaTabScrollerDesign1({Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final themeController = Get.find<ThemeController>();
  final commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    var header = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['header']
        : null;
    var tabs = tabList();
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              SizedBox(
                  height: (header != null &&
                          header.isNotEmpty &&
                          header['source']['transparent'] == true)
                      ? SizeConfig.screenHeight
                      : SizeConfig.screenHeight - 50,
                  child: TabBarView(
                    controller: _controller.tabController,
                    children: [
                      for (var element in tabs) ...[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new VerticalMediaScroller(
                              design: design,
                              controller: _controller,
                              bannerList: mediaList(element['lists']),
                              press: (data) {
                                _controller.navigateByUrlType(data);
                              },
                              height: (header != null &&
                                      header.isNotEmpty &&
                                      header['source']['transparent'] == true)
                                  ? SizeConfig.screenHeight
                                  : SizeConfig.screenHeight - 50,
                            ),
                          ],
                        )
                      ]
                    ],
                  )),
              Positioned(
                  top: (header != null &&
                          header.isNotEmpty &&
                          header['source']['transparent'] == true)
                      ? 100
                      : 60,
                  left: null,
                  right: null,
                  child: Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (design['source']['image'] != null) ...[
                              Container(
                                  child: CachedNetworkImage(
                                imageUrl: _controller.changeImageUrl(
                                    design['source']['image'],
                                    design['componentId']),
                                height: 50,
                                filterQuality: FilterQuality.low,
                                color: titleColor(
                                    _controller.currentTabIndex.value),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )),
                              SizedBox(height: 15)
                            ],
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (var i = 0; i < tabs.length; i++) ...[
                                    if (tabs[i]['title'] != null)
                                      GestureDetector(
                                          onTap: () {
                                            _controller.tabController
                                                .animateTo(i);
                                          },
                                          child: Text(tabs[i]['title'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: titleColor(_controller
                                                      .currentTabIndex.value),
                                                  fontWeight: i ==
                                                          _controller
                                                              .currentTabIndex
                                                              .value
                                                      ? FontWeight.bold
                                                      : FontWeight.normal)))
                                  ]
                                ])
                          ])))
            ])
          ],
        ));
  }

  tabList() {
    var data = design['source']['lists'];
    var tabs = data
        .where((element) => element['visibility']['hide'] == false)
        .toList();
    return tabs;
  }

  Color titleColor(currentTab) {
    var tabs = tabList();
    var data = tabs;
    var tabData = data[currentTab];
    var imageData =
        tabData['lists'][commonController.imageSliderCurrentPageIndex.value];
    if (imageData['titleColor'] != null)
      return imageData['titleColor'] == 'black' ? Colors.black : Colors.white;
    else
      return Colors.black;
  }

  mediaList(lists) {
    var bannerSliderList = [];
    lists.forEach((element) {
      if (element['visibility']['hide'] == false) {
        var imageList = {
          "type": element['type'],
          "image": _controller.changeImageUrl(
              element['image'], design['componentId']),
          "video": element['video'],
          "link": element['link'],
        };
        bannerSliderList.add(imageList);
      }
    });
    return bannerSliderList;
  }
}
