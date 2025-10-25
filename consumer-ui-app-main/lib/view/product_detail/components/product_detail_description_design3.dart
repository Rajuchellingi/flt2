import 'package:black_locust/view/product_detail/components/product_detail_collapse_design2.dart';
import 'package:flutter/material.dart';

class ProductDetailDescriptionDesign3 extends StatelessWidget {
  const ProductDetailDescriptionDesign3(
      {required this.product, required this.designBlock});
  final product;
  final designBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(top: const BorderSide(color: const Color(0xFF979797)))),
        child: Column(children: [
          ProductDetailCollapseDesign2(
            designBlock: designBlock,
            title: "Details",
            description: product.bulletPoints,
          )
        ]));
  }
}
