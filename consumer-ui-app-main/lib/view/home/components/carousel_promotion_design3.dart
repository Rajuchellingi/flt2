// ignore_for_file: unused_field, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/landing_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/cached_network_image.dart';
import '../../../const/constant.dart';
import '../../../const/size_config.dart';
import '../../../helper/common_helper.dart';

class CarouselPromotionDesign3 extends StatelessWidget {
  CarouselPromotionDesign3(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                  child: Text(
                design['source']['title'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              )),
              GestureDetector(
                  onTap: () {
                    _controller.navigateByUrlType({
                      "kind": "collection",
                      "value": design['source']['collection']
                    });
                  },
                  child: Text("View all",
                      style: TextStyle(
                          fontSize: 12,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor)))
            ]),
            if (design['source']['description'] != null &&
                design['source']['description'] != "") ...[
              Container(
                  child: Text(design['source']['description'],
                      style: TextStyle(
                          fontSize: 12,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor)))
            ],
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 20),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (var content in promotionProducts())
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width:
                                          (SizeConfig.screenWidth / 2.3) - 10,
                                      child: Wrap(children: [
                                        SizedBox(
                                            width: (SizeConfig.screenWidth /
                                                    2) -
                                                10,
                                            child: ItemCard(
                                                product: content,
                                                design: design,
                                                controller: _controller,
                                                ratingWidget:
                                                    commonReviewController
                                                                .isLoading
                                                                .value ==
                                                            false
                                                        ? commonReviewController
                                                            .ratingsWidget(
                                                                content.sId,
                                                                color:
                                                                    kPrimaryColor,
                                                                emptyHeight:
                                                                    25.0,
                                                                showAverage:
                                                                    false)
                                                        : null)),
                                      ]),
                                    ))
                            ]))),
              ],
            ),
            // Text(content.profileId!.name!),
            const SizedBox(
              height: 10,
            ),
          ],
        )));
  }

  promotionProducts() {
    var result = [];
    if (_controller.collectionProducts.value.length > 0) {
      var products = _controller.collectionProducts.value.firstWhere(
          (element) =>
              element['collection'] == design['source']['collection'] &&
              element['count'] == design['source']['count']);

      if (products != null) result = products['products'];
    }
    return result;
  }
}

class ItemCard extends StatelessWidget {
  final PromotionProductsVM product;
  final dynamic _controller;
  final design;
  final ratingWidget;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();
  final productSettingController = Get.find<ProductSettingController>();

  ItemCard(
      {Key? key,
      required this.product,
      required controller,
      required this.ratingWidget,
      required this.design})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');
    final brightness = Theme.of(context).brightness;
    return Obx(() => GestureDetector(
          onTap: () {
            _controller.navigateToProductDetails(product);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: [
                    Container(
                        height: SizeConfig.screenWidth / 2,
                        width: (SizeConfig.screenWidth / 2) - 20,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImageWidget(
                              fill: BoxFit.cover,
                              image: product.imageUrl != null
                                  ? platform == 'shopify'
                                      ? '${product.imageUrl}&width=400'
                                      : product.imageUrl.toString()
                                  : '',
                            ))),
                    product.availableForSale == false
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
                        : Container()
                  ]),
                  IntrinsicWidth(child: ratingWidget),
                  // SizedBox(height: 5),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              product.productName!,
                              // textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  // color: kTextColor,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),
                        if (product.showPrice == true) ...[
                          kDefaultHeight(5),
                          if (platform == 'shopify')
                            buildShopifyProductPrice(product, instance)
                          else
                            buildRietailProductPrice(product)
                        ],
                        kDefaultHeight(5),
                        if (instance != null &&
                            instance['source']['show-variants'] == true)
                          buildAvailableOptions(product)
                      ],
                    ),
                  ),
                ],
              ),
              if (instance != null &&
                  instance['source']['show-wishlist'] == true)
                Positioned(
                    top: (SizeConfig.screenWidth / 2) - 20,
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
                            if (platform == 'to-automation') {
                              _controller.openWishlistPopup(
                                  product.sId, product);
                            } else {
                              _controller
                                  .addProductToWishList(product.sId.toString());
                            }
                          }),
                    )),
              if (product.ribbon != null)
                Positioned(
                  top: 2,
                  left: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                          product.ribbon!.colorCode!.replaceAll('#', '0xff'))),
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
                  right: -5,
                  top: (SizeConfig.screenWidth / 2) - 70,
                  child: IconButton.filledTonal(
                      style: IconButton.styleFrom(
                          backgroundColor: kPrimaryTextColor),
                      constraints: BoxConstraints(),
                      padding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.shopping_bag_outlined,
                          color: Colors.white),
                      iconSize: 18,
                      // color: Colors.black,
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          context: context,
                          routeSettings:
                              RouteSettings(arguments: Get.arguments),
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
                      }),
                ),
            ],
          ),
        ));
  }

  buildAvailableOptions(PromotionProductsVM product) {
    final brightness = Theme.of(Get.context!).brightness;
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Scroll horizontally
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
      );
    } else {
      return Container();
    }
  }

  Column buildRietailProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.type == 'set' || product.type == 'pack') ...[
                  Container(
                      child: productSetting.priceDisplayType == 'mrp'
                          ? Text(
                              'MRP : ${product.price.currencySymbol}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor),
                            )
                          : Text(
                              '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor),
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
                          product.price.currencySymbol +
                              product.price.mrp.toString(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor),
                        )),
                  if (productSetting.priceDisplayType == 'mrp') ...[
                    Text(
                      "MRP : " +
                          product.price.currencySymbol +
                          product.price.mrp.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor),
                    )
                  ] else ...[
                    Text(
                      product.price.currencySymbol +
                          product.price.sellingPrice.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor),
                    )
                  ]
                ]
              ])
        ]);
  }

  Column buildShopifyProductPrice(product, instance) {
    final brightness = Theme.of(Get.context!).brightness;
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.type == 'set' || product.type == 'pack') ...[
                  Container(
                      child: Text(
                    '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  ))
                ] else if (product.type != 'set' && product.type != 'pack') ...[
                  if (product.price.mrp != 0 &&
                      product.price.mrp != null &&
                      product.price.mrp != product.price.sellingPrice)
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(
                          CommonHelper.currencySymbol() +
                              product.price.mrp.round().toString(),
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor),
                      )),
                  if (instance['source']['show-discount'] == true &&
                      product.price.mrp != 0 &&
                      product.price.mrp != null &&
                      product.price.mrp != product.price.sellingPrice)
                    Text(
                      "Save ${calculateSavingsPercentage(product.price.mrp, product.price.sellingPrice)}%",
                      style: TextStyle(
                          color: Color(0XFFC20000),
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )
                ]
              ])
        ]);
  }

  int calculateSavingsPercentage(double mrp, double sellingPrice) {
    if (mrp <= 0) return 0; // Avoid division by zero
    double saved = mrp - sellingPrice;
    return ((saved / mrp) * 100).round();
  }
}
