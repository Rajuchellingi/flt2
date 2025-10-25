// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'dart:convert';

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import '../../../common_component/quick_cart.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/search_model.dart';

class SearchBlockDesign2 extends StatelessWidget {
  SearchBlockDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;
    final brightness = Theme.of(Get.context!).brightness;
    return Obx(() => Stack(children: [
          Column(
            children: [
              Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : (_controller.productList.value != null &&
                              _controller.productList.value.length > 0)
                          ? RefreshIndicator(
                              color: kPrimaryColor,
                              onRefresh: _controller.refreshPage,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(children: [
                                  Obx(() => SingleChildScrollView(
                                      controller: _controller.scrollController,
                                      child: Wrap(
                                          direction: Axis.horizontal,
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: [
                                            Container(
                                                width: SizeConfig.screenWidth,
                                                child:
                                                    const SizedBox(height: 5)),
                                            for (var item in _controller
                                                .productList.value)
                                              Container(
                                                  width:
                                                      (SizeConfig.screenWidth /
                                                              2) -
                                                          15,
                                                  child: ItemCard(
                                                    design: design,
                                                    product: item,
                                                    ratingWidget: commonReviewController
                                                                .isLoading
                                                                .value ==
                                                            false
                                                        ? commonReviewController
                                                            .ratingsWidget(
                                                                item.sId,
                                                                color:
                                                                    kPrimaryColor)
                                                        : null,
                                                    controller: _controller,
                                                  )),
                                            Container(
                                                width: SizeConfig.screenWidth,
                                                child:
                                                    const SizedBox(height: 5)),
                                            if (footer != null &&
                                                footer.isNotEmpty &&
                                                themeController
                                                        .bottomBarType.value ==
                                                    'design1' &&
                                                footer['componentId'] ==
                                                    'footer-navigation')
                                              SizedBox(
                                                height: 80,
                                                width: SizeConfig.screenWidth,
                                              ),
                                          ])
                                      //  GridView.builder(
                                      //     controller: _controller.scrollController,
                                      //     itemCount:
                                      //         _controller.productList.value.length,
                                      //     gridDelegate:
                                      //         SliverGridDelegateWithFixedCrossAxisCount(
                                      //       crossAxisCount: 2,
                                      //       mainAxisSpacing: 0,
                                      //       crossAxisSpacing: 0,
                                      //       childAspectRatio: 0.5,
                                      //     ),
                                      //     // padding: EdgeInsets.only(bottom: 80),
                                      //     itemBuilder: (context, index) => ItemCard(
                                      //           design: design,
                                      //           product: _controller
                                      //               .productList.value[index],
                                      //           controller: _controller,
                                      //         )),
                                      )),
                                  Obx(() => _controller.loading.value
                                      ? Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: (footer != null &&
                                                  footer.isNotEmpty &&
                                                  themeController.bottomBarType
                                                          .value ==
                                                      'design1' &&
                                                  footer['componentId'] ==
                                                      'footer-navigation')
                                              ? 80
                                              : 0,
                                          child: Container(
                                            height: 80.0,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: (brightness ==
                                                            Brightness.dark &&
                                                        kPrimaryColor ==
                                                            Colors.black)
                                                    ? Colors.white
                                                    : kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container())
                                ]),
                              ))
                          : const Center(
                              child: const Text('No Record Found!'),
                            )),
            ],
          ),
          // if (_c,
        ]));
  }
}

class ItemCard extends StatelessWidget {
  final _controller;
  final dynamic product;
  final design;
  final themeController = Get.find<ThemeController>();
  final productSettingController = Get.find<ProductSettingController>();
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
            children: <Widget>[
              Container(
                child: Stack(
                  children: [
                    Container(
                        height: SizeConfig.screenWidth / 2,
                        width: (SizeConfig.screenWidth / 2) - 20,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImageWidget(
                              fill: BoxFit.cover,
                              image: productImage(product.type),
                            ))),
                    product.isOutofstock == true
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
                                _controller.openWishListPopup(
                                    product.sId, product);
                              } else {
                                _controller.addProductToWishList(
                                    product.sId.toString());
                              }
                            }),
                      ),
                    productBadges(),
                    if (product.ribbon != null)
                      Positioned(
                        top: 2,
                        left: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(int.parse(product.ribbon!.colorCode!
                                .replaceAll('#', '0xff'))),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            product.ribbon!.name.toString(),
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
                        right: 0,
                        bottom: 0,
                        child: IconButton.filledTonal(
                            style: IconButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(5),
                            icon: const Icon(Icons.shopping_bag_outlined,
                                color: kSecondaryColor),
                            iconSize: 18,
                            color: kSecondaryColor,
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10))),
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
                    IntrinsicWidth(child: ratingWidget),
                    if (instance != null &&
                        instance['source']['show-variants'] == true)
                      kDefaultHeight(5),
                    buildAvailableOptions(product)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  productImage(type) {
    if (product.images != null && product.images!.length > 0) {
      if (type == "item") {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=400";
        } else {
          return product.images![0].imageName.toString();
        }
      } else {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=400";
        } else {
          return product.images![0].imageName.toString();
        }
      }
    } else {
      return '';
    }
  }

  buildAvailableOptions(ProductCollectionListVM product) {
    List<SearchProductSizeOptions> options =
        _controller.getProductAvailableOptions(product);
    if (options != null && options.length > 0)
      return SingleChildScrollView(
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
                        vertical: 3,
                        horizontal: 5,
                      ),
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
      );
    else
      return Container();
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

  Column buildShopifyProductPrice(product) {
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
                Text(
                  CommonHelper.currencySymbol() +
                      " " +
                      product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        CommonHelper.currencySymbol() +
                            " " +
                            product.price.mrp.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.grey
                                : Colors.black),
                      )),
              ]
            ],
          )
        ]);
  }

  Column buildRietailProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;

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
                    child: productSetting.priceDisplayType == 'mrp'
                        ? Text(
                            'MRP : Rs. ${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          )
                        : Text(
                            'Rs. ${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ))
              ] else if (product.type != 'set' && product.type != 'pack') ...[
                if (productSetting.priceDisplayType ==
                        'mrp-and-selling-price' &&
                    product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Rs. " + product.price.mrp.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.grey
                                : Colors.black),
                      )),
                if (productSetting.priceDisplayType == 'mrp') ...[
                  Text(
                    "MRP : " + "Rs. " + product.price.mrp.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ] else ...[
                  Text(
                    "Rs. " + product.price.sellingPrice.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ]
              ]
            ],
          )
        ]);
  }
}
