import 'package:black_locust/view/product_detail/components/product_detail_collapse_design3.dart';
import 'package:flutter/material.dart';

class ProductDetailDescriptionDesign4 extends StatelessWidget {
  const ProductDetailDescriptionDesign4(
      {required this.product, required this.designBlock});
  final product;
  final designBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            border: const Border(
                bottom: const BorderSide(
                    color: const Color(0xFF979797), width: 0.5))),
        child: Column(children: [
          ProductDetailCollapseDesign3(
            designBlock: designBlock,
            title: (designBlock['source'] != null &&
                    designBlock['source']['title'] != null)
                ? designBlock['source']['title']
                : null,
            description: product.bulletPoints,
          )
        ]));
  }
}
