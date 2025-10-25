// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/media_tab_video_player.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../common_component/cached_network_image.dart';

class VerticalMediaScroller extends StatelessWidget {
  final commonController = Get.find<CommonController>();
  final themeController = Get.find<ThemeController>();
  VerticalMediaScroller(
      {Key? key,
      required this.bannerList,
      required this.height,
      required this.design,
      required controller,
      required this.press})
      : _controller = controller,
        super(key: key);

  final bannerList;
  final design;
  final double height;
  final Function press;
  final dynamic _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
        onVerticalDragUpdate: _controller.isReachTop.value
            ? (details) {
                if (details.primaryDelta! > 0) {
                  _controller.changeByBottomToTopDrag();
                }
                if (details.primaryDelta! < 0) {
                  _controller.changeByTopToBottomDrag();
                }
              }
            : null,
        child: Stack(
          children: [
            CarouselSlider(
                carouselController: _controller.carouselController,
                disableGesture: false,
                options: CarouselOptions(
                    height: height,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    onScrolled: (value) {
                      var total = (bannerList.length - 1).toDouble();
                      if (total == value) {
                        _controller.changeScroll(false);
                      } else if (value == 0.0 && total > 0.0) {
                        _controller.changeScroll(false);
                        _controller.changeScrollByFirstBanner(false);
                      }
                    },
                    reverse: false,
                    autoPlay: false,
                    pageSnapping: true,
                    padEnds: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.vertical,
                    scrollPhysics: _controller.isScroll.value
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    onPageChanged: (index, page) {
                      _controller.changeScroll(true);
                      _controller.changeScrollByFirstBanner(true);
                      commonController.imageSliderPageChanges(index);
                    }),
                items: [
                  for (var data in bannerList) ...[
                    Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onVerticalDragStart: null,
                          onTap: () => press(data['link']),
                          child: Container(
                            height: height,
                            width: MediaQuery.of(context).size.width,
                            child: data['type'] == 'video'
                                ? AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: MediaTabVideoPlayer(
                                      videoLink: data['video'],
                                    ))
                                : CachedNetworkImageWidget(
                                    fill: BoxFit.cover,
                                    image: _controller.changeImageUrl(
                                        data['image'], design['componentId'])),
                          ),
                        );
                      },
                    )
                  ]
                ]),
            Positioned.fill(
              right: 15,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < bannerList.length; i++) ...[
                        GestureDetector(
                            onTap: () => {},
                            child: Obx(
                              () => Container(
                                width: 4.0,
                                height: commonController
                                            .imageSliderCurrentPageIndex ==
                                        i
                                    ? 15.0
                                    : 4.0,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    // shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(commonController
                                                    .imageSliderCurrentPageIndex ==
                                                i
                                            ? 1
                                            : 0.5)),
                              ),
                            ))
                      ]
                    ]),
              ),
            )
          ],
        )));
  }
}
