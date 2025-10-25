import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';

class ProductReviewDesign2 extends StatelessWidget {
  const ProductReviewDesign2({required this.controller});
  final controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GestureDetector(
        onTap: () {
          controller.navigateToReview();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: const BoxDecoration(
              border: const Border(
                bottom: const BorderSide(
                  width: 0.5,
                  color: const Color(0xFF979797),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reviews",
                  style: TextStyle(
                    // fontSize: 16,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right,
                    size: 20.0,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              ],
            )));
  }
}
