import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/view/cart/components/cart_product_item_content_design2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/configConstant.dart';

class CartProductItemDesign2 extends StatelessWidget {
  const CartProductItemDesign2(
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
    return Container(
        child: Column(children: [
      Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding / 2,
                top: kDefaultPadding / 2,
                right: kDefaultPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getProportionateScreenHeight(150),
                  width: getProportionateScreenWidth(110),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GestureDetector(
                        onTap: () {
                          _controller.toProductDetailPage(
                              _controller.productCart[index].productId);
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              _controller.productCart![index].type == "products"
                                  ? _controller.productCart[index].imageUrl +
                                      "&width=100"
                                  : cartPackImageUri +
                                      _controller.productCart[index].imageId +
                                      '/' +
                                      _controller.productCart[index].imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => ErrorImage(),
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
                CartProductItemContentDesign2(
                  sku: (_controller.productCart[index].skuIds != null &&
                          _controller.productCart[index].skuIds.length > 0)
                      ? _controller.productCart[index].skuIds[0]
                      : _controller.productCart[index],
                  product: _controller.productCart[index],
                  category: _controller.productCart[index],
                  productData: _controller.productCart[index],
                  selectedOptions:
                      _controller.productCart[index].selectedOptions,
                  isCheckoutPage: isCheckoutPage,
                  controller: _controller,
                ),
                if (isCheckoutPage == false) ...[
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _controller.removeNonCustomProuduct(
                          _controller.productCart[index],
                          _controller.productCart[index]);
                    },
                    child: const Icon(Icons.close, size: 20, weight: 10),
                  )
                ]
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
