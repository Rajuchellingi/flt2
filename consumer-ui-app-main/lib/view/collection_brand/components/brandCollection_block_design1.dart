// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use, unused_element

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/collection_brand/components/branCcollection_related_products_by_collection.dart';
import 'package:black_locust/view/collection_brand/components/brandCollection_related_products.dart';
import '../../../common_component/quick_cart.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/collection_V2_model.dart';

class BrandCollectionBlockDesign7 extends StatelessWidget {
  BrandCollectionBlockDesign7(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var collectionData = _controller.collectionData.value.collection;
    // print("collectionData: ${collectionData.toJson()}");

    // print(
    //     "_controller.productList.value: ${_controller.productList.value.map((e) => e.toJson()).toList()}");
    var collectionCatalog = collectionData.collectionCatalog;
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;

    return Obx(() => Container(
          color: Colors.white, // ✅ Apply background color
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_controller.collectionData.value.collection
                                  .showDownloadCatalog ==
                              true &&
                          (_controller.collectionData.value?.collection
                                      ?.catalogUrl !=
                                  null ||
                              _controller.collectionData.value.collection
                                      .collectionCatalog !=
                                  null))
                        _buildCatalogDownloadButton(
                            collectionData, collectionCatalog),
                      if (_controller.selectedProducts.value.length > 0)
                        _buildMultiBookingButton()
                    ],
                  ),
                  Expanded(
                    child: _controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          )
                        : (_controller.productList.value != null &&
                                _controller.productList.value.length > 0)
                            ? _buildProductList(footer)
                            : const Center(
                                child: Text('No Products Found!'),
                              ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildMultiBookingButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 15, 5),
        alignment: Alignment.centerRight,
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
              style: TextStyle(color: kSecondaryColor)),
        ));
  }

  Widget _buildCatalogDownloadButton(
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
                  style: TextStyle(color: kSecondaryColor)),
            )
          : _buildCatalogDropdown(collectionData, collectionCatalog),
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
            style: TextStyle(color: Colors.white),
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

  Widget _buildProductList(dynamic footer) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: _controller.refreshPage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          Obx(() => SingleChildScrollView(
              controller: _controller.scrollController,
              child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Container(
                        width: SizeConfig.screenWidth,
                        child: const SizedBox(height: 5)),
                    ..._buildProductItems(),
                    SizedBox(height: 5),
                    if (_controller.isRelatedProduct.value &&
                        _controller.relatedProducts.value.length > 0 &&
                        _controller.allLoaded.value == true)
                      Container(
                          width: SizeConfig.screenWidth,
                          child: BrandCollectionRelatedProducts(
                              controller: _controller,
                              design: relatedProductBlock(),
                              products: _controller.relatedProducts.value)),
                    if (_controller.productCollections.value.length > 0 &&
                        _controller.allLoaded.value == true) ...[
                      Container(
                          width: SizeConfig.screenWidth,
                          child: BrandCollectionRelatedProductsByCollection(
                              controller: _controller)),
                    ],
                    if (footer != null &&
                        footer.isNotEmpty &&
                        themeController.bottomBarType.value == 'design1' &&
                        footer['componentId'] == 'footer-navigation')
                      SizedBox(
                        height: 80,
                        width: SizeConfig.screenWidth,
                      ),
                  ]))),
          Obx(() => _controller.loading.value
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80.0,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                )
              : Container())
        ]),
      ),
    );
  }

  List<Widget> _buildProductItems() {
    return List.generate(
      _controller.productList.value.length,
      (i) => Container(
        width: _controller.productWidth(_controller.viewType.value, i, 15),
        child: ItemCard(
          index: i,
          design: design,
          ratingWidget: commonReviewController.isLoading.value == false
              ? commonReviewController
                  .ratingsWidget(_controller.productList.value[i].sId)
              : null,
          product: _controller.productList.value[i],
          controller: _controller,
        ),
      ),
    );
  }

  relatedProductBlock() {
    var blocks = _controller.template.value['layout']['blocks'];
    if (blocks != null && blocks.isNotEmpty) {
      var data = blocks.firstWhere(
          (element) => element['componentId'] == 'related-products',
          orElse: () => null);
      if (data != null) return data;
    }
  }
}

class ItemCard extends StatelessWidget {
  final _controller;
  final BrandProduct product;
  final design;
  final index;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();
  final ratingWidget;
  final productSettingController = Get.find<ProductSettingController>();

