import 'package:black_locust/controller/cart_controller.dart';

import 'package:flutter/material.dart';

class CartQuantityUpdateDesign2 extends StatelessWidget {
  const CartQuantityUpdateDesign2(
      {Key? key,
      this.tag,
      this.productPack,
      this.sku,
      this.product,
      this.category,
      required controller})
      : _controller = controller,
        super(key: key);
  final String? tag;
  final productPack;
  final sku;
  final product;
  final category;
  final CartController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 2, color: Colors.grey)),
                child: Icon(
                  Icons.remove,
                  size: 15,
                )),
            onTap: () {
              _controller.minusCartProduct(sku, product);
            }),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Text(
            productPack.qty.toString(),
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 2, color: Colors.grey)),
                child: const Icon(
                  Icons.add,
                  size: 15,
                )),
            onTap: () {
              _controller.addCartProduct(sku, product, category);
            }),
      ],
    );
  }
}
