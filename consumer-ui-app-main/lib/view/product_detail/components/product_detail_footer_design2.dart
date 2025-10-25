// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_add_to_cart_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailFooterDesign2 extends StatelessWidget {
  ProductDetailFooterDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      var footerChildren = footer['layout']['children'];
      return Container(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 65,
          child: Row(children: [
            for (var element in footerChildren) ...[
              if (element['key'] == 'cart-button') ...[
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          var selectedVariantId =
                              _controller.getSelectedProductVariant();

                          if (_controller.product.value.isOutofstock == false ||
                              selectedVariantId != null)
                            _controller.productAddToCart();
                          else
                            openAddToCart(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: themeController.defaultStyle(
                                    'backgroundColor',
                                    footer['style'][element['key']]
                                        ['backgroundColor']),
                                border: Border.all(
                                    color: brightness == Brightness.dark
                                        ? kPrimaryColor == Colors.black
                                            ? Colors.white
                                            : kPrimaryColor
                                        : kPrimaryColor)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  themeController.iconByTheme(
                                    footer['options'][element['key']]['icon'],
                                    themeController.defaultStyle(
                                        'color',
                                        footer['style'][element['key']]
                                            ['color']),
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                      _controller.product.value.isOutofstock
                                          ? footer['options'][element['key']]
                                              ['label']
                                          : "Notify Me",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _controller
                                                  .product.value.isOutofstock
                                              ? brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black
                                              : Colors.grey,
                                          fontSize: 14))
                                ]))))
              ] else if (element['key'] == 'wishlist-button') ...[
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          _controller.addToWishList(
                              _controller.product.value.sId.toString());
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: brightness == Brightness.dark
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor,
                                border: Border.all(color: kPrimaryColor)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    (_controller.wishlistFlag.value != null &&
                                            _controller.getWishListonClick(
                                                _controller.product.value))
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20,
                                    color: (_controller.wishlistFlag.value !=
                                                null &&
                                            _controller.getWishListonClick(
                                                _controller.product.value))
                                        ? Colors.red
                                        : brightness == Brightness.dark
                                            ? kPrimaryColor == Colors.black
                                                ? Colors.black
                                                : themeController.defaultStyle(
                                                    'color',
                                                    footer['style']
                                                            [element['key']]
                                                        ['color'])
                                            : themeController.defaultStyle(
                                                'color',
                                                footer['style'][element['key']]
                                                    ['color']),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                      (_controller.wishlistFlag.value != null &&
                                              _controller.getWishListonClick(
                                                  _controller.product.value))
                                          ? "Wishlisted"
                                          : footer['options'][element['key']]
                                              ['label'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: brightness == Brightness.dark
                                              ? kPrimaryColor == Colors.black
                                                  ? Colors.black
                                                  : kSecondaryColor
                                              : kSecondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))
                                ]))))
              ]
            ]
          ]));
    });
  }

  openAddToCart(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: const Radius.circular(10),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return ProductDetailAddToCartDeign1(controller: _controller);
        });
  }
}
