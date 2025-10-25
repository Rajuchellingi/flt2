// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use, must_be_immutable

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

import '../../../model/collection_V2_model.dart';

class CollectionBlockDesign1 extends StatelessWidget {
  CollectionBlockDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var collectionData = _controller.collectionData.value;
    var collectionCatalog = collectionData.collectionCatalog;
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;
  //   return Obx(() {
  //     final isLoading = _controller.isLoading.value;
  //     final productList = _controller.productList.value;

  //     if (isLoading) {
  //       return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
  //     }

  //     if (productList.isEmpty) {
  //       return const Center(child: Text('No Products Found!'));
  //     }

  //     return _buildProductList(collectionData, collectionCatalog, footer);
  //   });
  // }

  // Widget _buildProductList(dynamic collectionData, dynamic collectionCatalog, dynamic footer) {
  //   return RefreshIndicator(
  //     color: kPrimaryColor,
  //     onRefresh: _controller.refreshPage,
  //     child: Stack(
  //       children: [
  //         _buildSliverList(collectionData, collectionCatalog, footer),
  //         _buildLoadingIndicator(),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSliverList(dynamic collectionData, dynamic collectionCatalog, dynamic footer) {
  //   return Obx(() {
  //     final productList = _controller.productList.value;
  //     final viewType = _controller.viewType.value;

