import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPriceDesign2 extends StatelessWidget {
  ProductDetailPriceDesign2(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
