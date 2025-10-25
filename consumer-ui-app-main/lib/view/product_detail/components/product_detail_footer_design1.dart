// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailFooterDesign1 extends StatelessWidget {
  ProductDetailFooterDesign1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: SizeConfig.screenWidth - 20,
        height: 75,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffffffff)),
          color: brightness == Brightness.dark
              ? Colors.black
              : const Color(0xffffffff),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 203, 203, 203).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_controller.product.value.price!.mrp != 0 &&
                        _controller.product.value.price!.mrp != null &&
                        _controller.product.value.price!.mrp !=
                            _controller.product.value.price!.sellingPrice)
                      Container(
                          // margin: EdgeInsets.only(right: 10),
                          child: Text(
                        CommonHelper.currencySymbol() +
                            _controller.product.value.price!.mrp.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough),
                      )),
                    const SizedBox(width: 5),
                    Text(
                      'Rs. ' +
                          _controller.product.value.price!.sellingPrice
                              .toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.productAddToCart();
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      _controller.product.value.isOutofstock
                          ? 'Add to Cart'
                          : "Notify Me",
                      style: const TextStyle(color: kSecondaryColor),
                    ),
                  ),
                ),
              ),
              if (footer['source']['show-wishlist'] == true)
                Obx(() => Container(
                      margin: const EdgeInsets.all(2),
                      width: 30,
                      height: 30,
                      child: IconButton(
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller
                                .getWishListonClick(_controller.product.value)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 20,
                        color: _controller
                                .getWishListonClick(_controller.product.value)
                            ? Colors.red
                            : kPrimaryColor,
                        onPressed: () {
                          _controller.addToWishList(
                              _controller.product.value.sId.toString());
                        },
                      ),
                    )),
            ],
          ),
        ),
      );
    });
  }
}
