// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign5 extends StatelessWidget {
  ProductDetailTitleDesign5(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    var discount = calculateDiscount(_controller.product.value.price.mrp,
        _controller.product.value.price.sellingPrice);
    final brightness = Theme.of(context).brightness;
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
          Row(
            children: [
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
              if (_controller.product.value.price.mrp != 0 &&
                  _controller.product.value.price.mrp != null &&
                  _controller.product.value.price.mrp !=
                      _controller.product.value.price.sellingPrice) ...[
                const SizedBox(width: 10),
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
                )
              ],
              if (discount > 0) ...[
                const SizedBox(width: 10),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text('-${discount.toStringAsFixed(2)}%',
                        style: const TextStyle(color: Color(0xFFDC2626))))
              ]
            ],
          ),
        ]
      ]),
    );
  }

  calculateDiscount(mrp, sellingPrice) {
    if (mrp == 0) return 0;
    return ((mrp - sellingPrice) / mrp) * 100;
  }
}
