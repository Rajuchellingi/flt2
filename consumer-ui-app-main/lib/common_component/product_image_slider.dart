// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  ProductImageSlider(
      {Key? key,
      required this.imageList,
      required this.autoPlay,
      this.aspectRatio = 16 / 9,
      this.borderRadius = 10,
      this.press})
      : super(key: key);

  final imageList;
  final bool autoPlay;
  final double aspectRatio;
  final double borderRadius;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                // height: 200,
                aspectRatio: aspectRatio,
                enlargeFactor: 1,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: imageList.length > 1,
                reverse: false,
                autoPlay: autoPlay,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, page) {}),
            items: [
              for (var element in imageList) ...[
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImageWidget(
                          // image: imageBaseUri + i.id + '/' + i.imageName,
                          placeholderImage: element.url + "&width=100",
                          image: element.url + "&width=500"),
                    ))
              ]
            ])
      ],
    );
  }
}
