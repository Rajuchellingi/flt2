// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/carousel_image_slider_design4.dart';
import 'package:black_locust/common_component/image_viewer.dart';
import 'package:black_locust/config/configConstant.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/banner_model.dart';

class ProductDetailImageDesign6 extends StatelessWidget {
  const ProductDetailImageDesign6({Key? key, this.tag, required controller})
      : _controller = controller,
        super(key: key);

  final String? tag;
  final _controller;

  @override
  Widget build(BuildContext context) {
    // print("hlooooooooooooooooo");
    // print(
    //     "_controller.productPackImage.value ${_controller.productPackImage.value.toString()}");

    // print(
    //     "_controller.productPackImage.value ${_controller.productPackImage.value.map((e) => e.toJson()).toList()}");
    return Obx(
      () => _controller.isLoading.value &&
              _controller.productPackImage.length == 0
          ? Container()
          : Container(
              height: SizeConfig.screenHeight * 0.70,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(),
              child: new CarouselImageSliderDesign4(
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
                // autoPlay: false,
                imageBaseUri: singlePackImageUri,
                height: SizeConfig.screenHeight * 0.57,
                borderRadius: 0,
              ),
            ),
    );
  }
}
