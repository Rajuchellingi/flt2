// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/theme_controller.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign3 extends StatelessWidget {
  ProductDetailTitleDesign3(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: SizeConfig.screenWidth * 0.80,
              child: Obx(
                () => Text(
                  _controller.product.value.name.toString(),
                  style: TextStyle(
                      color: themeController.defaultStyle(
                          'color', design['style']['color']),
                      fontWeight: themeController.defaultStyle(
                          'fontWeight', design['style']['fontWeight']),
                      fontSize: themeController.defaultStyle(
                          'fontSize', design['style']['fontSize'])),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          if (design['source']['show-wishlist'] == true)
            InkWell(
              onTap: () {
                _controller.addToWishList(
                    _controller.product.value.sId, _controller.product.value);
              },
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    _controller.product.value.isWishlist == true
                        ? Icons.favorite_sharp
                        : Icons.favorite_border_outlined,
                    color: _controller.product.value.isWishlist == true
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
          if (design['source']['show-share'] == true)
            InkWell(
              onTap: () {
                _controller.shareImageFromUrl();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.ios_share_outlined,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
