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

class CarouselPromotionDesign5 extends StatelessWidget {
  CarouselPromotionDesign5(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  design['source']['title'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                )),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicHeight(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              for (var content in promotionProducts())
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                      width:
                                          (SizeConfig.screenWidth / 2.3) - 10,
                                      child: ItemCard(
                                        product: content,
                                        design: design,
                                        ratingWidget: commonReviewController
                                                    .isLoading.value ==
                                                false
                                            ? commonReviewController
                                                .ratingsWidget(content.sId)
                                            : null,
                                        controller: _controller,
                                      )),
                                )
                            ])))),
              ],
            ),
            // Text(content.profileId!.name!),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
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
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: [
                      Container(
                          height: SizeConfig.screenWidth / 2,
                          width: SizeConfig.screenWidth / 2,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                              height: 230,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: SizeConfig.screenWidth / 2,
                                  height: 30,
                                  child: Center(
                                    child: Text(
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
                                if (platform == 'to-automation') {
                                  _controller.openWishlistPopup(
                                      product.sId, product);
                                } else {
                                  _controller.addProductToWishList(
                                      product.sId.toString());
                                }
                              }),
                        ),
                      if (product.ribbon != null)
                        Positioned(
                          top: 2,
                          left: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
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
                          right: 10,
                          bottom: 0,
                          child: IconButton.filledTonal(
                              style: IconButton.styleFrom(
                                  backgroundColor: kPrimaryColor),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(5),
                              icon: const Icon(Icons.add_sharp,
                                  color: kSecondaryColor),
                              iconSize: 18,
                              // color: kSecondaryColor,
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
                ),
                const SizedBox(height: 5),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: SizeConfig.screenWidth / 2.2,
                          child: Text(
                            product.productName!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
            ))));
  }

  buildAvailableOptions(PromotionProductsVM product) {
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);

    // Check if there are options available
    if (options != null && options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 50, // Set a height for the available options container
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
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 5),
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

    // print("product ${product.toJson()}");
    return Column(children: [
      Container(
          child: Wrap(
        children: [
          if (product.type == 'set' || product.type == 'pack') ...[
            Container(
                child: productSetting.priceDisplayType == 'mrp'
                    ? Text(
                        'MRP : ${product.price.currencySymbol}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    : Text(
                        '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ))
          ] else if (product.type != 'set' && product.type != 'pack') ...[
            if (productSetting.priceDisplayType == 'mrp-and-selling-price' &&
                product.price.mrp != 0 &&
                product.price.mrp != null &&
                product.price.mrp != product.price.sellingPrice)
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    product.price.currencySymbol + product.price.mrp.toString(),
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  )),
            if (productSetting.priceDisplayType == 'mrp') ...[
              Text(
                "MRP : " +
                    product.price.currencySymbol +
                    product.price.mrp.toString(),
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ] else ...[
              Text(
                product.price.currencySymbol +
                    product.price.sellingPrice.toString(),
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ]
          ]
        ],
      ))
    ]);
  }

  Column buildShopifyProductPrice(product) {
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              if (product.type == 'set' || product.type == 'pack') ...[
                Container(
                    child: Text(
                  '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
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
                        CommonHelper.currencySymbol() +
                            product.price.mrp.toString(),
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )),
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          ))
        ]);
  }
}
