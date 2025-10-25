import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/cart/components/cart_quantity_update_design3.dart';
import 'package:flutter/material.dart';

class CartProductItemContentDesign4 extends StatelessWidget {
  const CartProductItemContentDesign4(
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    sku.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  ),
                  if (selectedOptions != null &&
                      selectedOptions.length > 0) ...[
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
                ])),
            SizedBox(
                height: 20,
                // width: 20,
                child: PopupMenuButton(
                  initialValue: null,
                  padding: EdgeInsets.zero,
                  surfaceTintColor: brightness == Brightness.dark
                      ? Colors.black
                      : kBackground,
                  child: Text('Edit',
                      style: TextStyle(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline)),
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
                      iconColor: Colors.black,
                      buttonColor: Color(0xFFF3F4F6),
                      product: productData,
                      category: category,
                    )),
              Text(
                CommonHelper.currencySymbol() +
                    (sku.price!.sellingPrice * sku.qty).round().toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              ),
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
