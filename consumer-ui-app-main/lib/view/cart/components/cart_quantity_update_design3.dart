// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';

import 'package:flutter/material.dart';

class CartQuantityUpdateDesign3 extends StatelessWidget {
  const CartQuantityUpdateDesign3(
      {Key? key,
      this.tag,
      this.productPack,
      this.sku,
      this.product,
      this.category,
      this.buttonColor = kPrimaryColor,
      this.iconColor = Colors.white,
      required controller})
      : _controller = controller,
        super(key: key);
  final String? tag;
  final productPack;
  final sku;
  final product;
  final category;
  final buttonColor;
  final iconColor;
  final CartController _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.remove,
                  size: 15,
                  color: iconColor,
                )),
            onTap: () {
              _controller.minusCartProduct(sku, product);
            }),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Text(
            productPack.qty.toString(),
            style: TextStyle(
                fontSize: 14,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: 15,
                  color: iconColor,
                )),
            onTap: () {
              _controller.addCartProduct(sku, product, category);
            }),
      ],
    );
  }
}
