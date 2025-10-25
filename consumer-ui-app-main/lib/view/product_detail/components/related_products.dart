// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/product_detail_v1_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelatedProductsWidget extends StatelessWidget {
  const RelatedProductsWidget({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final ProductDetailV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20), // 20px padding
              child: const Text(
                "Related Products",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      for (var element in _controller.relatedProducts.value)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ItemCard(
                            controller: _controller,
                            product: element,
                          ),
                        )
                    ],
                  )),
            ),
          ],
        ));
  }
}

class ItemCard extends StatelessWidget {
  final dynamic product;

  const ItemCard({Key? key, this.product, required controller})
      : _controller = controller,
        super(key: key);

  final ProductDetailV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/productDetail',
            preventDuplicates: false, arguments: product);
      },
      child: // Obx(
          // () =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Container(
                  // width: SizeConfig.screenWidth / 2.8,
                  width: (SizeConfig.screenWidth / 2.2) - 10,
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //       left: BorderSide(width: 1.0, color: Colors.grey)),
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: product.images.imageName,
                    fit: BoxFit.cover,
                    width: (SizeConfig.screenWidth / 2.2) - 10,
                    height: SizeConfig.screenWidth / 2,
                  ),
                ),
                product.isOutofstock == false
                    ? Positioned(
                        //top: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: SizeConfig.screenWidth / 2,
                            height: 30,
                            child: const Center(
                              child: const Text(
                                "OUT OF STOCK",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ),
                      )
                    : Container(),
                if (product.showWishlist)
                  Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          _controller.addToWishList(product.sId, product);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //   color: Colors.white.withOpacity(0.5),
                          //   borderRadius: BorderRadius.circular(50),
                          // ),
                          child: Icon(
                            product.isWishlist == true
                                ? Icons.favorite_sharp
                                : Icons.favorite_border_outlined,
                            color: product.isWishlist == true
                                ? Colors.red
                                : kSecondaryColor,
                            size: 20,
                          ),
                        ),
                      )),
                // if (product.ribbon != null)
                //   Positioned(
                //     top: 2,
                //     left: 2,
                //     child: Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                //       decoration: BoxDecoration(
                //         color: Color(int.parse(
                //             product.ribbon.colorCode!.replaceAll('#', '0xff'))),
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           bottomRight: Radius.circular(10),
                //         ),
                //       ),
                //       child: Text(
                //         product.ribbon.name,
                //         style: TextStyle(
                //           fontSize: 10,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: SizeConfig.screenWidth / 2.8,
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: getProportionateScreenWidth(13)),
                    )),
                // kDefaultHeight(5),
                buildProductPrice(product),
                // kDefaultHeight(5),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }

  // Column buildProductPrice(product) {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     product.showPrice
  //         ? Text(
  //             '\u{20B9} ' + product.price.sellingPrice!.toString(),
  //             style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: Color(0XFFF52F2F)),
  //           )
  //         : Text(
  //             '\u{20B9} ' +
  //                 product.price.sellingPrice!.toString() +
  //                 ' - ' +
  //                 '\u{20B9} ' +
  //                 product.price.mrp!.toString(),
  //             style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: Color(0XFFF52F2F))),
  //     Row(
  //       children: [
  //         Text(
  //           product.moq != null ? product.moq.toString() : '1 ',
  //           style: TextStyle(fontSize: 10),
  //         ),
  //         // Text(
  //         //   ' ' + product.priceType != null
  //         //       ? product?.priceType + " (Min. Order)"
  //         //       : " (Min. Order)",
  //         //   style: TextStyle(fontSize: 10),
  //         // )
  //       ],
  //     )
  //   ]);
  // }

  Container buildProductPrice(product) {
    // print("product==>>>> ${product.toJson()}");
    return Container(
      // width: SizeConfig.screenWidth / 2.8,
      width: (SizeConfig.screenWidth / 2.2) - 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.showPrice == true) ...[
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // SizedBox(width: 5),
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.toString() +
                      (product.type == "pack" || product.type == "set"
                          ? " / piece"
                          : ""),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 5),
                if (product.type != "pack" && product.type != "set") ...[
                  const Text(
                    'MRP: ',
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    CommonHelper.currencySymbol() +
                        product.price.mrp.toString(),
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 10,
                    ),
                  ),
                ],
                Text(
                  (product.price.discount != null && product.price.discount > 0)
                      ? '${product.price.discount} % Off'
                      : '',
                  style: headingStyle.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ] else ...[
            const SizedBox.shrink(), // or an empty Container() if you prefer
          ],
        ],
      ),
    );
  }
}
