// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/collection_model.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionRelatedProductDesign2 extends StatelessWidget {
  CollectionRelatedProductDesign2(
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              design['source']['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )),
            const SizedBox(height: 10),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (var content in products)
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: (SizeConfig.screenWidth / 2) - 20,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: (SizeConfig.screenWidth / 2) - 10,
                                  child: ItemCard(
                                      product: content,
                                      design: design,
                                      ratingWidget: commonReviewController
                                                  .isLoading.value ==
                                              false
                                          ? commonReviewController
                                              .ratingsWidget(content.sId,
                                                  color: kPrimaryColor)
                                          : null,
                                      controller: _controller))
                            ]),
                      )),
              ],
            ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  // Product Image with fixed height
                  Container(
                    height: SizeConfig.screenWidth / 2,
                    width: SizeConfig.screenWidth / 2.2,
                    margin: EdgeInsets.only(bottom: 5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
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
                  if (instance != null &&
                      instance['source']['show-wishlist'] == true)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller.getWishListonClick(product)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 20,
                        color: _controller.getWishListonClick(product)
                            ? Colors.red
                            : kPrimaryColor,
                        onPressed: () {
                          if (platform == 'to-automation') {
                            _controller.openWishListPopup(product.sId, product);
                          } else {
                            _controller
                                .addProductToWishList(product.sId.toString());
                          }
                        },
                      ),
                    ),
                  // Add to Cart Button inside image
                  if (instance != null &&
                      instance['source']['show-add-to-cart'] == true)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        ),
                        constraints: BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: kSecondaryColor),
                        iconSize: 18,
                        // color: Colors.black,
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            context: context,
                            routeSettings:
                                RouteSettings(arguments: Get.arguments),
                            builder: (BuildContext context) {
                              return QuickCart(
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
              const SizedBox(height: 5),
              // Product Name and Price Section
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Container(
                      child: Text(
                        product.productName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            // color: kTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    if (product.showPrice == true) ...[
                      kDefaultHeight(5),
                      buildProductPrice(product)
                    ],
                    IntrinsicWidth(child: ratingWidget),
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
        ));
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
    final brightness = Theme.of(Get.context!).brightness;

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
                  'Rs. ${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ))
              ] else if (product.type != 'set' && product.type != 'pack') ...[
                if (product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Rs. " + product.price.mrp.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.grey
                                : Colors.black),
                      )),
                Text(
                  "Rs. " + product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          )
        ]);
  }
}
