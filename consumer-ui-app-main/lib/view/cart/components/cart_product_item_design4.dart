// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/cart/components/cart_product_item_content_design4.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/configConstant.dart';

class CartProductItemDesign4 extends StatelessWidget {
  const CartProductItemDesign4(
      {Key? key,
      required this.index,
      required controller,
      required this.isCheckoutPage})
      : _controller = controller,
        super(key: key);
  final index;
  final _controller;
  final isCheckoutPage;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(children: [
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                  color: brightness == Brightness.dark
                      ? Colors.black
                      : Color(0xFFF9F9F9),
                  // borderRadius: BorderRadius.circular(10),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     spreadRadius: 0.5,
                  //     blurRadius: 5,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        // borderRadius: const BorderRadius.only(
                        //     topLeft: Radius.circular(10),
                        //     bottomLeft: Radius.circular(10)),
                        child: GestureDetector(
                            onTap: () {
                              _controller.toProductDetailPage(
                                  _controller.productCart[index].productId);
                            },
                            child: CachedNetworkImage(
                              height: 120,
                              width: 110,
                              imageUrl: _controller
                                          .productCart![index].type ==
                                      "products"
                                  ? _controller.productCart[index].imageUrl +
                                      "&width=100"
                                  : cartPackImageUri +
                                      _controller.productCart[index].imageId +
                                      '/' +
                                      _controller.productCart[index].imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  ErrorImage(),
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Container(
                                child: Center(
                                  child: ImagePlaceholder(),
                                ),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 15),
                    CartProductItemContentDesign4(
                        sku: (_controller.productCart[index].skuIds != null &&
                                _controller.productCart[index].skuIds.length >
                                    0)
                            ? _controller.productCart[index].skuIds[0]
                            : _controller.productCart[index],
                        product: _controller.productCart[index],
                        category: _controller.productCart[index],
                        productData: _controller.productCart[index],
                        isCheckoutPage: isCheckoutPage,
                        controller: _controller,
                        selectedOptions:
                            _controller.productCart[index].selectedOptions),
                  ],
                ),
              ),
              kDefaultHeight(5)
            ]),
          )
        ]));
  }

  Padding buildPadding(childp) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 2),
      child: childp,
    );
  }
}