  //     return CustomScrollView(
  //       controller: _controller.scrollController,
  //       cacheExtent: 2000,
  //       slivers: [
  //         // Catalog buttons
  //         SliverToBoxAdapter(
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Wrap(
  //               spacing: 7,
  //               alignment: WrapAlignment.start,
  //               crossAxisAlignment: WrapCrossAlignment.start,
  //               children: [
  //                 if (_controller.collectionData.value.showDownloadCatalog == true &&
  //                     (_controller.collectionData.value?.catalogUrl != null ||
  //                         _controller.collectionData.value.collectionCatalog != null))
  //                   _buildCatalogDownloadButton(collectionData, collectionCatalog),
  //                 if (_controller.selectedProducts.value.length > 0) ...[
  //                   _buildMultiBookingButton(),
  //                   _shareCatalogButton()
  //                 ],
  //                 if (_controller.selectedProducts.value.length > 0 &&
  //                     _controller.collectionData.value.showDownloadCatalog == true &&
  //                     _controller.userId != null) ...[
  //                   _downloadCatalogButton()
  //                 ],
  //                 if (_controller.selectedProducts.value.length > 0) ...[
  //                   _clearSelectionButton()
  //                 ],
  //               ],
  //             ),
  //           ),
  //         ),

  //         // Product grid
  //         SliverPadding(
  //           padding: const EdgeInsets.all(10),
  //           sliver: SliverGrid(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: _getCrossAxisCount(viewType),
  //               mainAxisSpacing: 10,
  //               crossAxisSpacing: 10,
  //               childAspectRatio: _getAspectRatio(viewType),
  //             ),
  //             delegate: SliverChildBuilderDelegate(
  //               (context, index) {
  //                 final product = productList[index];

  //                 return RepaintBoundary(
  //                   key: ValueKey(product.sId),
  //                   child: ItemCard(
  //                     index: index,
  //                     design: design,
  //                     product: product,
  //                     controller: _controller,
  //                   ),
  //                 );
  //               },
  //               childCount: productList.length,
  //               addAutomaticKeepAlives: false,
  //               findChildIndexCallback: (Key key) {
  //                 if (key is ValueKey<String>) {
  //                   final index = productList.indexWhere((p) => p.sId == key.value);
  //                   return index >= 0 ? index : null;
  //                 }
  //                 return null;
  //               },
  //             ),
  //           ),
    return Obx(() => Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                      spacing: 7,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        if (_controller
                                    .collectionData.value.showDownloadCatalog ==
                                true &&
                            (_controller.collectionData.value?.catalogUrl !=
                                    null ||
                                _controller.collectionData.value
                                        .collectionCatalog !=
                                    null))
                          _buildCatalogDownloadButton(
                              collectionData, collectionCatalog),
                        if (_controller.selectedProducts.value.length > 0) ...[
                          _buildMultiBookingButton(),
                          if (_controller.userId != null) _shareCatalogButton()
                        ],
                        if (_controller.selectedProducts.value.length > 0 &&
                            _controller
                                    .collectionData.value.showDownloadCatalog ==
                                true &&
                            _controller.userId != null) ...[
                          _downloadCatalogButton()
                        ],
                        if (_controller.selectedProducts.value.length > 0 &&
                            _controller.userId != null) ...[
                          _clearSelectionButton()
                        ],
                      ])),
              _controller.isLoading.value
                  ? const Center(
                      child: const CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : (_controller.productList.value != null &&
                          _controller.productList.value.length > 0)
                      ? Expanded(child: _buildProductList(footer))
                      : const Center(
                          child: const Text('No Products Found!'),
                        ),
            ],
          ),

          // Related products
          if (_controller.allLoaded.value && _controller.isRelatedProduct.value)
            _buildRelatedProductsSliver(),

          // Bottom spacing for footer
          if (footer != null &&
              footer.isNotEmpty &&
              themeController.bottomBarType.value == 'design1' &&
              footer['componentId'] == 'footer-navigation')
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
        ],
      )
    );
  }

  Widget _buildProductList(dynamic footer) {
    return Obx(() {
      final productList = _controller.productList.value;
      final viewType = _controller.viewType.value;

      return RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: _controller.refreshPage,
        child: Stack(
          children: [
            GridView.builder(
              controller: _controller.scrollController,
              itemCount: productList.length,
              cacheExtent: 2000,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(viewType),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: _getAspectRatio(viewType),
              ),
              itemBuilder: (context, index) {
                final product = productList[index];
                return RepaintBoundary(
                  key: ValueKey(product.sId),
                  child: ItemCard(
                    index: index,
                    design: design,
                    product: product,
                    controller: _controller,
                  ),
                );
              },
            ),
            _buildLoadingIndicator(),
          ],
        ),
      );
    });
  }

  int _getCrossAxisCount(String viewType) {
    switch (viewType) {
      case 'small':
        return 4;
      case 'large':
        return 1;
      case 'medium':
        return 2;
      default:
        return 2;
    }
  }

  double _getAspectRatio(String viewType) {
    switch (viewType) {
      case 'small':
        return 1.0;
      case 'large':
        return 1.0;
      default:
        return 0.65;
    }
  }

  Widget _buildRelatedProductsSliver() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          if (_controller.relatedProducts.value.isNotEmpty)
            CollectionRelatedProducts(
              controller: _controller,
              design: _getRelatedProductBlock(),
              products: _controller.relatedProducts.value,
            ),
          if (_controller.productCollections.value.isNotEmpty)
            CollectionRelatedProductsByCollection(controller: _controller),
        ],
      ),
    );
  }

  dynamic _getRelatedProductBlock() {
    final blocks = _controller.template.value['layout']?['blocks'];
    if (blocks != null) {
      return blocks.firstWhereOrNull(
        (element) => element['componentId'] == 'related-products',
      );
    }
    return null;
  }

  Widget _buildLoadingIndicator() {
    return Obx(() => _controller.loading.value
        ? const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 80.0,
              child: Center(child: CircularProgressIndicator(color: kPrimaryColor)),
            ),
          )
        : const SizedBox.shrink());
  }

  Widget _buildMultiBookingButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            _controller.openCreateMultiBooking();
          },
          child: Text(
              "Create Booking (${_controller.selectedProducts.value.length})",
              style: const TextStyle(color: kSecondaryColor)),
        ));
  }

  Widget _shareCatalogButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            showDialog(
              context: Get.context!,
              builder: (context) =>
                  _ShareCatalogDialog(controller: _controller),
            );
          },
          child: const Text("Share Catalog",
              style: TextStyle(color: kSecondaryColor)),
        ));
  }

  Widget _downloadCatalogButton() {
    return Container(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {
        _controller.downloadProductCatalogByProductIds();
      },
      child: const Text("Download Catalog",
          style: TextStyle(color: kSecondaryColor)),
    ));
  }

  Widget _clearSelectionButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: IconButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              _controller.selectedProducts.value = [];
              _controller.isMultiSelect.value = false;
            },
            icon: IntrinsicWidth(
                child: Row(spacing: 5, children: const [
              Icon(Icons.clear),
              Text("Clear Selection", style: TextStyle(color: Colors.white)),
              SizedBox(width: 5)
            ]))));
  }

  Widget _buildCatalogDownloadButton(
      dynamic collectionData, dynamic collectionCatalog) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
              : const SizedBox.shrink(),
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
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          onChanged: (selectedName) {
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
          },
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
}

class ItemCard extends StatelessWidget {
  final _controller;
  final ProductCollectionListVM product;
  final design;
  final index;

