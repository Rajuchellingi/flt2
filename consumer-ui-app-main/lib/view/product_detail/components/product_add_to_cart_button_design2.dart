// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class ProductAddToCartButtonDesign2 extends StatelessWidget {
  const ProductAddToCartButtonDesign2(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      _controller.productAddToCart(context, _controller);
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              const Icon(
                                Icons.add_shopping_cart,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                              Text(
                                (design['source'] != null &&
                                        design['source']['buttonName'] != null)
                                    ? design['source']['buttonName']
                                    : _controller.toBagButtonText.value,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(16)),
                              ),
                            ])))),
          ],
        ),
      ),
    );
  }
}
