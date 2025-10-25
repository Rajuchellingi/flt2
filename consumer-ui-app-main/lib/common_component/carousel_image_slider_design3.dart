// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: unrelated_type_equality_checks

import 'package:black_locust/model/banner_model.dart';
import 'package:flutter/material.dart';
import '../common_component/cached_network_image.dart';

class CarouselImageSliderDesign3 extends StatelessWidget {
  CarouselImageSliderDesign3(
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
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: RawScrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                thumbColor: Colors.black,
                radius: const Radius.circular(10),
                thickness: 3,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: bannerList.asMap().entries.map((entry) {
                      var index = entry.key;
                      var data = entry.value;
                      return GestureDetector(
                        onTap: () => press({"data": data, "index": index}),
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          height: height,
                          //color: i.sortOrder == 1 ? Colors.amber[200] : Colors.black,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                    }).toList(),
                  ),
                )))
      ],
    );
  }
}
