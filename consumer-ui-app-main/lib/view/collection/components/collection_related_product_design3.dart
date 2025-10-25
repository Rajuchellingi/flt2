// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/collection_model.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionRelatedProductDesign3 extends StatelessWidget {
  CollectionRelatedProductDesign3(
      {Key? key,
      required controller,
      required this.design,
      required this.products})
      : _controller = controller,
        super(key: key);
  final design;
  final products;
  final _controller;
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              design['source']['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var content in products)
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: (SizeConfig.screenWidth / 2) - 30,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: (SizeConfig.screenWidth / 2) - 30,
                                      child: ItemCard(
                                          product: content,
                                          design: design,
                                          ratingWidget: commonReviewController
                                                      .isLoading.value ==
                                                  false
                                              ? commonReviewController
                                                  .ratingsWidget(content.sId,
                                                      color: Colors.amber,
                                                      showAverage: false)
                                              : null,
                                          controller: _controller))
                                ]),
                          )),
                  ],
                )),
          ],
        ));
  }
}

class ItemCard extends StatelessWidget {
  final _controller;
  final ProductCollectionListVM product;
  final design;
  final themeController = Get.find<ThemeController>();
  final ratingWidget;
  ItemCard(
      {Key? key,
      required this.product,
      required this.design,
      this.ratingWidget,
      required controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');
    return Obx(() => GestureDetector(
        onTap: () {
          _controller.navigateToProductDetails(product);
        },
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  // Product Image with fixed height
                  Container(
                    height: SizeConfig.screenWidth / 2,
                    width: SizeConfig.screenWidth / 2.2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImageWidget(
                            fill: BoxFit.cover,
                            image: product.imageUrl != null
                                ? platform == 'shopify'
                                    ? '${product.imageUrl}&width=400'
                                    : product.imageUrl.toString()
                                : '')),
                  ),
                  // Out of Stock Overlay
                  if (product.availableForSale == false)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: const Center(
                          child: const Text(
                            "OUT OF STOCK",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Wishlist Button inside image

                  // Ribbon inside image
                  // if (product.ribbon != null)
                  //   Positioned(
                  //     top: 2,
                  //     left: 2,
                  //     child: Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  //       decoration: BoxDecoration(
                  //         color: Color(
                  //           int.parse(
                  //             product.ribbon.colorCode!.replaceAll('#', '0xff'),
                  //           ),
                  //         ),
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
              // SizedBox(height: 5),
              // Product Name and Price Section
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(child: ratingWidget),
                    // if (product.vendor != null) ...[
                    //   Container(
                    //       // margin: EdgeInsets.only(top: 5),
                    //       width: SizeConfig.screenWidth / 3.5,
                    //       child: Text(
                    //         product.vendor!,
                    //         // textAlign: TextAlign.center,
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: const TextStyle(
                    //             color: Colors.grey, fontSize: 12),
                    //       ))
                    // ] else ...[
                    //   const SizedBox(height: 20)
                    // ],
                    // Product Name
                    Container(
                      width: SizeConfig.screenWidth / 2.2,
                      child: Text(
                        product.productName.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            // color: kTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    if (product.showPrice == true) ...[
                      kDefaultHeight(2),
                      buildProductPrice(product)
                    ],

                    // Available Sizes (conditionally displayed)
                    if (instance != null &&
                        instance['source']['show-variants'] == true) ...[
                      // SizedBox(height: 5),
                      buildAvailableOptions(product),
                    ],
                  ],
                ),
              )
            ],
          ),
          // if (instance != null && instance['source']['show-wishlist'] == true)
          Positioned(
            right: -3,
            top: (SizeConfig.screenWidth / 2) - 25,
            child: IconButton.filledTonal(
              style: IconButton.styleFrom(backgroundColor: Colors.white),
              autofocus: _controller.wishlistFlag.value,
              icon: _controller.getWishListonClick(product)
                  ? const Icon(Icons.favorite_sharp)
                  : const Icon(Icons.favorite_border_sharp),
              iconSize: 18,
              color: _controller.getWishListonClick(product)
                  ? Colors.red
                  : Colors.black,
              onPressed: () {
                if (platform == 'to-automation') {
                  _controller.openWishListPopup(product.sId, product);
                } else {
                  _controller.addProductToWishList(product.sId.toString());
                }
              },
            ),
          ),
          // Add to Cart Button inside image
          if (instance != null &&
              instance['source']['show-add-to-cart'] == true)
            Positioned(
              right: -2,
              top: (SizeConfig.screenHeight / 2) - 70,
              child: IconButton.filledTonal(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                constraints: BoxConstraints(),
                padding: const EdgeInsets.all(12),
                icon: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.black),
                iconSize: 18,
                // color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    context: context,
                    routeSettings: RouteSettings(arguments: Get.arguments),
                    builder: (BuildContext context) {
                      return QuickCart(
                        design: 'design2',
                        title: product.productName,
                        product: product,
                        image: product.imageUrl != null
                            ? platform == 'shopify'
                                ? '${product.imageUrl}&width=400'
                                : product.imageUrl.toString()
                            : '',
                        price: product.price!.sellingPrice,
                      );
                    },
                  );
                },
              ),
            ),
        ])));
  }

  buildAvailableOptions(ProductCollectionListVM product) {
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var variant in options)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: variant.isAvailable!
                                  ? Color.fromARGB(255, 198, 198, 198)
                                  : Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            variant.name.toString(),
                            style: TextStyle(
                              color: variant.isAvailable! ? null : Colors.grey,
                              fontSize: 12,
                              fontWeight: variant.isAvailable!
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!variant.isAvailable!)
                          Positioned.fill(
                            child: const Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                          ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(); // Return an empty container if no options are available
    }
  }

  Column buildProductPrice(product) {
    // final brightness = Theme.of(Get.context!).brightness;

    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,

            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (product.type == 'set' || product.type == 'pack') ...[
                Container(
                    child: Text(
                  '${CommonHelper.currencySymbol()} ${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ))
              ] else if (product.type != 'set' && product.type != 'pack') ...[
                if (product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        CommonHelper.currencySymbol() +
                            product.price.mrp.round().toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black),
                      )),
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.round().toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          )
        ]);
  }
}