  const ItemCard({
    Key? key,
    required this.product,
    required this.index,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onLongPress: _handleLongPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _buildProductImage()),
          if (_shouldShowDetails()) ...[
            const SizedBox(height: 5),
            _buildProductDetails(),
          ],
        ],
      ),
    );
  }

  void _handleTap() {
    if (_controller.isMultiSelect.value) {
      _controller.changeSelectedProducts(product.sId);
    } else {
      _controller.navigateToProductDetails(product);
    }
  }

  void _handleLongPress() {
    if (_controller.collectionData.value.multiBooking == true) {
      _controller.changeSelectedProducts(product.sId);
      _controller.isMultiSelect.value = true;
    }
  }

  bool _shouldShowDetails() {
    return _controller.viewType.value != 'small';
  }

  Widget _buildProductImage() {
    final themeController = Get.find<ThemeController>();
    final instance = themeController.instance('product');
    final viewType = _controller.viewType.value;

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImageWidget(
          fill: BoxFit.cover,
          image: _getOptimizedImageUrl(),
          width: _getImageWidth(viewType),
        ),
        if (product.availableForSale == false && viewType != 'small')
          _buildOutOfStockOverlay(),
        if (viewType != 'small') ..._buildOverlayButtons(instance),
      ],
    );
  }

  String _getOptimizedImageUrl() {
    if (product.imageUrl == null) return '';

    if (platform == 'shopify') {
      final viewType = _controller.viewType.value;
      return _controller.assignProductImage(product.imageUrl, viewType, index);
    }
    return product.imageUrl!;
  }

  int _getImageWidth(String viewType) {
    switch (viewType) {
      case 'small':
        return 100;
      case 'large':
        return 500;
      default:
        return 200;
    }
  }

  List<Widget> _buildOverlayButtons(dynamic instance) {
    return [
      if (instance?['source']?['show-wishlist'] == true)
        _buildWishlistButton(),
      if (instance?['source']?['show-add-to-cart'] == true)
        _buildAddToCartButton(),
      if (product.ribbon != null) _buildRibbon(),
      Obx(() {
        if (_controller.isMultiSelect.value) {
          return _buildSelectCheckbox();
        }
        return const SizedBox.shrink();
      }),
    ];
  }

  Widget _buildOutOfStockOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: const Center(
          child: Text(
            "OUT OF STOCK",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectCheckbox() {
    return Positioned(
      top: product.ribbon != null ? 40.0 : 10.0,
      left: 10,
      child: Obx(() => Checkbox(
            activeColor: kPrimaryColor,
            value: _controller.selectedProducts.contains(product.sId),
            onChanged: (_) => _controller.changeSelectedProducts(product.sId),
          )),
    );
  }

  Widget _buildRibbon() {
    return Positioned(
      top: 2,
      left: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Color(int.parse(product.ribbon!.colorCode!.replaceAll('#', '0xff'))),
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

  Widget _buildWishlistButton() {
    return Positioned(
      top: 10,
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
      bottom: 10,
      right: 10,
      child: IconButton.filledTonal(
        style: IconButton.styleFrom(backgroundColor: kPrimaryColor),
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
                title: product.productName,
                product: product,
                image: product.imageUrl != null
                    ? platform == 'shopify'
                        ? '${product.imageUrl}&width=200'
                        : product.imageUrl.toString()
                    : '',
                price: product.price!.sellingPrice,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductDetails() {
    final themeController = Get.find<ThemeController>();
    final instance = themeController.instance('product');
    final commonReviewController = Get.find<CommonReviewController>();

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:
                _controller.productWidth(_controller.viewType.value, index, 30),
            child: Text(
              product.productName.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenWidth(13),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          kDefaultHeight(5),
          if (product.showPrice == true) ...[
            if (platform == 'shopify')
              buildShopifyProductPrice(product)
            else
              buildRietailProductPrice(product)
          ],
          Obx(() {
            if (commonReviewController.isLoading.value) {
              return const SizedBox.shrink();
            }
            return commonReviewController.ratingsWidget(product.sId) ??
                const SizedBox.shrink();
          }),
          if (instance != null &&
              instance['source']['show-variants'] == true) ...[
            buildAvailableOptions(product),
          ],
        ],
      ),
    );
  }

  buildAvailableOptions(ProductCollectionListVM product) {
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
    final brightness = Theme.of(Get.context!).brightness;
    final productSettingController = Get.find<ProductSettingController>();
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
                                fontWeight: FontWeight.w600, fontSize: 12),
                          )
                        : Text(
                            '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
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
                                ? Colors.grey
                                : Colors.black),
                      )),
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
          ))
        ]);
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
                      fontWeight: FontWeight.w600, fontSize: 12),
                ))
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
                                : Colors.black),
                      )),
                Text(
                  CommonHelper.currencySymbol() +
                      product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          ))
        ]);
  }
}

class _ShareCatalogDialog extends StatelessWidget {
  _ShareCatalogDialog({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Share Catalogue',
              style: TextStyle(fontSize: 19, color: Colors.black)),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Obx(() => Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Select Option',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _controller.selectedCatalogOption.value,
                  items: const [
                    DropdownMenuItem(
                        value: 'email', child: Text('Share via Email')),
                    DropdownMenuItem(
                        value: 'whatsapp', child: Text('Share via Whatsapp')),
                  ],
                  onChanged: (val) {
                    _controller.selectedCatalogOption.value = val!;
                  },
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor))),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (_controller.selectedCatalogOption.value == 'email') ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email Address',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.catalogEmailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Email Address',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  )
                ],
                if (_controller.selectedCatalogOption.value == 'whatsapp') ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('WhatsApp Number',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.catalogWhatsappController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter WhatsApp Number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'WhatsApp number is required';
                      }
                      if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  )
                ],
              ],
            ),
          )),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _controller.shareCatalog();
            }
          },
          child: const Text('Share'),
        ),
      ],
    );
  }
}
