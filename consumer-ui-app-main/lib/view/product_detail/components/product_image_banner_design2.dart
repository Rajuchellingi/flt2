import 'package:flutter/material.dart';

class ProductImageBannerDesign2 extends StatelessWidget {
  const ProductImageBannerDesign2({Key? key, required this.design})
      : super(key: key);

  final design;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Image.network(
          design['source']['image'],
          fit: BoxFit.cover,
        ));
  }
}
