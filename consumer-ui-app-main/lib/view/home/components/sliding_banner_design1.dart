import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/carousel_image_slider.dart';
import '../../../config/configConstant.dart';
import '../../../const/constant.dart';
import '../../../model/banner_model.dart';

class SlidingBannerDesign1 extends StatelessWidget {
  SlidingBannerDesign1({
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
    if (bannerSliderList.isEmpty) return SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselImageSlider(
          bannerList: bannerSliderList,
          autoPlay: true,
          press: (data) => _controller.navigateByUrlType({
            "value": data['data'].link,
            'kind': data['data'].kind,
          }),
          imageBaseUri: bannerImageBaseUri,
          height: _themeController.defaultStyle(
            'height',
            design['style']['height'],
          ),
          aspectRatio: _themeController.defaultStyle(
              'aspectRatio', design['style']['aspectRatio']),
          borderRadius: 0,
        ),
        kDefaultHeight(kDefaultPadding / 4),
      ],
    );
  }
}
