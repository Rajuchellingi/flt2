// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/collection/components/collection_related_products.dart';
import 'package:black_locust/view/collection/components/collection_related_products_by_collection.dart';
import '../../../common_component/quick_cart.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/collection_model.dart';

class CollectionBlockDesign4 extends StatelessWidget {
  CollectionBlockDesign4({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final collectionData = _controller.collectionData.value;
      final collectionCatalog = collectionData.collectionCatalog;
      final footer = _controller.template.value['layout']?['footer'];
      final brightness = Theme.of(Get.context!).brightness;
      final isLoading = _controller.isLoading.value;
      final productList = _controller.productList.value;
      final hasProducts = productList != null && productList.isNotEmpty;

      return Stack(children: [
        Column(
          children: [
            if (collectionData.showDownloadCatalog == true &&
                (collectionData.catalogUrl != null ||
                    collectionData.collectionCatalog != null))
              _buildDownloadCatalogButton(collectionData, collectionCatalog),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor))
                  : hasProducts
                      ? _buildProductList(footer, brightness)
                      : const Center(child: Text('No Record Found!')),
            ),
          ],
        ),
      ]);
    });
  }

  Widget _buildDownloadCatalogButton(
      dynamic collectionData, dynamic collectionCatalog) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 15, 5),
      alignment: Alignment.centerRight,
      child: collectionCatalog.length == 1
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                var file = collectionCatalog.first;
                _controller.downloadCatalog(file.fileName, file.fileUrl);
              },
              child: Text(collectionData.downloadCatalogButtonName,
                  style: const TextStyle(color: kSecondaryColor)),
            )
          : collectionCatalog.length > 1
              ? _buildCatalogDropdown(collectionData, collectionCatalog)
              : null,
    );
  }

  Widget _buildCatalogDropdown(
      dynamic collectionData, dynamic collectionCatalog) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: kPrimaryColor,
          value: _controller.selectedCatalog.value.isEmpty
              ? null
              : _controller.selectedCatalog.value,
          hint: Text(
            collectionData.downloadCatalogButtonName,
            style: const TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          onChanged: (selectedName) =>
              _handleCatalogSelection(selectedName, collectionCatalog),
          items: collectionCatalog.map<DropdownMenuItem<String>>((item) {
            return DropdownMenuItem<String>(
              value: item.name,
              child: Text(
                item.name,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _handleCatalogSelection(
      String? selectedName, dynamic collectionCatalog) {
    if (selectedName != null) {
      var selectedItem = collectionCatalog.firstWhere(
        (item) => item.name == selectedName,
        orElse: () => CatalogFileVM(
          name: '',
          fileName: '',
          fileUrl: '',
          fileType: '',
          sId: '',
        ),
      );
      if (selectedItem.name.isNotEmpty) {
        _controller.selectedCatalog.value = selectedItem.name;
        _controller.downloadCatalog(
            selectedItem.fileName, selectedItem.fileUrl);
      }
    }
  }

  Widget _buildProductList(dynamic footer, Brightness brightness) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: _controller.refreshPage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          Obx(() => SingleChildScrollView(
                physics: const RangeMaintainingScrollPhysics(),
                controller: _controller.scrollController,
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    SizedBox(width: SizeConfig.screenWidth, height: 5),
                    ..._buildProductItems(),
                    const SizedBox(height: 5),
                    if (_controller.isRelatedProduct.value &&
                        _controller.relatedProducts.value.length > 0 &&
                        _controller.allLoaded.value == true)
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: CollectionRelatedProducts(
                          controller: _controller,
                          design: relatedProductBlock(),
                          products: _controller.relatedProducts.value,
                        ),
                      ),
                    if (_controller.productCollections.value.length > 0 &&
                        _controller.allLoaded.value == true) ...[
                      Container(
                          width: SizeConfig.screenWidth,
                          child: CollectionRelatedProductsByCollection(
                              controller: _controller)),
                    ],
                    if (footer != null &&
                        footer.isNotEmpty &&
                        themeController.bottomBarType.value == 'design1' &&
                        footer['componentId'] == 'footer-navigation')
                      SizedBox(height: 80, width: SizeConfig.screenWidth),
                  ],
                ),
              )),
          Obx(() => _controller.loading.value
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: (footer != null &&
                          footer.isNotEmpty &&
                          themeController.bottomBarType.value == 'design1' &&
                          footer['componentId'] == 'footer-navigation')
                      ? 80
                      : 0,
                  child: Container(
                    height: 80.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: (brightness == Brightness.dark &&
                                kPrimaryColor == Colors.black)
                            ? Colors.white
                            : kPrimaryColor,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ]),
      ),
    );
  }

  List<Widget> _buildProductItems() {
    return List.generate(
      _controller.productList.value.length,
      (i) => Container(
        width: _controller.productWidth(_controller.viewType.value, i, 15),
        child: RepaintBoundary(
          child: ItemCard(
            index: i,
            design: design,
            product: _controller.productList.value[i],
            ratingWidget: commonReviewController.isLoading.value == false
                ? commonReviewController.ratingsWidget(
                    _controller.productList.value[i].sId,
                    color: kPrimaryColor,
                    emptyHeight: 0.0)
                : null,
            controller: _controller,
          ),
        ),
      ),
    );
  }

  dynamic relatedProductBlock() {
    var blocks = _controller.template.value['layout']['blocks'];
    if (blocks != null && blocks.isNotEmpty) {
      return blocks.firstWhere(
        (element) => element['componentId'] == 'related-products',
        orElse: () => null,
      );
    }
    return null;
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({
    Key? key,
    required this.product,
    required this.index,
    required this.design,
    this.ratingWidget,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final ProductCollectionListVM product;
  final design;
  final index;
  final themeController = Get.find<ThemeController>();
  final ratingWidget;
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final instance = themeController.instance('product');
      final viewType = _controller.viewType.value;
      final isSmallView = viewType == 'small';
      final isAvailable = product.availableForSale != false;
      final showWishlist = instance != null &&
          instance['source']['show-wishlist'] == true &&
          !isSmallView;
      final showAddToCart = instance != null &&
          instance['source']['show-add-to-cart'] == true &&
          !isSmallView;
      final showVariants =
          instance != null && instance['source']['show-variants'] == true;

      return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xFFE5E7EB))),
          child: GestureDetector(
            onTap: () => _controller.navigateToProductDetails(product),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildProductImage(
                    isSmallView, isAvailable, showWishlist, showAddToCart),
                if (!isSmallView) ...[
                  const SizedBox(height: 5),
                  _buildProductDetails(showVariants, showAddToCart),
                ],
              ],
            ),
          ));
    });
  }

  Widget _buildProductImage(bool isSmallView, bool isAvailable,
      bool showWishlist, bool showAddToCart) {
    return Stack(
      children: [
        Container(
          height: _controller.productHeight(_controller.viewType.value, index),
          width:
              _controller.productWidth(_controller.viewType.value, index, 15),
          margin: const EdgeInsets.only(bottom: 5),
          child: ClipRRect(
            borderRadius: isSmallView
                ? BorderRadius.circular(3)
                : BorderRadius.circular(5.0),
            child: CachedNetworkImageWidget(
              fill: BoxFit.cover,
              image: product.imageUrl != null
                  ? platform == 'shopify'
                      ? _controller.assignProductImage(
                          product.imageUrl, _controller.viewType.value, index)
                      : product.imageUrl.toString()
                  : '',
            ),
          ),
        ),
        if (!isAvailable && !isSmallView)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.8),
              child: const Center(
                child: Text(
                  "OUT OF STOCK",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        if (showWishlist)
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 209, 209, 209))),
                child: IconButton(
                  autofocus: _controller.wishlistFlag.value,
                  icon: Icon(_controller.getWishListonClick(product)
                      ? Icons.favorite_sharp
                      : Icons.favorite_border_sharp),
                  iconSize: 18,
                  color: _controller.getWishListonClick(product)
                      ? Colors.red
                      : Colors.black,
                  onPressed: () => _handleWishlistClick(),
                ),
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
      ],
    );
  }

  void _handleWishlistClick() {
    if (platform == 'to-automation') {
      _controller.openWishListPopup(product.sId, product);
    } else {
      _controller.addProductToWishList(product.sId.toString());
    }
  }

  void _showQuickCart() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: Get.context!,
      routeSettings: RouteSettings(arguments: Get.arguments),
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
  }

  Widget _buildProductDetails(bool showVariants, bool showAddToCart) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    width: _controller.productWidth(
                        _controller.viewType.value, index, 30),
                    child: Text(
                      product.productName.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  IntrinsicWidth(child: ratingWidget),
                  if (product.showPrice == true) ...[
                    platform == 'shopify'
                        ? buildShopifyProductPrice()
                        : buildRietailProductPrice(),
                  ]
                ])),
            if (showAddToCart) ...[
              SizedBox(width: 10),
              GestureDetector(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFFE5E7EB))),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: kPrimaryColor,
                        size: 20,
                        weight: 2,
                      )),
                  onTap: () {
                    _showQuickCart();
                  })
            ]
          ]),
          if (showVariants) buildAvailableOptions(),
        ],
      ),
    );
  }

  Widget buildAvailableOptions() {
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              options.map((variant) => _buildVariantOption(variant)).toList(),
        ),
      ),
    );
  }

  Widget _buildVariantOption(ProductSizeOptions variant) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
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
                color: variant.isAvailable! ? null : Colors.grey,
                fontSize: 12,
                fontWeight:
                    variant.isAvailable! ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ),
          if (!variant.isAvailable!)
            const Positioned.fill(
              child: Divider(color: Colors.grey, thickness: 1.0),
            ),
        ],
      ),
    );
  }

  Column buildRietailProductPrice() {
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(Get.context!).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            if (product.type == 'set' || product.type == 'pack')
              _buildSetOrPackPrice(productSetting)
            else
              _buildRegularPrice(productSetting, brightness),
          ],
        )
      ],
    );
  }

  Widget _buildSetOrPackPrice(dynamic productSetting) {
    return Container(
      child: productSetting.priceDisplayType == 'mrp'
          ? Text(
              'MRP : ${product.price?.currencySymbol ?? ''}${product.price?.mrp ?? 0}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            )
          : Text(
              '${product.price?.currencySymbol ?? ''}${product.price?.sellingPrice ?? 0}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
    );
  }

  Widget _buildRegularPrice(dynamic productSetting, Brightness brightness) {
    return Wrap(
      children: [
        if (productSetting.priceDisplayType == 'mrp-and-selling-price' &&
            product.price?.mrp != 0 &&
            product.price?.mrp != null &&
            product.price?.mrp != product.price?.sellingPrice)
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              '${product.price?.currencySymbol ?? ''}${product.price?.mrp ?? 0}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:
                    brightness == Brightness.dark ? Colors.grey : Colors.black,
              ),
            ),
          ),
        if (productSetting.priceDisplayType == 'mrp')
          Text(
            "MRP : ${product.price?.currencySymbol ?? ''}${product.price?.mrp ?? 0}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        else
          Text(
            '${product.price?.currencySymbol ?? ''}${product.price?.sellingPrice ?? 0}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

  Column buildShopifyProductPrice() {
    final brightness = Theme.of(Get.context!).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            if (product.type == 'set' || product.type == 'pack')
              Container(
                child: Text(
                  '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              )
            else
              _buildShopifyRegularPrice(brightness),
          ],
        )
      ],
    );
  }

  Widget _buildShopifyRegularPrice(Brightness brightness) {
    var discount =
        calculateDiscount(product.price!.mrp, product.price!.sellingPrice);
    return Wrap(
      children: [
        Text(
          "${CommonHelper.currencySymbol()}${product.price?.sellingPrice ?? 0}",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        if (discount > 0) ...[
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text('-${discount.toStringAsFixed(0)}%',
                  style: const TextStyle(color: const Color(0xFF059669))))
        ]
      ],
    );
  }

  calculateDiscount(mrp, sellingPrice) {
    if (mrp == 0) return 0;
    return ((mrp - sellingPrice) / mrp) * 100;
  }
}
