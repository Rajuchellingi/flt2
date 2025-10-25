import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPriceDesign1 extends StatelessWidget {
  ProductDetailPriceDesign1(
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
          if (_controller.product.value.price!.mrp != 0 &&
              _controller.product.value.price!.mrp != null &&
              _controller.product.value.price!.mrp !=
                  _controller.product.value.price!.sellingPrice) ...[
            Container(
                // margin: EdgeInsets.only(right: 10),
                child: Text(
              "Rs. " + _controller.product.value.price!.mrp.toString(),
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: themeController.defaultStyle(
                      'fontWeight', design['style']['fontWeight']),
                  fontSize: themeController.defaultStyle(
                      'fontSize', design['style']['fontSize']),
                  decoration: TextDecoration.lineThrough),
            )),
            const SizedBox(width: 10),
          ],
          Text(
            'Rs. ' + _controller.product.value.price!.sellingPrice.toString(),
            style: TextStyle(
              color: const Color(0xFFB40A0A),
              fontWeight: themeController.defaultStyle(
                  'fontWeight', design['style']['fontWeight']),
              fontSize: themeController.defaultStyle(
                  'fontSize', design['style']['fontSize']),
            ),
          ),
        ],
      ),
    );
  }
}
