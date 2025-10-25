// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBlockDesign5 extends StatelessWidget {
  CategoryBlockDesign5({
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
    return Column(children: [
      TabBar(
        tabAlignment:
            menuLists.length <= 3 ? TabAlignment.fill : TabAlignment.center,
        controller: _controller.tabController,
        indicatorColor: kPrimaryColor,
        isScrollable: menuLists.length > 3,
        overlayColor: MaterialStateColor.resolveWith(
          (states) => kPrimaryColor.withOpacity(0.1),
        ),
        indicatorWeight: 3,
        labelColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: [
          for (var element in menuLists) Tab(text: element['title']),
        ],
      ),
      Expanded(
          child: TabBarView(
        controller: _controller.tabController,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          for (var element in menuLists)
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var item in element['lists'])
                        if (item['type'] == 'banner') ...[
                          Container(
                            child: CachedNetworkImage(
                                imageUrl:
                                    _controller.changeImageUrl(item['image']),
                                errorWidget: (context, url, error) =>
                                    ErrorImage(),
                                // height: 100,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                                placeholder: (context, url) => Container(
                                      height: 80,
                                      child: Center(
                                        child: ImagePlaceholder(),
                                      ),
                                    )),
                          )
                        ] else ...[
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              child: InkWell(
                                  onTap: () {
                                    _controller.navigateByUrlType(item['link']);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(item['title'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    fontSize: 16))),
                                        const SizedBox(width: 20),
                                        Container(
                                            width: 170,
                                            height: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          const Radius.circular(
                                                              10),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              10)),
                                              child: CachedNetworkImage(
                                                  imageUrl: _controller
                                                      .changeImageUrl(
                                                          item['image']),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          ErrorImage(),
                                                  // height: 100,
                                                  fit: BoxFit.fitWidth,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        height: 80,
                                                        child: Center(
                                                          child:
                                                              ImagePlaceholder(),
                                                        ),
                                                      )),
                                            )),
                                      ],
                                    ),
                                  )))
                        ]
                    ],
                  ),
                ))
        ],
      )),
    ]);
  }
}
