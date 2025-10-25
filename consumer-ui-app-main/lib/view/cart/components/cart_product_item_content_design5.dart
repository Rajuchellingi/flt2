import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/cart/components/cart_quantity_update_design4.dart';
import 'package:flutter/material.dart';

class CartProductItemContentDesign5 extends StatelessWidget {
  const CartProductItemContentDesign5(
      {Key? key,
      required this.product,
      required this.category,
      required this.sku,
      required this.isCheckoutPage,
      required this.productData,
      required this.selectedOptions,
      required controller})
      : _controller = controller,
        super(key: key);

  final _controller;
  final product;
  final selectedOptions;
  final productData;
  final isCheckoutPage;
  final sku;
  final category;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            sku.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (selectedOptions != null && selectedOptions.length > 0) ...[
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (var option in selectedOptions) ...[
                  IntrinsicWidth(
                      child: Row(children: [
                    Text(
                      option.name + " : ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      option.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 15)
                  ]))
                ]
              ],
            ),
            const SizedBox(width: 10)
          ],
          // SizedBox(height: 5),
          // Text(
          //   sku.variantName,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w500,
          //     fontSize: 14,
          //   ),
          // ),
          // buildSkuDetails(),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                CommonHelper.currencySymbol() +
                    " " +
                    sku.price!.sellingPrice.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              if (sku.price!.mrp != 0 &&
                  sku.price!.mrp != null &&
                  sku.price!.mrp != sku.price!.sellingPrice) ...[
                const SizedBox(width: 10),
                Text(
                  CommonHelper.currencySymbol() +
                      " " +
                      sku.price!.mrp.toString(),
                  // (sku.price!.mrp * sku.qty).toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      color: brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.black),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              isCheckoutPage == true
                  ? Text(
                      "Total Qty: " + product.qty.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )
                  : CartQuantityUpdateDesign4(
                      controller: _controller,
                      productPack: product,
                      sku: sku,
                      product: productData,
                      category: category,
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
