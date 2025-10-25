// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_component/cached_network_image.dart';

class CarouselImageSliderDesign4 extends StatefulWidget {
  final List<ImageSliderVWModel> bannerList;
  final String imageBaseUri;
  final String type;
  final double height;
  final double borderRadius;
  final Function press;

  const CarouselImageSliderDesign4({
    Key? key,
    required this.bannerList,
    required this.imageBaseUri,
    this.type = 'banner',
    required this.height,
    this.borderRadius = 10,
    required this.press,
  }) : super(key: key);

  @override
  State<CarouselImageSliderDesign4> createState() =>
      _CarouselImageSliderDesign4State();
}

class _CarouselImageSliderDesign4State
    extends State<CarouselImageSliderDesign4> {
  final _controller = Get.find<CommonController>();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var currentData = widget.bannerList[_currentIndex];

    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              widget.press({"data": currentData, "index": _currentIndex}),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: SizedBox(
              height: widget.height,
              width: double.infinity,
              child: CachedNetworkImageWidget(
                placeholderImage: widget.type == 'product'
                    ? "${currentData.imageName}&width=100"
                    : null,
                image: widget.type == 'product'
                    ? "${currentData.imageName}&width=500"
                    : currentData.imageName,
                fill: BoxFit.contain,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// ✅ Thumbnails for selection
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.bannerList.length,
            itemBuilder: (context, index) {
              var data = widget.bannerList[index];
              bool isSelected = index == _currentIndex;

              return GestureDetector(
                onTap: () {
                  setState(() => _currentIndex = index);
                  _controller.imageSliderPageChanges(index);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade400,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImageWidget(
                      image: widget.type == 'product'
                          ? "${data.imageName}&width=100"
                          : data.imageName,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
