// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../common_component/cached_network_image.dart';

class CarouselImageSliderDesign2 extends StatelessWidget {
  final _controller = Get.find<CommonController>();
  CarouselImageSliderDesign2(
      {Key? key,
      required this.bannerList,
      required this.autoPlay,
      required this.imageBaseUri,
      this.type = 'banner',
      required this.height,
      this.borderRadius = 10,
      required this.press})
      : super(key: key);

  final List<ImageSliderVWModel> bannerList;
  final bool autoPlay;
  final String imageBaseUri;
  final String type;
  final double height;
  final double borderRadius;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: height - 60,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
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
                            ? data.imageName + "&width=700"
                            : data.imageName,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
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
                      width: 5.0,
                      height: 5.0,
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
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
                                  ? 0.9
                                  : 0.4)),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
