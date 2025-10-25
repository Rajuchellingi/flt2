// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailFooterDesign5 extends StatelessWidget {
  ProductDetailFooterDesign5({
    Key? key,
    required controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final design;
  final themeController = Get.find<ThemeController>();

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
                                        design['source']['button-text'] != null)
                                    ? design['source']['button-text']
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
