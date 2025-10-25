// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/common_helper.dart';
import '../../../model/related_product_model.dart';

class ProductDetailRelatedProductsDesign1 extends StatelessWidget {
  ProductDetailRelatedProductsDesign1(
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
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              design['source']['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                    constraints: BoxConstraints(
                        // maxHeight: SizeConfig.screenHeight / 2,
                        maxWidth: MediaQuery.of(context).size.width - 20),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (var element in products)
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                    width: (SizeConfig.screenWidth / 2) - 10,
                                    // height: 500,
                                    child: ItemCard(
                                      design: design,
                                      product: element,
                                      ratingWidget: commonReviewController
                                                  .isLoading.value ==
                                              false
                                          ? commonReviewController
                                              .ratingsWidget(element.sId)
                                          : null,
                                      controller: _controller,
                                    )))
                        ]))),
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
  final ratingWidget;
  final productSettingController = Get.find<ProductSettingController>();
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

    return Obx(() => GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/productDetail',
                arguments: product);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 230,
                      width: SizeConfig.screenWidth / 2,
                      child: product.type == "product"
                          ? CachedNetworkImage(
                              imageUrl: productImage(product.type),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  ErrorImage(),
                              placeholder: (context, url) => Container(
                                    child: Center(
                                      child: ImagePlaceholder(),
                                    ),
                                  ),
                              alignment: Alignment.topCenter)
                          : CachedNetworkImage(
                              imageUrl: productImage(product.type),
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Container(
                                    child: Center(
                                      child: ImagePlaceholder(),
                                    ),
                                  ),
                              fit: BoxFit.cover,
                              errorWidget: (BuildContext context, url, error) {
                                return Center(child: ErrorImage());
                              }),
                    ),
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
                        right: 10,
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
                              if (platform == 'shopify')
                                _controller
                                    .addToWishList(product.sId.toString());
                              else
                                _controller.addToWishList(
                                    product.sId.toString(), product);
                            }),
                      ),
                    if (product.ribbon != null)
                      Positioned(
                        top: 2,
                        left: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(int.parse(product.ribbon.colorCode!
                                .replaceAll('#', '0xff'))),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            product.ribbon.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (instance != null &&
                        instance['source']['show-add-to-cart'] == true)
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: IconButton.filledTonal(
                            style: IconButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(5),
                            icon: const Icon(Icons.add_sharp),
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
                                    image: productImage(product.type),
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
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: kTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(13)),
                        )),
                    kDefaultHeight(5),
                    if (platform == 'shopify')
                      buildShopifyProductPrice(product)
                    else
                      buildRietailProductPrice(product),
                    // kDefaultHeight(5),
                    Container(child: ratingWidget),
                    if (instance != null &&
                        instance['source']['show-variants'] == true)
                      buildAvailableOptions(product)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  productImage(type) {
    if (platform == 'shopify') {
      if (product.images != null && product.images!.length > 0) {
        if (type == "product") {
          return product.images!.first.imageName! + "&width=400";
        } else {
          if (platform == 'shopify') {
            return product.images!.first.imageName! + "&width=400";
          } else {
            return product.images.imageName.toString();
          }
        }
      } else {
        return '';
      }
    } else {
      print('object ${product.images.imageName.toString()}');
      return product.images.imageName.toString();
    }
  }

  buildAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> options =
        _controller.getRelatedAvailableOptions(product);
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

  Column buildRietailProductPrice(product) {
    final productSetting = productSettingController.productSetting.value;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (product.showPrice == true) ...[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (productSetting.priceDisplayType == 'mrp-and-selling-price' &&
                product.price.mrp != 0 &&
                product.price.mrp != null &&
                product.price.mrp != product.price.sellingPrice)
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    product.price.currencySymbol + product.price.mrp.toString(),
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  )),
            if (productSetting.priceDisplayType == 'mrp') ...[
              Text(
                "MRP : " +
                    product.price.currencySymbol +
                    product.price.mrp.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ] else ...[
              Text(
                product.price.currencySymbol +
                    product.price.sellingPrice.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ]
          ],
        )
      ]
    ]);
  }

  Column buildShopifyProductPrice(product) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  CommonHelper.currencySymbol() + product.price.mrp.toString(),
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
                )),
          Text(
            CommonHelper.currencySymbol() +
                product.price.sellingPrice.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      )
    ]);
  }
}
