import 'package:black_locust/controller/cart_controller.dart';

import 'package:flutter/material.dart';

class CartQuantityUpdateDesign4 extends StatelessWidget {
  const CartQuantityUpdateDesign4(
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
    var brightness = Theme.of(context).brightness;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: brightness == Brightness.dark ? Colors.white : Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 7),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 7),
                    child: const Icon(
                      Icons.add,
                      size: 15,
                    )),
                onTap: () {
                  _controller.addCartProduct(sku, product, category);
                }),
          ],
        ));
  }
}
