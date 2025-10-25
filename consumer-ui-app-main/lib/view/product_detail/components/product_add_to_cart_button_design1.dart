// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class ProductAddToCartDesign1 extends StatelessWidget {
  const ProductAddToCartDesign1(
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
            kDefaultWidth(5),
            Expanded(
              child: SizedBox(
                  height: getProportionateScreenHeight(42),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        _controller.productAddToCart(context, _controller);
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                        size: 18,
                      ),
                      label: Text(
                        (design['source'] != null &&
                                design['source']['buttonName'] != null)
                            ? design['source']['buttonName']
                            : _controller.toBagButtonText.value,
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor: kPrimaryColor.withOpacity(0.5),
                          foregroundColor: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
