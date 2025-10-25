// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign4 extends StatelessWidget {
  ProductDetailTitleDesign4(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var instance = themeController.instance('product');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              // child: Container(
              // width: SizeConfig.screenWidth * 0.80,
              child: Obx(
                () => Text(
                  _controller.product.value.name.toString(),
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor,
                      fontWeight: themeController.defaultStyle(
                          'fontWeight', design['style']['fontWeight']),
                      fontSize: themeController.defaultStyle(
                          'fontSize', design['style']['fontSize'])),
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 1,
                ),
                // ),
              ),
            ),
            // if (design['source']['show-price'] == true) ...[
            //   const SizedBox(width: 10),
            //   Text(
            //     CommonHelper.currencySymbol() +
            //         _controller.product.value.price!.sellingPrice.toString(),
            //     style: TextStyle(
            //         color: brightness == Brightness.dark
            //             ? Colors.white
            //             : kPrimaryTextColor,
            //         fontWeight: themeController.defaultStyle(
            //             'fontWeight', design['style']['fontWeight']),
            //         fontSize: themeController.defaultStyle(
            //             'fontSize', design['style']['fontSize'])),
            //   ),
            // ],
            if (design['source']['show-wishlist'] == true) ...[
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
              const SizedBox(width: 10)
            ],
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
        // if (_controller.product.value.vendor != null)
        //   Text(_controller.product.value.vendor,
        //       style: const TextStyle(color: Colors.grey, fontSize: 13)),
        IntrinsicWidth(
            child: commonReviewController.isLoading.value == false
                ? commonReviewController.ratingsWidget(
                    _controller.product.value.sId,
                    color: kPrimaryColor,
                    emptyHeight: 0.0,
                    iconSize: 17.0,
                    showAverage: false)
                : null),
        if (design['source']['show-price'] == true) ...[
          const SizedBox(height: 5),
          Row(children: [
            if (_controller.product.value.price!.mrp !=
                _controller.product.value.price!.sellingPrice)
              Text(
                CommonHelper.currencySymbol() +
                    _controller.product.value.price!.mrp.toString(),
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor,
                    fontSize: themeController.defaultStyle(
                        'fontSize', design['style']['fontSize'])),
              ),
            SizedBox(width: 10),
            Text(
              CommonHelper.currencySymbol() +
                  _controller.product.value.price!.sellingPrice.toString(),
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontWeight: themeController.defaultStyle(
                      'fontWeight', design['style']['fontWeight']),
                  fontSize: themeController.defaultStyle(
                      'fontSize', design['style']['fontSize'])),
            ),
            if (_controller.product.value.price!.mrp !=
                _controller.product.value.price!.sellingPrice) ...[
              SizedBox(width: 10),
              if (instance['source']['show-discount'] == true &&
                  _controller.product.value.price!.mrp != 0 &&
                  _controller.product.value.price!.mrp != null &&
                  _controller.product.value.price!.mrp !=
                      _controller.product.value.price!.sellingPrice)
                Text(
                  "Save ${calculateSavingsPercentage(_controller.product.value.price!.mrp.toDouble(), _controller.product.value.price!.sellingPrice.toDouble())}%",
                  style: TextStyle(
                      color: Color(0XFFC20000),
                      fontWeight: themeController.defaultStyle(
                          'fontWeight', design['style']['fontWeight']),
                      fontSize: themeController.defaultStyle(
                          'fontSize', design['style']['fontSize'])),
                )
            ]
          ]),
          if (design['source']['price-hint'] != null) ...[
            Text(design['source']['price-hint'],
                style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                ))
          ]
        ]
      ]),
    );
  }

  int calculateSavingsPercentage(double mrp, double sellingPrice) {
    if (mrp <= 0) return 0; // Avoid division by zero
    double saved = mrp - sellingPrice;
    return ((saved / mrp) * 100).round();
  }
}
