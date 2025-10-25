// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'dart:convert';

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

class ProductDetailRelatedProductsDesign3 extends StatelessWidget {
  ProductDetailRelatedProductsDesign3(
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
        // padding: const EdgeInsets.symmetric(horizontal: 10),
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
  final product;
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

    return GestureDetector(
      onTap: () async {
        await Get.toNamed('/productDetail',
            arguments: product, preventDuplicates: false);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Container(
                    height: 230,
                    width: (SizeConfig.screenWidth / 2) - 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImageWidget(
                          fill: BoxFit.cover,
                          image: platform == 'to-automation'
                              ? product.images.imageName
                              : (product.images != null &&
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
                if (instance != null &&
                    instance['source']['show-wishlist'] == true)
                  Positioned(
                    right: 0,
                    child: Obx(() => IconButton(
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller.getWishListonClick(product)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 20,
                        color: _controller.getWishListonClick(product)
                            ? Colors.red
                            : kPrimaryColor,
                        onPressed: () {
                          if (platform == 'shopify')
                            _controller.addToWishList(product.sId.toString());
                          else
                            _controller.addToWishList(
                                product.sId.toString(), product);
                        })),
                  ),
                productBadges(),
                if (instance != null &&
                    instance['source']['show-add-to-cart'] == true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton.filledTonal(
                        style: IconButton.styleFrom(
                            backgroundColor: kPrimaryColor),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(5),
                        icon: const Icon(Icons.shopping_bag_outlined),
                        iconSize: 18,
                        color: kSecondaryColor,
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: const BorderRadius.vertical(
                                    top: const Radius.circular(10))),
                            context: context,
                            routeSettings:
                                RouteSettings(arguments: Get.arguments),
                            builder: (BuildContext context) {
                              return QuickCart(
                                title: product.name,
                                product: product,
                                image: (product.images != null &&
                                        product.images!.length > 0)
                                    ? product.images![0].imageName! +
                                        "&width=400"
                                    : '',
                                price: product.price!.sellingPrice,
                              );
                            },
                          );
                        }),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: SizeConfig.screenWidth / 2.2,
                    child: Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    )),
                kDefaultHeight(5),
                if (platform == 'shopify')
                  buildShopifyProductPrice(product)
                else
                  buildRietailProductPrice(product),
                // kDefaultHeight(5),
                IntrinsicWidth(child: ratingWidget),
                if (instance != null &&
                    instance['source']['show-variants'] == true)
                  buildAvailableOptions(product)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productBadges() {
    var badgeMetafield = themeController.productBadge;
    var discount = 0;
    if (product.price?.mrp != 0 &&
        product.price?.mrp != null &&
        product.price?.mrp != product.price?.sellingPrice) {
      var discountAmount =
          ((product.price!.mrp! - product.price!.sellingPrice!) /
                  product.price!.mrp!) *
              100;
      discount = double.parse(discountAmount.toStringAsFixed(2)).round();
    }
    if (badgeMetafield != null) {
      var metafields = product.metafields;
      if (metafields != null && metafields.isNotEmpty) {
        var productBadge = metafields.firstWhere((el) =>
            badgeMetafield['key'] == el.key &&
            badgeMetafield['namespace'] == el.namespace);
        if (productBadge != null &&
            productBadge.type == 'list.single_line_text_field') {
          var value = jsonDecode(productBadge.value.toString());
          return Positioned(
              top: 10,
              left: 10,
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  if (discount > 0) ...[
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("$discount% off",
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)))
                  ],
                  for (var badge in value) ...[
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(badge,
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)))
                  ]
                ],
              )));
        }
      }
    }

    if (discount > 0) {
      return Positioned(
          top: 10,
          left: 10,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
              child: Text("$discount% off",
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold))));
    }
    return Positioned(child: Container());
  }

  buildAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> options =
        _controller.getRelatedAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      return Container(
        // margin: const EdgeInsets.symmetric(horizontal: 10),
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
      return Container();
    }
  }

  Column buildShopifyProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            CommonHelper.currencySymbol() +
                " " +
                product.price.sellingPrice.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          if (product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  CommonHelper.currencySymbol() +
                      " " +
                      product.price.mrp.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                      color: brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.black),
                )),
        ],
      )
    ]);
  }

  Column buildRietailProductPrice(product) {
    final productSetting = productSettingController.productSetting.value;

    final brightness = Theme.of(Get.context!).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (product.price != null &&
              productSetting.priceDisplayType == 'mrp-and-selling-price' &&
              product.price.mrp != null &&
              product.price.mrp != 0 &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text(
                  product.price.currencySymbol + product.price.mrp.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                      color: brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.black),
                )),
          if (productSetting.priceDisplayType == 'mrp') ...[
            Text(
              "MRP : " +
                  product.price.currencySymbol +
                  product.price.mrp.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            )
          ] else ...[
            if (product.price != null &&
                product.price.currencySymbol != null &&
                product.price.sellingPrice != null &&
                product.price.sellingPrice != 0)
              Text(
                product.price.currencySymbol +
                    product.price.sellingPrice.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              )
          ]
        ],
      )
    ]);
  }
}
