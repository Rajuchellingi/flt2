// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

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

import '../../../model/search_model.dart';

class SearchBlockDesign1 extends StatelessWidget {
  final _controller;
  final design;
  SearchBlockDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = _controller.isLoading.value;
      final productList = _controller.productList.value;

      if (isLoading) {
        return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor));
      }

      if (productList.isEmpty) {
        return const Center(child: Text('No Record Found!'));
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: _controller.refreshPage,
              child: _buildProductGrid(productList),
            ),
            _buildLoadingIndicator(),
          ],
        ),
      );
    });
  }

  Widget _buildProductGrid(List productList) {
    return GridView.builder(
      controller: _controller.scrollController,
      itemCount: productList.length,
      cacheExtent: 2000,
      addAutomaticKeepAlives: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        final product = productList[index];

        return RepaintBoundary(
          key: ValueKey(product.sId),
          child: ItemCard(
            design: design,
            product: product,
            controller: _controller,
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(() => _controller.loading.value
        ? const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 80.0,
              child: Center(
                  child: CircularProgressIndicator(color: kPrimaryColor)),
            ),
          )
        : const SizedBox.shrink());
  }
}

class ItemCard extends StatelessWidget {
  final dynamic product;
  final dynamic design;
  final dynamic _controller;

  const ItemCard({
    Key? key,
    required this.design,
    required this.product,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final instance = themeController.instance('product');

    return GestureDetector(
      onTap: () => _controller.navigateToProductDetails(product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildProductImage(instance)),
          const SizedBox(height: 5),
          _buildProductInfo(instance),
        ],
      ),
    );
  }

  Widget _buildProductImage(dynamic instance) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: CachedNetworkImageWidget(
            fill: BoxFit.cover,
            image: _getProductImage(),
            width: 200,
          ),
        ),
        if (product.isOutofstock) _buildOutOfStockOverlay(),
        if (_shouldShowWishlist(instance)) _buildWishlistButton(),
        if (_shouldShowAddToCart(instance)) _buildAddToCartButton(),
        if (product.ribbon != null) _buildRibbon(),
      ],
    );
  }

  String _getProductImage() {
    if (product.images?.isNotEmpty ?? false) {
      final imageName = product.images!.first.imageName ?? '';
      return platform == 'shopify' ? '$imageName&width=200' : imageName;
    }
    return '';
  }

  bool _shouldShowWishlist(dynamic instance) {
    return instance != null && instance['source']['show-wishlist'] == true;
  }

  bool _shouldShowAddToCart(dynamic instance) {
    return instance != null && instance['source']['show-add-to-cart'] == true;
  }

  Widget _buildOutOfStockOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.8),
        alignment: Alignment.center,
        child: const Text(
          "OUT OF STOCK",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Positioned(
      right: 10,
      top: 10,
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
            _controller.openWishListPopup(product.sId, product);
          } else {
            _controller.addProductToWishList(product.sId.toString());
          }
        },
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Positioned(
      right: 10,
      bottom: 10,
      child: IconButton.filledTonal(
        style: IconButton.styleFrom(backgroundColor: kPrimaryColor),
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(5),
        icon: const Icon(Icons.add_sharp),
        iconSize: 18,
        color: kSecondaryColor,
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            context: Get.context!,
            routeSettings: RouteSettings(arguments: Get.arguments),
            builder: (BuildContext context) {
              return QuickCart(
                title: product.name,
                product: product,
                image: _getProductImage(),
                price: product.price!.sellingPrice,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRibbon() {
    return Positioned(
      top: 2,
      left: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Color(
              int.parse(product.ribbon!.colorCode!.replaceAll('#', '0xff'))),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(
          product.ribbon!.name.toString(),
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildProductInfo(dynamic instance) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name ?? '',
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(13),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          if (platform == 'shopify')
            buildShopifyProductPrice(product)
          else
            buildRietailProductPrice(product),
          const SizedBox(height: 5),
          _buildRatingWidget(),
          if (instance != null && instance['source']['show-variants'] == true)
            buildAvailableOptions(product)
        ],
      ),
    );
  }

  Widget _buildRatingWidget() {
    final commonReviewController = Get.find<CommonReviewController>();

    return Obx(() {
      if (commonReviewController.isLoading.value) {
        return const SizedBox.shrink();
      }
      return commonReviewController.ratingsWidget(product.sId) ??
          const SizedBox.shrink();
    });
  }

  productImage(type) {
    if (product.images != null && product.images!.length > 0) {
      if (type == "item") {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=200";
        } else {
          return product.images![0].imageName.toString();
        }
      } else {
        if (platform == 'shopify') {
          return product.images!.first.imageName! + "&width=200";
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

  Column buildShopifyProductPrice(product) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      CommonHelper.currencySymbol() +
                          product.price.mrp.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    )),
              // SizedBox(width: 10),
              Text(
                CommonHelper.currencySymbol() +
                    product.price.sellingPrice.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          )
        ]);
  }

  Column buildRietailProductPrice(product) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      CommonHelper.currencySymbol() +
                          product.price.mrp.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    )),
              // SizedBox(width: 10),
              if (productSetting.priceDisplayType == 'mrp') ...[
                Text(
                  "MRP : " +
                      CommonHelper.currencySymbol() +
                      product.price.mrp.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ] else ...[
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          )
        ]);
  }
}
