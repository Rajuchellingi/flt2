import 'package:black_locust/controller/cart_controller.dart';

import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class CartQuantityUpdate extends StatelessWidget {
  const CartQuantityUpdate(
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
    final brightness = Theme.of(context).brightness;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            icon: const Icon(
              Icons.remove,
              size: 18,
            ),
            onPressed: () {
              _controller.minusCartProduct(sku, product);
            }),
        Container(
          height: getProportionateScreenWidth(30),
          width: getProportionateScreenWidth(35),
          decoration: BoxDecoration(
              color:
                  brightness == Brightness.dark ? Colors.black : Colors.white,
              border: Border.all(width: 1, color: Colors.grey[300]!)),
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              productPack.qty.toString(),
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.add,
              size: 18,
            ),
            onPressed: () {
              _controller.addCartProduct(sku, product, category);
            })
      ],
    );
  }
}
