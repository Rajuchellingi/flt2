// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/related_product_model.dart';

class ProductDetailRelatedProductsDesign4 extends StatelessWidget {
  ProductDetailRelatedProductsDesign4(
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
    final brightness = Theme.of(context).brightness;
    return Container(
        margin: const EdgeInsets.only(top: 20),
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              design['source']['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
            ),
            SizedBox(height: 10),
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
                                                      color: kPrimaryColor,
                                                      emptyHeight: 25.0,
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
  final RelatedProduct product;
  final _controller;
  final design;
  final themeController = Get.find<ThemeController>();
  final productSettingController = Get.find<ProductSettingController>();

  final ratingWidget;
  ItemCard(
      {Key? key,
      required this.product,
      required controller,
      this.ratingWidget,
      required this.design})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');
    final brightness = Theme.of(context).brightness;
    return Obx(() => GestureDetector(
          onTap: () async {
            await Get.toNamed('/productDetail',
                arguments: product, preventDuplicates: false);
          },
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: [
                      Container(
                          height: SizeConfig.screenWidth / 1.9,
                          width: (SizeConfig.screenWidth / 2) - 20,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImageWidget(
                                fill: BoxFit.cover,
                                image: (product.images != null &&
                                        product.images!.length > 0)
                                    ? product.images![0].imageName.toString() +
                                        "&width=400"
                                    : '',
                              ))),
                      product.isOutofstock == false
                          ? Positioned(
                              top: 100,
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
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                IntrinsicWidth(child: ratingWidget),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (product.vendor != null) ...[
                      //   Container(
                      //       // margin: const EdgeInsets.only(top: 5),
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
                      Container(
                          width: SizeConfig.screenWidth / 2.2,
                          child: Text(
                            product.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor),
                          )),
                      // kDefaultHeight(5),
                      if (platform == 'shopify')
                        buildShopifyProductPrice(product, instance)
                      else
                        buildRietailProductPrice(product),
                      // kDefaultHeight(5),

                      if (instance != null &&
                          instance['source']['show-variants'] == true)
                        buildAvailableOptions(product)
                    ],
                  ),
                ),
              ],
            ),
            if (instance != null && instance['source']['show-wishlist'] == true)
              Positioned(
                top: (SizeConfig.screenWidth / 2) - 10,
                right: 0,
                child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: kPrimaryTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller.getWishListonClick(product)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 20,
                        color: _controller.getWishListonClick(product)
                            ? Colors.red
                            : Colors.white,
                        onPressed: () {
                          _controller.addToWishList(product.sId.toString());
                        })),
              ),
            if (instance != null &&
                instance['source']['show-add-to-cart'] == true)
              Positioned(
                top: (SizeConfig.screenWidth / 2) - 60,
                right: -4,
                child: IconButton.filledTonal(
                    style: IconButton.styleFrom(backgroundColor: kPrimaryColor),
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(Icons.shopping_bag_outlined,
                        color: Colors.white),
                    iconSize: 18,
                    color: kSecondaryColor,
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: const BorderRadius.vertical(
                                top: const Radius.circular(30))),
                        context: context,
                        routeSettings: RouteSettings(arguments: Get.arguments),
                        builder: (BuildContext context) {
                          return QuickCart(
                            title: product.name,
                            design: 'design2',
                            product: product,
                            image: (product.images != null &&
                                    product.images!.length > 0)
                                ? product.images![0].imageName! + "&width=400"
                                : '',
                            price: product.price!.sellingPrice,
                          );
                        },
                      );
                    }),
              ),
          ]),
        ));
  }

  buildAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> options =
        _controller.getRelatedAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      final brightness = Theme.of(Get.context!).brightness;
      return Container(
        margin: const EdgeInsets.only(right: 10),
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
                              color: variant.isAvailable!
                                  ? brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor
                                  : Colors.grey,
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
      return Container();
    }
  }

  Column buildRietailProductPrice(product) {
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(Get.context!).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (productSetting.priceDisplayType == 'mrp-and-selling-price' &&
              product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text(
                  product.price.currencySymbol + product.price.mrp.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )),
          if (productSetting.priceDisplayType == 'mrp') ...[
            Text(
              "MRP : " +
                  product.price.currencySymbol +
                  product.price.mrp.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: kPrimaryTextColor),
            )
          ] else ...[
            Text(
              product.price.currencySymbol +
                  product.price.sellingPrice.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: kPrimaryTextColor),
            )
          ]
        ],
      )
    ]);
  }

  Column buildShopifyProductPrice(product, instance) {
    final brightness = Theme.of(Get.context!).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text(
                  CommonHelper.currencySymbol() +
                      product.price.mrp.round().toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )),
          Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                CommonHelper.currencySymbol() +
                    product.price.sellingPrice.round().toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              )),
          if (instance['source']['show-discount'] == true &&
              product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Text(
              "Save ${calculateSavingsPercentage(product.price.mrp.toDouble(), product.price.sellingPrice.toDouble())}%",
              style: TextStyle(
                  color: Color(0XFFC20000),
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            )
        ],
      )
    ]);
  }

  int calculateSavingsPercentage(double mrp, double sellingPrice) {
    if (mrp <= 0) return 0; // Avoid division by zero
    double saved = mrp - sellingPrice;
    return ((saved / mrp) * 100).round();
  }
}
