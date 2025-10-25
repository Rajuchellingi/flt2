import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/cart/components/cart_quantity_update_design3.dart';
import 'package:flutter/material.dart';

class CartProductItemContentDesign3 extends StatelessWidget {
  const CartProductItemContentDesign3(
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
  final productData;
  final isCheckoutPage;
  final sku;
  final selectedOptions;
  final category;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(height: 15),
          Row(children: [
            Expanded(
                child: Text(
              sku.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
            )),
            SizedBox(
                height: 20,
                width: 20,
                child: PopupMenuButton(
                  initialValue: null,
                  padding: EdgeInsets.zero,
                  surfaceTintColor: brightness == Brightness.dark
                      ? Colors.black
                      : kBackground,
                  iconColor: kPrimaryTextColor,
                  color: brightness == Brightness.dark
                      ? Colors.black
                      : kBackground,
                  constraints: BoxConstraints(),
                  onSelected: (item) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'favorites',
                      onTap: () {
                        _controller.addCartToWishList(
                            product.productId.toString(),
                            _controller.getWishListonClick(product.productId));
                      },
                      child: Center(
                          child: Text(
                        _controller.getWishListonClick(product.sId)
                            ? "Remove from favorites"
                            : 'Add to favorites',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor),
                      )),
                    ),
                    PopupMenuDivider(
                      height: 0.1,
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      onTap: () {
                        _controller.removeNonCustomProuduct(product, product);
                      },
                      child: Center(
                          child: Text(
                        'Delete from the list',
                        style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor),
                      )),
                    )
                  ],
                )),
            const SizedBox(width: 10),
          ]),
          if (selectedOptions != null && selectedOptions.length > 0) ...[
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (var option in selectedOptions) ...[
                  IntrinsicWidth(
                      child: Row(children: [
                    Text(
                      option.name + " : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor),
                    ),
                    Text(
                      option.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor),
                    ),
                    const SizedBox(width: 15)
                  ]))
                ]
              ],
            ),
            SizedBox(width: 10)
          ],
          Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sku.price.totalPrice != sku.price.subtotalPrice)
                  Text(
                    CommonHelper.currencySymbol() +
                        (sku.price!.subtotalPrice).round().toString(),
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  ),
                Text(
                  CommonHelper.currencySymbol() +
                      (sku.price!.totalPrice).round().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ),
              ]),
          if (product.discountAllocations != null &&
              product.discountAllocations.isNotEmpty) ...[
            for (var element in product.discountAllocations) ...[
              if (element.title != null && element.title.isNotEmpty) ...[
                Container(
                    child: Text(
                        '${element.title} (${CommonHelper.currencySymbol()}${element.amount})',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor)))
              ]
            ]
          ],
          // Text(
          //   sku.variantName,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w500,
          //     fontSize: 14,
          //   ),
          // ),
          // buildSkuDetails(),
          // SizedBox(height: 5),

          SizedBox(height: 10),
          Row(
            // spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isCheckoutPage == true
                  ? Text(
                      "Total Qty: " + product.qty.toString(),
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  : Expanded(
                      child: CartQuantityUpdateDesign3(
                      controller: _controller,
                      productPack: product,
                      sku: sku,
                      product: productData,
                      category: category,
                    )),
              // Expanded(
              //     child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //       if (sku.price.totalPrice != sku.price.subtotalPrice)
              //         Text(
              //           CommonHelper.currencySymbol() +
              //               (sku.price!.subtotalPrice).round().toString(),
              //           style: TextStyle(
              //               fontSize: 14,
              //               decoration: TextDecoration.lineThrough,
              //               color: brightness == Brightness.dark
              //                   ? Colors.white
              //                   : kPrimaryTextColor),
              //         ),
              //       Text(
              //         CommonHelper.currencySymbol() +
              //             (sku.price!.totalPrice).round().toString(),
              //         style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //             color: brightness == Brightness.dark
              //                 ? Colors.white
              //                 : kPrimaryTextColor),
              //       ),
              //       if (product.discountAllocations != null &&
              //           product.discountAllocations.isNotEmpty) ...[
              //         for (var element in product.discountAllocations) ...[
              //           if (element.title != null &&
              //               element.title.isNotEmpty) ...[
              //             Container(
              //                 child: Text(
              //                     '${element.title} (${CommonHelper.currencySymbol()}${element.amount})',
              //                     textAlign: TextAlign.end,
              //                     style: TextStyle(
              //                         fontSize: 12,
              //                         color: brightness == Brightness.dark
              //                             ? Colors.white
              //                             : kPrimaryTextColor)))
              //           ]
              //         ]
              //       ],
              //     ])),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    ));
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
