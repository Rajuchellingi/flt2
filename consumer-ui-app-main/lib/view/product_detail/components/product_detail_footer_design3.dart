// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_add_to_cart_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailFooterDesign3 extends StatelessWidget {
  ProductDetailFooterDesign3({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();
  final SizeChartController sizeChartController =
      Get.find<SizeChartController>();
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      var footerChildren = footer['layout']['children'];
      return Container(
          color: brightness == Brightness.dark ? Colors.black : kBackground,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          height: 70,
          child: Row(children: [
            for (var element in footerChildren) ...[
              if (element['key'] == 'cart-button') ...[
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (_controller.product.value.isOutofstock == false)
                            _controller.productAddToCart();
                          else
                            openAddToCart(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: kPrimaryColor)),
                            child: Text(
                                _controller.product.value.isOutofstock
                                    ? footer['options'][element['key']]['label']
                                    : "Notify Me",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14)))))
              ] else if (element['key'] == 'wishlist-button') ...[
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          _controller.addToWishList(
                              _controller.product.value.sId.toString());
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: kPrimaryColor)),
                            child: Text(
                                (_controller.wishlistFlag.value != null &&
                                        _controller.getWishListonClick(
                                            _controller.product.value))
                                    ? "Wishlisted"
                                    : footer['options'][element['key']]
                                        ['label'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)))))
              ]
            ]
          ]));
    });
  }

  openAddToCart(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: const Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return ProductDetailAddToCartDeign2(controller: _controller);
        });
  }
}
