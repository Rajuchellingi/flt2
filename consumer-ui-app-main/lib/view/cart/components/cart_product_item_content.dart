import 'package:black_locust/common_component/circle_icon_button.dart';
import 'package:black_locust/view/cart/components/cart_quantity_update.dart';
import 'package:flutter/material.dart';
import '../../../const/constant.dart';
import '../../../helper/common_helper.dart';

class CartProductItemContent extends StatelessWidget {
  const CartProductItemContent(
      {Key? key,
      required this.product,
      required this.category,
      required this.sku,
      required this.isCheckoutPage,
      required this.productData,
      required controller})
      : _controller = controller,
        super(key: key);

  final _controller;
  final product;
  final productData;
  final isCheckoutPage;
  final sku;
  final category;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sku.productName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            sku.variantName,
            style: const TextStyle(
              color: const Color.fromARGB(255, 108, 108, 108),
              fontSize: 14,
            ),
          ),
          // buildSkuDetails(),
          const SizedBox(height: 5),
          Row(
            children: [
              if (sku.price!.mrp != 0 &&
                  sku.price!.mrp != null &&
                  sku.price!.mrp != sku.price!.sellingPrice)
                Text(
                  CommonHelper.currencySymbol() +
                      (sku.price!.mrp * sku.qty).toStringAsFixed(2),
                  // (sku.price!.mrp * sku.qty).toString(),
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 14),
                ),
              const SizedBox(width: 10),
              Text(
                CommonHelper.currencySymbol() +
                    (sku.price!.sellingPrice * sku.qty).toStringAsFixed(2),
                // sku.price!.totalPrice.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              isCheckoutPage == true
                  ? Text(
                      "Total Qty: " + product.qty.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )
                  : Row(children: [
                      const Text("Qty : "),
                      CartQuantityUpdate(
                        controller: _controller,
                        productPack: product,
                        sku: sku,
                        product: productData,
                        category: category,
                      )
                    ]),
              if (isCheckoutPage == false)
                CircleIconButton(
                  color: kPrimaryColor,
                  icon: Icons.delete_outline_outlined,
                  height: 35,
                  width: 35,
                  onPressed: () {
                    _controller.removeNonCustomProuduct(product, productData);
                  },
                )
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  // Column buildSkuDetails() {

  Column buildSkuDetails() {
    List<Widget> items = [];
    for (var sku in product.skuIds) {
      for (var attr in sku.attribute) {
        items.add(Text(attr.fieldName + " : " + attr.fieldValue));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  getPieces(product) {
    if (product != null) {
      return product.quantity * product.piece;
    }
  }
}
