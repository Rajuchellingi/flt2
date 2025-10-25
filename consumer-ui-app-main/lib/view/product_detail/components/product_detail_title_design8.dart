// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailTitleDesign8 extends StatelessWidget {
  ProductDetailTitleDesign8(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
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
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 1,
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
        if (design['source']['show-price'] == true) ...[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              children: [
                Text(
                  CommonHelper.currencySymbol() +
                      " " +
                      _controller.product.value.price!.sellingPrice.toString(),
                  style: TextStyle(
                    fontWeight: themeController.defaultStyle(
                        'fontWeight', design['style']['fontWeight']),
                    fontSize: themeController.defaultStyle(
                        'fontSize', design['style']['fontSize']),
                  ),
                ),
                if (_controller.product.value.price!.mrp != 0 &&
                    _controller.product.value.price!.mrp != null &&
                    _controller.product.value.price!.mrp !=
                        _controller.product.value.price!.sellingPrice) ...[
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        CommonHelper.currencySymbol() +
                            " " +
                            _controller.product.value.price!.mrp.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: themeController.defaultStyle(
                                'fontWeight', design['style']['fontWeight']),
                            fontSize: themeController.defaultStyle(
                                'fontSize', design['style']['fontSize']),
                            decoration: TextDecoration.lineThrough),
                      )),
                  const SizedBox(width: 10),
                  discountValue()
                ],
              ],
            ),
          )
        ]
      ]),
    );
  }

  Widget discountValue() {
    var product = _controller.product.value;
    if (product.price?.mrp != 0 &&
        product.price?.mrp != null &&
        product.price?.mrp != product.price?.sellingPrice) {
      var discountAmount =
          ((product.price!.mrp! - product.price!.sellingPrice!) /
                  product.price!.mrp!) *
              100;
      var discount = double.parse(discountAmount.toStringAsFixed(2)).round();
      if (discount > 0) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
            child: Text("${discount}% off",
                style: const TextStyle(color: kSecondaryColor)));
      }
    }
    return SizedBox.shrink();
  }
}
