// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/configConstant.dart';
import '../../../model/banner_model.dart';

class SlidingBannerDesign2 extends StatelessWidget {
  SlidingBannerDesign2({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;
  final ThemeController _themeController = Get.find<ThemeController>();

  List<ImageSliderVWModel> _buildBannerList() {
    final List<ImageSliderVWModel> bannerSliderList = [];
    final lists = design['source']['lists'] as List;

    for (final element in lists) {
      if (element['visibility']['hide'] == false) {
        final image = _controller.changeImageUrl(
          element['image'],
          design['componentId'],
        );
        final link = element['link']?['value'];
        final kind = element['link']?['kind'];

        bannerSliderList.add(
          ImageSliderVWModel(
            element['title'],
            image,
            link,
            kind,
            element['title'],
          ),
        );
      }
    }
    return bannerSliderList;
  }

  @override
  Widget build(BuildContext context) {
    final bannerSliderList = _buildBannerList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SlidingBannerImage(
                  bannerList: bannerSliderList,
                  autoPlay: true,
                  press: (data) => _controller.navigateByUrlType({
                    "value": data['data'].link,
                    'kind': data['data'].kind,
                  }),
                  imageBaseUri: bannerImageBaseUri,
                  height: _themeController.defaultStyle(
                      'height', design['style']['height']),
                  aspectRatio: _themeController.defaultStyle(
                      'aspectRatio', design['style']['aspectRatio']),
                  borderRadius: 15,
                ))),
      ],
    );
  }
}

class SlidingBannerImage extends StatelessWidget {
  final _controller = Get.find<CommonController>();
  SlidingBannerImage(
      {Key? key,
      required this.bannerList,
      required this.autoPlay,
      required this.imageBaseUri,
      this.type = 'banner',
      this.aspectRatio = 16 / 9,
      required this.height,
      this.borderRadius = 10,
      required this.press})
      : super(key: key);

  final List<ImageSliderVWModel> bannerList;
  final bool autoPlay;
  final String imageBaseUri;
  final String type;
  final double height;
  final double aspectRatio;
  final double borderRadius;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              // height: height - 60,
              aspectRatio: aspectRatio,
              enlargeFactor: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: bannerList.length > 1,
              reverse: false,
              autoPlay: autoPlay,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, page) {
                autoPlay
                    ? _controller.imageCarouselPageChanges(index)
                    : _controller.imageSliderPageChanges(index);
              }),
          items: bannerList.asMap().entries.map((entry) {
            var index = entry.key;
            var data = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => press({"data": data, "index": index}),
                  child: Container(
                    //color: i.sortOrder == 1 ? Colors.amber[200] : Colors.black,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImageWidget(
                        // image: imageBaseUri + i.id + '/' + i.imageName,
                        placeholderImage: type == 'product'
                            ? data.imageName + "&width=100"
                            : null,
                        image: type == 'product'
                            ? data.imageName + "&width=500"
                            : data.imageName,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        if (bannerList.length > 1) ...[
          const SizedBox(height: 10),
          Container(
            // height: 50,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerList.asMap().entries.map((entry) {
                return GestureDetector(
                    onTap: () => {},
                    child: Obx(
                      () => Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                            border: (autoPlay
                                        ? _controller
                                            .imageCarouselCurrentPageIndex
                                        : _controller
                                            .imageSliderCurrentPageIndex) ==
                                    entry.key
                                ? Border.all(color: Colors.grey)
                                : null,
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.grey[800]!)
                                .withOpacity((autoPlay
                                            ? _controller
                                                .imageCarouselCurrentPageIndex
                                            : _controller
                                                .imageSliderCurrentPageIndex) ==
                                        entry.key
                                    ? 0.0
                                    : 0.4)),
                      ),
                    ));
              }).toList(),
            ),
          )
        ],
      ],
    );
  }
}
