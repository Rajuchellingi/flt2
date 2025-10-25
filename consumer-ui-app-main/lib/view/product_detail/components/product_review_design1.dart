import 'package:flutter/material.dart';

class ProductReviewDesign1 extends StatelessWidget {
  const ProductReviewDesign1({required this.controller});
  final controller;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
            onTap: () {
              controller.navigateToReview();
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reviews",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 20.0,
                    ),
                  ],
                ))));
  }
}
