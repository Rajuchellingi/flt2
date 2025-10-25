// ignore_for_file: unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/landing_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/quick_cart.dart';
import '../../../config/configConstant.dart';
import '../../../const/size_config.dart';
import '../../../helper/common_helper.dart';

class CartLoginRelatedProductsDesign4 extends StatelessWidget {
  CartLoginRelatedProductsDesign4({
    Key? key,
    required this.title,
    required this.design,
    required controller,
    required this.products,
  })  : _controller = controller,
        super(key: key);

  final title;
  final design;
  final CartLoginMessageController _controller;
  final products;
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor,
                    fontWeight: FontWeight.bold))),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (var content in products)
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: (SizeConfig.screenWidth / 2.3) - 10,
                                  child: Wrap(children: [
                                    SizedBox(
                                        width:
                                            (SizeConfig.screenWidth / 2.3) - 10,
                                        child: ItemCard(
                                          design: design,
                                          controller: _controller,
                                          product: content,
                                          ratingWidget: commonReviewController
                                                      .isLoading.value ==
                                                  false
                                              ? commonReviewController
                                                  .ratingsWidget(content.sId,
                                                      color: kPrimaryColor,
                                                      emptyHeight: 25.0,
                                                      showAverage: false)
                                              : null,
                                        )),
                                  ]),
                                ))
                        ]))),
          ],
        ),
        SizedBox(height: 5),
        GestureDetector(
            onTap: () {
              Get.toNamed('/collection',
                  arguments: {'id': design['source']['collection']});
            },
            child: Center(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                        )),
                    child: Text(
                      "VIEW ALL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ),
                    )))),
        // Text(content.profileId!.name!),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final PromotionProductsVM product;
  final CartLoginMessageController _controller;
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
          onTap: () {
            _controller.navigateToProductDetails(product);
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
                          width: (SizeConfig.screenWidth / 2.2) - 20,
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
                    ],
                  ),
                ),
                // const SizedBox(height: 5),
                IntrinsicWidth(child: ratingWidget),
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
                            maxLines: 1,
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
                        if (platform == 'shopify')
                          buildShopifyProductPrice(product, instance)
                        else
                          buildRietailProductPrice(product)
                      ],
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
                  right: 2,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
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
                            _controller.openWishlistPopup(product.sId, product);
                          } else {
                            _controller
                                .addProductToWishList(product.sId.toString());
                          }
                        }),
                  )),
            if (instance != null &&
                instance['source']['show-add-to-cart'] == true)
              Positioned(
                top: (SizeConfig.screenWidth / 2) - 60,
                right: -2,
                child: IconButton.filledTonal(
                    style: IconButton.styleFrom(backgroundColor: kPrimaryColor),
                    constraints: const BoxConstraints(),
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
                    }),
              ),
          ]),
        ));
  }

  buildAvailableOptions(PromotionProductsVM product) {
    final brightness = Theme.of(Get.context!).brightness;
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: SizedBox(
          height: 40, // Set a height for the available options container
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
        ),
      );
    } else {
      return Container();
    }
  }

  Column buildRietailProductPrice(product) {
    final productSetting = productSettingController.productSetting.value;

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
                      child: productSetting.priceDisplayType == 'mrp'
                          ? Text(
                              'MRP : ${CommonHelper.currencySymbol()}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            )
                          : Text(
                              '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
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
                          CommonHelper.currencySymbol() +
                              product.price.mrp.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor,
                          ),
                        )),
                  if (productSetting.priceDisplayType == 'mrp') ...[
                    Text(
                      "MRP : " +
                          CommonHelper.currencySymbol() +
                          product.price.mrp.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ),
                    )
                  ] else ...[
                    Text(
                      CommonHelper.currencySymbol() +
                          product.price.sellingPrice.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ),
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
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ))
                ] else if (product.type != 'set' && product.type != 'pack') ...[
                  if (product.price.mrp != 0 &&
                      product.price.mrp != null &&
                      product.price.mrp != product.price.sellingPrice)
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(
                          CommonHelper.currencySymbol() +
                              product.price.mrp.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor,
                          ),
                        )),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                        CommonHelper.currencySymbol() +
                            product.price.sellingPrice.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                        )),
                  ),
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