  ItemCard({
    Key? key,
    required this.product,
    this.ratingWidget,
    required this.index,
    required this.design,
    required controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = themeController.instance('product');
    // print("product:========================>>>> ${product.toJson()}");
    return Obx(() => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            _controller.navigateToProductDetails(product);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildProductImage(instance),
              if (_controller.viewType.value != 'small') ...[
                const SizedBox(height: 5),
                _buildProductDetails(instance),
              ],
            ],
          ),
        )));
  }

  Widget _buildProductImage(dynamic instance) {
    // print(
    //     "productImageUrl ---->>> ${productImageUrl + product.image!.imageId! + "/" + "420-560" + "/" + product.image!.imageName!.toString()}");
    return Stack(
      children: [
        Container(
          height: _controller.productHeight(_controller.viewType.value, index),
          width:
              _controller.productWidth(_controller.viewType.value, index, 15),
          child: CachedNetworkImageWidget(
            fill: BoxFit.cover,
            image: product.image!.imageName! != null
                ? platform == 'shopify'
                    ? _controller.assignProductImage(product.image!.imageName!,
                        _controller.viewType.value, index)
                    : productImageUrl +
                        product.image!.imageId! +
                        "/" +
                        "420-560" +
                        "/" +
                        product.image!.imageName!.toString()
                : '',
          ),
        ),
        // if (product.availableForSale == false &&
        //     _controller.viewType.value != 'small')
        //   Positioned.fill(
        //     child: Container(
        //       color: Colors.white.withOpacity(0.8),
        //       child: const Center(
        //         child: Text(
        //           "OUT OF STOCK",
        //           style: TextStyle(
        //             color: Colors.red,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // if (_controller.viewType.value != 'small') ...[
        //   if (instance != null && instance['source']['show-wishlist'] == true)
        //     _buildWishlistButton(),
        // if (instance != null &&
        //     instance['source']['show-add-to-cart'] == true)
        // _buildAddToCartButton(),
        // if (product.ribbon != null) _buildRibbon(product.ribbon!),
        // if (_controller.collectionData.value.multiBooking == true) ...[
        //   _buildSelectOption(product.sId, product.ribbon != null ? 10.0 : 0.0)
        // ]
        // ]
      ],
    );
  }

  Widget _buildSelectOption(productId, top) {
    return Positioned(
        top: top,
        left: 0,
        child: Checkbox(
          activeColor: kPrimaryColor,
          value: _controller.selectedProducts.contains(productId),
          onChanged: (bool? value) {
            _controller.changeSelectedProducts(productId);
          },
        ));
  }

  Widget _buildRibbon(CollectionRibbonVM ribbon) {
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
        style: IconButton.styleFrom(
          backgroundColor: kPrimaryColor,
        ),
        padding: const EdgeInsets.all(5),
        icon: const Icon(Icons.add_sharp),
        iconSize: 18,
        color: kSecondaryColor,
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            context: Get.context!,
            routeSettings: RouteSettings(arguments: Get.arguments),
            builder: (BuildContext context) {
              return QuickCart(
                title: product.productName,
                product: product,
                image: product.image!.imageName! != null
                    ? platform == 'shopify'
                        ? '${product.image!.imageName!}&width=400'
                        : product.image!.imageName!.toString()
                    : '',
                price: product.price!.sellingPrice,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(dynamic instance) {
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
            ),
          ),
          kDefaultHeight(5),
          if (product.showPrice == true) ...[
            if (platform == 'shopify')
              buildShopifyProductPrice(product)
            else
              buildRietailProductPrice(product)
          ],
          Container(child: ratingWidget),
          if (instance != null &&
              instance['source']['show-variants'] == true) ...[
            // buildAvailableOptions(product),--------------------------------------------------this
          ],
        ],
      ),
    );
  }

  buildAvailableOptions(ProductCollectionListVM product) {
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
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
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE5E5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFFFCCCC),
              width: 0.5,
            ),
          ),
          child: _buildPriceText(product, productSetting),
        ),
      ],
    );
  }

  Widget _buildPriceText(product, productSetting) {
    String priceText = "";
    TextStyle priceStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color(0xFFE74C3C), // Orange/red color like in image
    );

    if (product.type == 'set' || product.type == 'pack') {
      if (productSetting.priceDisplayType == 'mrp') {
        priceText =
            'MRP: ${product.price.currencySymbol}${product.price?.mrp} / Piece';
      } else {
        priceText =
            '${product.price.currencySymbol}${product.price?.sellingPrice} / Piece';
      }
    } else {
      if (productSetting.priceDisplayType == 'mrp-and-selling-price' &&
          product.price.mrp != 0 &&
          product.price.mrp != null &&
          product.price.mrp != product.price.sellingPrice) {
        // Show both MRP (crossed) and selling price
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${product.price.currencySymbol}${product.price.mrp} ',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text:
                    '${product.price.currencySymbol}${product.price.sellingPrice}',
                style: priceStyle,
              ),
            ],
          ),
        );
      } else if (productSetting.priceDisplayType == 'mrp') {
        priceText = 'MRP: ${product.price.currencySymbol}${product.price.mrp}';
      } else {
        priceText =
            '${product.price.currencySymbol}${product.price.sellingPrice}';
      }
    }

    return Text(
      priceText,
      textAlign: TextAlign.center,
      style: priceStyle,
    );
  }

  Column buildShopifyProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
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

            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
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
