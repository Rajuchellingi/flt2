// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartRelatedProductsV1 extends StatelessWidget {
  const CartRelatedProductsV1({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final CartV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Similar Products",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      for (var element in _controller.relatedProducts.value)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
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

  ItemCard({Key? key, this.product, required controller})
      : _controller = controller,
        super(key: key);

  final CartV1Controller _controller;
  final productSettingController = Get.find<ProductSettingController>();

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
                    imageUrl: productImageUrl +
                        product.imageId +
                        '/' +
                        "420-560" +
                        '/' +
                        product.images.imageName,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    width: (SizeConfig.screenWidth / 2.2) - 10,
                    height: SizeConfig.screenWidth / 2,
                  ),
                ),
                product.isOutofstock
                    ? Positioned(
                        //top: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: SizeConfig.screenWidth / 2,
                            height: 30,
                            child: Center(
                              child: Text(
                                "OUT OF STOCK",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
          SizedBox(height: 5),
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
    final productSetting = productSettingController.productSetting.value;

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
                if (productSetting.priceDisplayType == 'mrp') ...[
                  Text(
                    "MRP : " +
                        product.price.currencySymbol +
                        product.price.mrp.toString() +
                        (product.type == "pack" || product.type == "set"
                            ? " / piece"
                            : ""),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ] else ...[
                  Text(
                    product.price.currencySymbol +
                        product.price.sellingPrice.toString() +
                        (product.type == "pack" || product.type == "set"
                            ? " / piece"
                            : ""),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  )
                ],
                SizedBox(width: 5),
                if (productSetting.priceDisplayType ==
                        'mrp-and-selling-price' &&
                    product.type != "pack" &&
                    product.type != "set") ...[
                  Text(
                    'MRP: ',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    product.price.currencySymbol + product.price.mrp.toString(),
                    style: TextStyle(
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
            SizedBox.shrink(), // or an empty Container() if you prefer
          ],
        ],
      ),
    );
  }
}
