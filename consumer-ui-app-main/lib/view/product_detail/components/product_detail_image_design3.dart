// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/carousel_image_slider_design2.dart';
import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/common_component/image_viewer.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:black_locust/model/related_product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailImageDesign3 extends StatelessWidget {
  ProductDetailImageDesign3(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();

  final design;

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');

    return Obx(
      () => _controller.isLoading.value &&
              _controller.productPackImage.length == 0
          ? Container()
          : Stack(children: [
              Container(
                height: SizeConfig.screenHeight * 0.62,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(),
                child: new CarouselImageSliderDesign2(
                  press: (data) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ImageViewer(
                          imageIndex: data['index'],
                          gallery: _controller.productPackImage.value,
                        );
                      },
                    );
                  },
                  type: 'product',
                  bannerList: _controller.productPackImage.value
                      as List<ImageSliderVWModel>,
                  autoPlay: false,
                  imageBaseUri: singlePackImageUri,
                  height: SizeConfig.screenHeight * 0.67,
                  borderRadius: 0,
                  // type:_controller.type,
                ),
              ),
              if (design['source']['show-similar-styles'] == true &&
                  _controller.relatedProduct.value != null &&
                  _controller.relatedProduct.value.length > 0)
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Similar Styles",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10))),
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.6,
                                maxChildSize: 0.8,
                                minChildSize: 0.5,
                                snap: true,
                                snapSizes: [0.5, 0.6, 0.8],
                                builder: (context, scrollController) =>
                                    SingleChildScrollView(
                                      controller: scrollController,
                                      child: _buildBottomSheetContent(context),
                                    ));
                          },
                        );
                      },
                    )),
              Positioned(
                  top: 10,
                  right: 20,
                  child: Column(children: [
                    if (design['source']['show-share'] == true) ...[
                      GestureDetector(
                          onTap: () {
                            _controller.shareImageFromUrl();

                            // Share.share(
                            //     websiteUrl +
                            //         'products/' +
                            //         _controller.product.value.handle.toString(),
                            //     subject: "Take a look at this " +
                            //         _controller.product.value.name.toString());
                          },
                          child: const Icon(Icons.share_outlined)),
                      const SizedBox(height: 10)
                    ],
                    if (instance != null &&
                        instance['source']['show-add-to-cart'] == true &&
                        design != null &&
                        design['source']['show-add-to-cart']) ...[
                      GestureDetector(
                          onTap: () {
                            Get.toNamed('cart');
                          },
                          child: const Icon(Icons.shopping_bag_outlined,
                              color: Colors.white)),
                      const SizedBox(height: 10)
                    ],
                    if (instance != null &&
                        instance['source']['show-wishlist'] == true &&
                        design != null &&
                        design['source']['show-wishlist'] == true) ...[
                      GestureDetector(
                          onTap: () {
                            _controller.addToWishList(
                                _controller.product.value.sId.toString());
                          },
                          child: (_controller.wishlistFlag.value != null &&
                                  _controller.getWishListonClick(
                                      _controller.product.value))
                              ? const Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border_sharp,
                                  color: kPrimaryColor)),
                      const SizedBox(height: 10)
                    ]
                  ]))
            ]),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Similar Styles',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Wrap(direction: Axis.horizontal, children: [
          for (var content in _controller.relatedProduct.value)
            Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: (SizeConfig.screenWidth / 2) - 10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: (SizeConfig.screenWidth / 2) - 10,
                            child: ItemCard(
                              design: design,
                              product: content,
                              ratingWidget:
                                  commonReviewController.isLoading.value ==
                                          false
                                      ? commonReviewController
                                          .ratingsWidget(content.sId)
                                      : null,
                              controller: _controller,
                            ))
                      ]),
                ))
        ]),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final RelatedProduct product;
  final _controller;
  final design;
  final themeController = Get.find<ThemeController>();
  final ratingWidget;
  ItemCard(
      {Key? key,
      required this.design,
      required this.product,
      this.ratingWidget,
      required controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');

    return Obx(() => GestureDetector(
          onTap: () {
            Get.back();
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
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //       left: BorderSide(width: 1.0, color: Colors.grey)),
                      // ),
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
                              color: kTextColor,
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
