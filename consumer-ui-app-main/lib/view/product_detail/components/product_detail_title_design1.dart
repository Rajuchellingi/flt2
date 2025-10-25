import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign1 extends StatelessWidget {
  ProductDetailTitleDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Obx(() => Column(children: [
              Text(
                _controller.product.value.name.toString(),
                textAlign: themeController.defaultStyle(
                    'textAlign', design['style']['textAlign']),
                style: TextStyle(
                  color: themeController.defaultStyle(
                      'color', design['style']['color']),
                  fontWeight: themeController.defaultStyle(
                      'fontWeight', design['style']['fontWeight']),
                  fontSize: themeController.defaultStyle(
                      'fontSize', design['style']['fontSize']),
                ),
              ),
              Container(
                  child: commonReviewController.isLoading.value == false
                      ? commonReviewController.ratingsWidget(
                          _controller.product.value.sId,
                          iconSize: 20.0,
                          fontSize: 14.0)
                      : null)
            ])),
      ),
    );
  }
}
