// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:black_locust/controller/product_detail_page_controller.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/common_helper.dart';
import '../../../model/related_product_model.dart';

class CartRelatedProductsDesign1 extends StatelessWidget {
  final CartController _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();

  CartRelatedProductsDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: (_controller.cartSetting.value.recommendedProducts != null &&
                _controller.cartSetting.value.recommendedProducts!.type ==
                    'single-collection' &&
                _controller.cartCollectionProduct.length > 0)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    _controller.cartSetting.value.recommendedProducts!.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  )),
                  SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (var content
                          in _controller.cartCollectionProduct.value)
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: (SizeConfig.screenWidth / 2) - 20,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width:
                                            (SizeConfig.screenWidth / 2) - 10,
                                        child: ItemCard(
                                            design: design,
                                            product: content,
                                            ratingWidget: commonReviewController
                                                        .isLoading.value ==
                                                    false
                                                ? commonReviewController
                                                    .ratingsWidget(content.sId)
                                                : null,
                                            controller: _controller))
                                  ]),
                            )),
                    ],
                  ),
                  // Text(content.profileId!.name!),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // backgroundColor: Colors.white,
                      side: BorderSide(width: 1, color: kPrimaryColor),
                    ),
                    onPressed: () {
                      _controller.openCollectionPage(_controller.cartSetting
                          .value.recommendedProducts!.singleCollectionUrl);
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
                ],
              )
            : (_controller.cartSetting.value.recommendedProducts != null &&
                    _controller.cartSetting.value.recommendedProducts!.type ==
                        'four-collection' &&
                    _controller.cartSetting.value.recommendedProducts!
                            .collections!.length >
                        0)
                ? Column(children: [
                    Center(
                        child: Text(
                      _controller.cartSetting.value.recommendedProducts!.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(children: [
                        for (var element in _controller.cartSetting.value
                            .recommendedProducts!.collections!)
                          GestureDetector(
                              onTap: () {
                                _controller
                                    .openCollectionPage(element.collectionUrl);
                              },
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Container(
                                    width: (SizeConfig.screenWidth / 2) - 20,
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.openCollectionPage(
                                                element.collectionUrl);
                                          },
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              Color.fromARGB(255, 2, 2, 2)
                                                  .withOpacity(
                                                      0.4), // Adjust the color and opacity as needed
                                              BlendMode.srcATop,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  element.imageName.toString(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ErrorImage(),
                                              // height: 100,
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topCenter,
                                              placeholder: (context, url) =>
                                                  Container(
                                                child: Center(
                                                  child: ImagePlaceholder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))),
                                Container(
                                  width: (SizeConfig.screenWidth / 2) - 20,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    element.title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]))
                      ]),
                    )
                  ])
                : Container()));
  }
}

class ItemCard extends StatelessWidget {
  final RelatedProduct product;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();
  final design;
  final ratingWidget;
  final commonReviewController = Get.find<CommonReviewController>();

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
            _controller.openDetailPage(product);
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
                              alignment: Alignment.topCenter,
                              errorWidget: (context, url, error) =>
                                  ErrorImage(),
                              placeholder: (context, url) => Container(
                                child: Center(
                                  child: ImagePlaceholder(),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: productImage(product.type),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Container(
                                    child: Center(
                                      child: ImagePlaceholder(),
                                    ),
                                  ),
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
                                child: Center(
                                  child: const Text(
                                    "OUT OF STOCK",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                            icon: _controller.getWishListonClick(product.sId)
                                ? Icon(Icons.favorite_sharp)
                                : Icon(Icons.favorite_border_sharp),
                            iconSize: 20,
                            color: _controller.getWishListonClick(product.sId)
                                ? Colors.red
                                : kPrimaryColor,
                            onPressed: () {
                              _controller.addToWishList(product.sId.toString());
                            }),
                      ),
                    if (instance != null &&
                        instance['source']['show-add-to-cart'] == true)
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: IconButton.filledTonal(
                            style: IconButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            constraints: BoxConstraints(),
                            padding: const EdgeInsets.all(5),
                            icon: const Icon(Icons.add_sharp),
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
                              ).then((value) {
                                if (value == true) _controller.getCartProduct();
                              });
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
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(13)),
                        )),
                    kDefaultHeight(5),
                    buildProductPrice(product),
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
    if (product.images != null && product.images!.length > 0) {
      if (type == "product") {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=400";
        } else {
          return promotionImageBaseUri +
              product.imageId.toString() +
              '/' +
              product.images![0].imageName.toString();
        }
      } else {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=400";
        } else {
          return promotionImageBaseUri +
              product.imageId.toString() +
              '/' +
              product.images![0].imageName.toString();
        }
      }
    } else {
      return '';
    }
  }

  buildAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> options =
        _controller.getAvailableOptions(product);
    if (options != null && options.length > 0)
      return Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
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

  Column buildProductPrice(product) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (product.price.mrp != 0 &&
              product.price.mrp != null &&
              product.price.mrp != product.price.sellingPrice)
            Container(
                margin: EdgeInsets.only(right: 0),
                child: Text(
                  CommonHelper.currencySymbol() + product.price.mrp.toString(),
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                )),
          Text(
            CommonHelper.currencySymbol() +
                product.price.sellingPrice.toString(),
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      )
    ]);
  }
}
