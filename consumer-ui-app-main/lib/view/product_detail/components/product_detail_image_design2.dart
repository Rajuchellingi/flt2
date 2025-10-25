// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/carousel_image_slider.dart';
import 'package:black_locust/common_component/image_viewer.dart';
import 'package:black_locust/config/configConstant.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/banner_model.dart';

class ProductDetailImageDesign2 extends StatelessWidget {
  const ProductDetailImageDesign2({Key? key, this.tag, required controller})
      : _controller = controller,
        super(key: key);

  final String? tag;
  final _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value &&
              _controller.productPackImage.length == 0
          ? Container()
          : Container(
              height: SizeConfig.screenHeight * 0.57,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(),
              child: new CarouselImageSlider(
                press: (data) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      int imageIndex = data['index'] is MapEntry
                          ? data['index'].key
                          : data['index'];

                      return ImageViewer(
                        imageIndex: imageIndex,
                        gallery: _controller.productPackImage.value,
                      );
                    },
                  );
                },
                bannerList: _controller.productPackImage.value
                    as List<ImageSliderVWModel>,
                autoPlay: false,
                imageBaseUri: singlePackImageUri,
                height: SizeConfig.screenHeight * 0.57,
                borderRadius: 0,
              ),
            ),
    );
  }
}
