// ignore_for_file: deprecated_member_use, unused_local_variable, unused_field

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementBarDesign2 extends StatelessWidget {
  const AnnouncementBarDesign2({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;
  static final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var banners = design['source']['lists']
        .where((content) => content['visibility']['hide'] == false)
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
              options: CarouselOptions(
                initialPage: 0,
                height: 32,
                viewportFraction: 1,
                enableInfiniteScroll: banners.length > 1 ? true : false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                for (var banner in banners)
                  Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: SizeConfig.screenWidth,
                          height: 32,
                          alignment: Alignment.center,
                          color: _themeController.defaultStyle(
                              'backgroundColor', banner['backgroundColor']),
                          child: Text(banner['description'] ?? '',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _themeController.defaultStyle(
                                      'color', banner['textColor']))));
                    },
                  )
              ]),
        ],
      ),
    );
  }
}
