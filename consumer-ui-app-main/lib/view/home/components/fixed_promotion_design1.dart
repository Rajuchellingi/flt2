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

class FixedPromotionDesign1 extends StatelessWidget {
  FixedPromotionDesign1(
      {Key? key, required this.design, required this.controller})
      : super(key: key);

  final dynamic controller;
  final Map<String, dynamic> design;
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = _getPromotionProducts();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          _buildTitle(),
          const SizedBox(height: 10),
          _buildProductGrid(products),
          const SizedBox(height: 10),
          _buildViewAllButton(),
          const SizedBox(height: 15),
        ],
      );
    });
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          design['source']['title'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<dynamic> products) {
    return Wrap(
      direction: Axis.horizontal,
      children: products
          .map((content) => Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: (SizeConfig.screenWidth / 2) - 10,
                  child: ItemCard(
                    product: content,
                    design: design,
                    ratingWidget:
                        commonReviewController.isLoading.value == false
                            ? commonReviewController.ratingsWidget(content.sId)
                            : null,
                    controller: controller,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildViewAllButton() {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(width: 1, color: kPrimaryColor),
        ),
        onPressed: () => controller.navigateByUrlType(
            {"kind": "collection", "value": design['source']['collection']}),
        child: const Text(
          'View All',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    );
  }

  List<dynamic> _getPromotionProducts() {
    if (controller.collectionProducts.value.isEmpty) return [];

    final products = controller.collectionProducts.value.firstWhere((element) =>
        element['collection'] == design['source']['collection'] &&
        element['count'] == design['source']['count']);

    return products?['products'] ?? [];
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({
    Key? key,
    required this.product,
    required this.controller,
    this.ratingWidget,
    required this.design,
  }) : super(key: key);

  final PromotionProductsVM product;
  final dynamic controller;
  final Widget? ratingWidget;
  final Map<String, dynamic> design;

  final themeController = Get.find<ThemeController>();
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    final instance = themeController.instance('product');

    return Obx(() => GestureDetector(
          onTap: () => controller.navigateToProductDetails(product),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProductImage(instance),
              const SizedBox(height: 5),
              _buildProductDetails(instance),
            ],
          ),
        ));
  }

  Widget _buildProductImage(Map<String, dynamic>? instance) {
    return Stack(
      children: [
        _buildProductImageContainer(),
        if (product.availableForSale == false) _buildOutOfStockOverlay(),
        if (instance != null && instance['source']['show-wishlist'] == true)
          _buildWishlistButton(),
        if (instance != null && instance['source']['show-add-to-cart'] == true)
          _buildAddToCartButton(),
        if (product.ribbon != null) _buildRibbon(product.ribbon!)
      ],
    );
  }

  Widget _buildRibbon(ProductRibbonVM ribbon) {
    return Positioned(
      top: 2,
      left: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Color(int.parse(ribbon.colorCode!.replaceAll('#', '0xff'))),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(
          ribbon.name.toString(),
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProductImageContainer() {
    return Container(
      height: 230,
      width: SizeConfig.screenWidth / 2,
      child: CachedNetworkImageWidget(
        fill: BoxFit.cover,
        image: product.imageUrl != null
            ? platform == 'shopify'
                ? '${product.imageUrl}&width=400'
                : product.imageUrl.toString()
            : '',
      ),
    );
  }

  Widget _buildOutOfStockOverlay() {
    return Positioned(
      top: 100,
      child: Container(
        width: SizeConfig.screenWidth / 2,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
        ),
        child: const Center(
          child: Text(
            "OUT OF STOCK",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Positioned(
      right: 10,
      child: IconButton(
        autofocus: controller.wishlistFlag.value,
        icon: Icon(
          controller.getWishListonClick(product)
              ? Icons.favorite_sharp
              : Icons.favorite_border_sharp,
        ),
        iconSize: 20,
        color:
            controller.getWishListonClick(product) ? Colors.red : kPrimaryColor,
        onPressed: () {
          if (platform == 'to-automation') {
            controller.openWishlistPopup(product.sId, product);
          } else {
            controller.addProductToWishList(product.sId.toString());
          }
        },
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Positioned(
      right: 10,
      bottom: 0,
      child: IconButton.filledTonal(
        style: IconButton.styleFrom(
          backgroundColor: kPrimaryColor,
        ),
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(5),
        icon: const Icon(Icons.add_sharp),
        iconSize: 18,
        color: kSecondaryColor,
        onPressed: () => _showQuickCart(),
      ),
    );
  }

  void _showQuickCart() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: Get.context!,
      routeSettings: RouteSettings(arguments: Get.arguments),
      builder: (BuildContext context) => QuickCart(
        title: product.productName,
        product: product,
        image: product.imageUrl != null
            ? platform == 'shopify'
                ? '${product.imageUrl}&width=400'
                : product.imageUrl.toString()
            : '',
        price: product.price!.sellingPrice,
      ),
    );
  }

  Widget _buildProductDetails(Map<String, dynamic>? instance) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          if (product.showPrice == true) ...[
            kDefaultHeight(5),
            platform == 'shopify'
                ? buildShopifyProductPrice(product)
                : buildRietailProductPrice(product),
          ],
          if (ratingWidget != null) ratingWidget!,
          if (instance != null && instance['source']['show-variants'] == true)
            buildAvailableOptions(product),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return SizedBox(
      width: SizeConfig.screenWidth / 2.2,
      child: Text(
        product.productName!,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: getProportionateScreenWidth(13),
        ),
      ),
    );
  }

  Widget buildAvailableOptions(PromotionProductsVM product) {
    List<ProductSizeOptions>? options = controller.getAvailableOptions(product);
    if (options == null || options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options
                .map((variant) => Padding(
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
                                    ? const Color.fromARGB(255, 198, 198, 198)
                                    : Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              variant.name.toString(),
                              style: TextStyle(
                                color:
                                    variant.isAvailable! ? null : Colors.grey,
                                fontSize: 12,
                                fontWeight: variant.isAvailable!
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!variant.isAvailable!)
                            const Positioned.fill(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                              ),
                            ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Column buildRietailProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;

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
                  child: productSetting.priceDisplayType == 'mrp'
                      ? Text(
                          'MRP : ${product.price.currencySymbol}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      : Text(
                          '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                )
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
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                if (productSetting.priceDisplayType == 'mrp') ...[
                  Text(
                    "MRP : " +
                        product.price.currencySymbol +
                        product.price.mrp.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ] else ...[
                  Text(
                    product.price.currencySymbol +
                        product.price.sellingPrice.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ]
              ]
            ],
          ),
        )
      ],
    );
  }

  Column buildShopifyProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;

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
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                )
              ] else if (product.type != 'set' && product.type != 'pack') ...[
                if (product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      CommonHelper.currencySymbol() +
                          product.price.mrp.toString(),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          ),
        )
      ],
    );
  }
}
