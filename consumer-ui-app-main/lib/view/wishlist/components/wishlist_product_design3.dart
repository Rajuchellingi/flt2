// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/common_component/quick_cart.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/common_helper.dart';

class WishlistProductDesign3 extends StatelessWidget {
  WishlistProductDesign3({
    Key? key,
    required controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);
  final design;
  final WishlistController _controller;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    // print("productListDetailsssss ${_controller.toJson()}");
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;
    Color primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Expanded(
          child: Obx(() => _controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (_controller.wishlist != null &&
                      _controller.wishlist.length > 0)
                  ? RefreshIndicator(
                      color: kPrimaryColor,
                      onRefresh: () => _controller.refreshPage(),
                      child: SingleChildScrollView(
                          controller: _controller.scrollController,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: [
                                    for (var element
                                        in _controller.wishlist.value)
                                      Container(
                                          width:
                                              (SizeConfig.screenWidth / 2) - 15,
                                          child: ItemCard(
                                            design: design,
                                            product: element,
                                            controller: _controller,
                                            ratingWidget: commonReviewController
                                                        .isLoading.value ==
                                                    false
                                                ? commonReviewController
                                                    .ratingsWidget(element.sId,
                                                        color: kPrimaryColor,
                                                        showAverage: false)
                                                : null,
                                          )),
                                    if (footer != null &&
                                        footer.isNotEmpty &&
                                        themeController.bottomBarType.value ==
                                            'design1' &&
                                        footer['componentId'] ==
                                            'footer-navigation')
                                      SizedBox(
                                        height: 80,
                                        width: SizeConfig.screenWidth,
                                      ),
                                    if (_controller.loading.value)
                                      Center(
                                          child: CircularProgressIndicator(
                                              color: kPrimaryColor))
                                  ]))))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No Product!',
                            style: TextStyle(
                                fontSize: 18,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor),
                          ),
                        ),
                        // DefaultButton(
                        //   press: () => _controller.getAllWishList(),
                        //   text: 'Refresh',
                        //   isBorder: false,
                        //   width: 120.0,
                        // )
                      ],
                    )),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final WishlistController _controller;
  final dynamic product;
  final dynamic design;
  final ratingWidget;
  ItemCard({
    Key? key,
    required controller,
    required this.design,
    this.ratingWidget,
    this.product,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GestureDetector(
      onTap: () {
        // product.sId = product.productId;
        Get.toNamed('/productDetail',
            preventDuplicates: false, arguments: product);
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: SizeConfig.screenWidth / 2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: productImage(product.type),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorWidget: (context, url, error) => ErrorImage(),
                            placeholder: (context, url) => Container(
                              child: Center(
                                child: ImagePlaceholder(),
                              ),
                            ),
                          ))),
                  Positioned(
                      top: 8,
                      right: 10,
                      child: GestureDetector(
                        child: const Icon(Icons.close,
                            size: 20, color: Colors.grey),
                        onTap: () {
                          _controller.removeWishList(product.sId);
                        },
                      )),
                  if (product.isOutofstock == false)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: const Center(
                          child: const Text(
                            "OUT OF STOCK",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicWidth(child: ratingWidget),
                  // if (product.vendor != null) ...[
                  //   Container(
                  //       // margin: const EdgeInsets.only(top: 5),
                  //       width: SizeConfig.screenWidth / 3,
                  //       child: Text(
                  //         product.vendor!,
                  //         // textAlign: TextAlign.center,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style:
                  //             const TextStyle(color: Colors.grey, fontSize: 12),
                  //       ))
                  // ] else ...[
                  //   const SizedBox(height: 20)
                  // ],
                  if (product.name != null)
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.w600),
                    ),
                  // kDefaultHeight(5),
                  buildProductPrice(product)
                ],
              ),
            ),
          ],
        ),
        if (design != null && design['source']['show-add-to-cart'] == true)
          Positioned(
            right: -3,
            top: (SizeConfig.screenWidth / 1.9) - 30,
            child: IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: kPrimaryColor,
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
              ),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(12),
              icon: const Icon(Icons.shopping_bag, color: Colors.white),
              iconSize: 18,
              color: kSecondaryColor,
              // color: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  context: context,
                  backgroundColor: kBackground,
                  routeSettings: RouteSettings(arguments: Get.arguments),
                  builder: (BuildContext context) {
                    return QuickCart(
                      design: 'design2',
                      title: product.name,
                      product: product,
                      image: productImage(product.type),
                      price: product.price!.sellingPrice,
                    );
                  },
                );
              },
            ),
          ),
      ]),
    );
  }

  productImage(type) {
    if (product.images != null && product.images!.length > 0) {
      if (type != "item") {
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

  Column buildProductPrice(product) {
    var brightness = MediaQuery.of(Get.context!).platformBrightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          if (product.price!.maxPrice != null &&
              product.price!.maxPrice != 0 &&
              product.price.maxPrice != product.price.minPrice) ...[
            Text(
              CommonHelper.currencySymbol() +
                  product.price.mrp.round().toString(),
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
            ),
            const SizedBox(width: 10)
          ],
          Text(
            CommonHelper.currencySymbol() +
                product.price.sellingPrice.round().toString(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor),
          )
        ],
      )
    ]);
  }
}
