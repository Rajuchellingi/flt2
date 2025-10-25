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

class ProductDetailRelatedProductsDesign5 extends StatelessWidget {
  ProductDetailRelatedProductsDesign5(
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
                  fontWeight: FontWeight.bold,
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
                            width: (SizeConfig.screenWidth / 1.8) - 10,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width:
                                          (SizeConfig.screenWidth / 1.8) - 10,
                                      child: ItemCard(
                                          product: content,
                                          design: design,
                                          ratingWidget: commonReviewController
                                                      .isLoading.value ==
                                                  false
                                              ? commonReviewController
                                                  .ratingsWidget(content.sId,
                                                      color: kPrimaryColor,
                                                      showAverage: false,
                                                      emptyHeight: 0.0)
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
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFFE5E7EB))),
        child: GestureDetector(
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
                          width: (SizeConfig.screenWidth / 1.8) - 20,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                  width: SizeConfig.screenWidth / 2.2,
                                  child: Text(
                                    product.name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor),
                                  )),
                              IntrinsicWidth(child: ratingWidget),
                              if (platform == 'shopify')
                                buildShopifyProductPrice(product)
                              else
                                buildRietailProductPrice(product),
                              // kDefaultHeight(5),
                            ])),
                        if (instance != null &&
                            instance['source']['show-add-to-cart'] == true) ...[
                          SizedBox(width: 10),
                          GestureDetector(
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xFFE5E7EB))),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: kPrimaryColor,
                                    size: 20,
                                    weight: 2,
                                  )),
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.vertical(
                                          top: const Radius.circular(30))),
                                  context: context,
                                  routeSettings:
                                      RouteSettings(arguments: Get.arguments),
                                  builder: (BuildContext context) {
                                    return QuickCart(
                                      title: product.name,
                                      design: 'design2',
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
                              })
                        ]
                      ]),
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
                top: 0,
                right: 0,
                child: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 209, 209, 209))),
                    child: IconButton(
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller.getWishListonClick(product)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 18,
                        color: _controller.getWishListonClick(product)
                            ? Colors.red
                            : Colors.black,
                        onPressed: () {
                          _controller.addToWishList(product.sId.toString());
                        })),
              ),
          ]),
        )));
  }

  buildAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> options =
        _controller.getRelatedAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      final brightness = Theme.of(Get.context!).brightness;
      return Container(
        margin: const EdgeInsets.only(right: 10, top: 3),
        child: SizedBox(
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

  calculateDiscount(mrp, sellingPrice) {
    if (mrp == 0) return 0;
    return ((mrp - sellingPrice) / mrp) * 100;
  }

  Column buildShopifyProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    var discount =
        calculateDiscount(product.price.mrp, product.price.sellingPrice);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            CommonHelper.currencySymbol() +
                product.price.sellingPrice.round().toString(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor),
          ),
          if (discount > 0) ...[
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text('-${discount.toStringAsFixed(0)}%',
                    style: TextStyle(color: Color(0xFF059669))))
          ]
        ],
      )
    ]);
  }
}
