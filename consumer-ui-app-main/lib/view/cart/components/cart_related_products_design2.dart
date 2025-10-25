// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/common_component/quick_cart.dart';
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

class CartRelatedProductsDesign2 extends StatelessWidget {
  final CartController _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();

  CartRelatedProductsDesign2(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: (_controller.cartSetting.value.recommendedProducts != null &&
                _controller.cartSetting.value.recommendedProducts!.type ==
                    'single-collection' &&
                _controller.cartCollectionProduct.length > 0)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  Center(
                      child: Text(
                    _controller.cartSetting.value.recommendedProducts!.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  )),
                  const SizedBox(height: 10),
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
                                                    .ratingsWidget(content.sId,
                                                        color: kPrimaryColor)
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
  final commonReviewController = Get.find<CommonReviewController>();
  final ratingWidget;
  final design;

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
                        width: (SizeConfig.screenWidth / 2) - 20,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
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
                                child: Center(
                                  child: Text(
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
                        right: 0,
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
                        right: 0,
                        bottom: 0,
                        child: IconButton.filledTonal(
                            style: IconButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.all(5),
                            icon: Icon(Icons.shopping_bag_outlined),
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
                              ;
                            }),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                              fontWeight: FontWeight.w600, fontSize: 14),
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
                      padding: EdgeInsets.symmetric(
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
                        child: Divider(
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
                margin: EdgeInsets.only(right: 5),
                child: Text(
                  CommonHelper.currencySymbol() + product.price.mrp.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.black),
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
