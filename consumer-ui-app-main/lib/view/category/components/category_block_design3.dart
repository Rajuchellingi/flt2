// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, unused_local_variable

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CateogryBlockDesign3 extends StatelessWidget {
  CateogryBlockDesign3({
    Key? key,
    required controller,
    required this.menuLists,
  })  : _controller = controller,
        super(key: key);

  final List<dynamic> menuLists;
  final CategoryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    int count = getCount();
    return Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 30),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: (menuLists.length / count).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * count;
                    int endIndex = startIndex + count;
                    if (endIndex > menuLists.length)
                      endIndex = menuLists.length;
                    var rowItems = menuLists.sublist(startIndex, endIndex);
                    return Obx(
                        () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      for (var row in rowItems)
                                        Container(
                                          width:
                                              (SizeConfig.screenWidth - 10) / 2,
                                          child: MenuItemWidget(
                                              row, index, _controller),
                                        )
                                    ],
                                  ),
                                  index ==
                                          _controller.selectedDesign3Index.value
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          padding: const EdgeInsets.all(15),
                                          width: SizeConfig.screenWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Column(children: [
                                            for (var element in _controller
                                                .selectedDesign3Menu
                                                .value['lists'])
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 8, 10, 8),
                                                  child: InkWell(
                                                      onTap: () {
                                                        _controller
                                                            .navigateByUrlType(
                                                                element[
                                                                    'link']);
                                                      },
                                                      child: Row(children: [
                                                        if (element['image'] !=
                                                                null &&
                                                            element['image']
                                                                .isNotEmpty)
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child: CachedNetworkImage(
                                                                      imageUrl: _controller.changeImageUrl(element['image']),
                                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                                      height: 40,
                                                                      cacheKey: _controller.changeImageUrl(element['image']),
                                                                      fadeInDuration: Duration.zero,
                                                                      fadeOutDuration: Duration.zero,
                                                                      memCacheWidth: (SizeConfig.screenWidth).round() * 3,
                                                                      fit: BoxFit.fitWidth,
                                                                      alignment: Alignment.topCenter,
                                                                      placeholder: (context, url) => Container(
                                                                            height:
                                                                                100,
                                                                            child:
                                                                                Center(
                                                                              child: ImagePlaceholder(),
                                                                            ),
                                                                          )))),
                                                        Text(
                                                            element[
                                                                    'title']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color:
                                                                    kPrimaryTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14))
                                                      ])))
                                          ]))
                                      : Container(),
                                ]));
                  })),
        ]));
  }

  Container getListLevel2(context, menu) {
    return Container(
        child: InkWell(
            child: Text(menu['title'], style: const TextStyle(fontSize: 14)),
            onTap: () {
              _controller.navigateByUrlType(menu['link']);
            }));
  }

  getCount() {
    var width = SizeConfig.screenWidth;
    var count = 2;
    if (width > 700) {
      count = 3;
    } else {
      count = 2;
    }
    return 2;
  }
}

class MenuItemWidget extends StatelessWidget {
  final menuItem;
  final index;
  final CategoryController _controller;

  MenuItemWidget(this.menuItem, this.index, this._controller);

  @override
  Widget build(BuildContext context) {
    // print("row menuItem ${menuItem.toJson()}");
    return Obx(() => Container(
        margin: EdgeInsets.only(
            top: _controller.selectedDesign3Menu == menuItem ? 20 : 0),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        // width: getWidth(),
        child: InkWell(
            onTap: () {
              _controller.clickDesign3Menu(index, menuItem);
            },
            child: Column(children: [
              Stack(children: [
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        border: _controller.selectedDesign3Menu == menuItem
                            ? Border.all(width: 2, color: kPrimaryColor)
                            : null,
                        borderRadius: BorderRadius.circular(9)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: CachedNetworkImage(
                          imageUrl:
                              _controller.changeImageUrl(menuItem['image']),
                          errorWidget: (context, url, error) => ErrorImage(),
                          // Icon(Icons.error),
                          // height: 100,
                          cacheKey:
                              _controller.changeImageUrl(menuItem['image']),
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          memCacheWidth: (SizeConfig.screenWidth).round() * 3,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) => Container(
                                height: 150,
                                child: Center(
                                  child: ImagePlaceholder(),
                                ),
                              )),
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7)),
                        ),
                        // width: getWidth(),
                        child: Text(menuItem['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13))))
              ]),
            ]))));
  }
}
