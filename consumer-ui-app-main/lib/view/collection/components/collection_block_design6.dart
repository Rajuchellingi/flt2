// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use

// import 'package:b2b_graphql_package/modules/collection/collection_model.dart';
import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/collection/components/collection_related_products.dart';
import 'package:black_locust/view/collection/components/collection_related_products_by_collection.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common_component/quick_cart.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/collection_V2_model.dart';

class CollectionBlockDesign6 extends StatelessWidget {
  CollectionBlockDesign6({Key? key, required controller, required this.design})
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
    return Obx(() => Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_controller.selectedProducts.value.length > 0 &&
                            _controller.userId != null) ...[
                          _clearSelectionButton(),
                          _shareCatalogButton()
                        ],
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
                      ])),
              if (_controller.selectedProducts.value.length > 0)
                _buildMultiBookingButton(),
              Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : (_controller.productList.value != null &&
                              _controller.productList.value.length > 0)
                          ? _buildProductList(footer)
                          : const Center(
                              child: const Text('No Products Found!'),
                            )),
            ],
          ),
          // if (_c,
        ]));
  }

  Widget _clearSelectionButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        alignment: Alignment.centerRight,
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
          icon: Icon(Icons.clear),
        ));
  }

  Widget _buildMultiBookingButton() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(spacing: 15, children: [
          Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                      "${_controller.selectedProducts.value.length} products selected",
                      style: TextStyle(color: kPrimaryLightColor)))),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    _controller.openCreateMultiBooking();
                  },
                  child: Container(
                      // width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Create Booking",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)))))
        ]));
  }

  Widget _shareCatalogButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        // alignment: Alignment.centerRight,
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
          child:
              Text("Share Catalog", style: TextStyle(color: kSecondaryColor)),
        ));
  }

  Widget _buildCatalogDownloadButton(
      dynamic collectionData, dynamic collectionCatalog) {
    print('collectionCatalog.length  ${collectionCatalog.length}');
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                          child: CollectionRelatedProducts(
                              controller: _controller,
                              design: relatedProductBlock(),
                              products: _controller.relatedProducts.value)),
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
  final ProductCollectionListVM product;
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
    var userId = GetStorage().read('utoken');
    return Obx(() => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            if (userId != null) {
              if (_controller.isMultiSelect.value) {
                _controller.changeSelectedProducts(product.sId);
              } else {
                _controller.navigateToProductDetails(product);
              }
            } else {
              if (_controller.isMultiSelect.value) {
                _controller.changeSelectedProducts(product.sId);
              } else {
                Get.toNamed(
                  '/login',
                );
              }
            }
          },
          onLongPress: () {
            if (_controller.collectionData.value.multiBooking == true) {
              _controller.changeSelectedProducts(product.sId);
              _controller.isMultiSelect.value = true;
            }
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
    return Obx(() {
      var isMultiSelect = _controller.isMultiSelect.value;
      return Stack(
        children: [
          Container(
            height:
                _controller.productWidth(_controller.viewType.value, index, 15),
            width:
                _controller.productWidth(_controller.viewType.value, index, 15),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImageWidget(
                  fill: BoxFit.cover,
                  image: product.imageUrl != null
                      ? platform == 'shopify'
                          ? _controller.assignProductImage(product.imageUrl,
                              _controller.viewType.value, index)
                          : product.imageUrl.toString()
                      : '',
                )),
          ),
          if (product.availableForSale == false &&
              _controller.viewType.value != 'small')
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
          if (_controller.viewType.value != 'small') ...[
            if (instance != null && instance['source']['show-wishlist'] == true)
              _buildWishlistButton(),
            if (instance != null &&
                instance['source']['show-add-to-cart'] == true)
              _buildAddToCartButton(),
            if (product.ribbon != null) _buildRibbon(product.ribbon!),
            if (isMultiSelect) ...[
              _buildSelectOption(
                  product.sId, product.ribbon != null ? 10.0 : 0.0)
            ]
          ]
        ],
      );
    });
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
        color: kPrimaryLightColor,
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
                image: product.imageUrl != null
                    ? platform == 'shopify'
                        ? '${product.imageUrl}&width=400'
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

  Widget _buildProductDetails(dynamic instance) {
    var userId = GetStorage().read('utoken');

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:
                _controller.productWidth(_controller.viewType.value, index, 40),
            child: Text(
              product.productName.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          // if (userId != null) {
          //   _controller.navigateToProductDetails(product);
          // } else {
          //   Get.toNamed(
          //     '/login',
          //   );
          // }
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userId != null ? "" : 'Login to details',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(13),
                  ),
                ),
                if (userId == null) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    // color: Colors.black,
                    size: 14,
                  ),
                ],
              ],
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
            buildAvailableOptions(product),
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
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (product.moq != null && product.moq > 0) ...[
                Text("MOQ: ${product.moq}", style: TextStyle(fontSize: 12)),
              ],
              if (product.type == 'set' || product.type == 'pack') ...[
                Container(
                    child: productSetting.priceDisplayType == 'mrp'
                        ? Text(
                            'MRP : ${product.price.currencySymbol}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / Piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          )
                        : Text(
                            '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / Piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Obx(() => Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Select Option',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _controller.selectedCatalogOption.value,
                  items: [
                    DropdownMenuItem(
                        value: 'email', child: Text('Share via Email')),
                    DropdownMenuItem(
                        value: 'whatsapp', child: Text('Share via Whatsapp')),
                  ],
                  onChanged: (val) {
                    _controller.selectedCatalogOption.value = val!;
                  },
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email Address',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.catalogEmailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Simple email validation
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  )
                ],
                if (_controller.selectedCatalogOption.value == 'whatsapp') ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('WhatsApp Number',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.catalogWhatsappController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
          child: Text('Share'),
        ),
      ],
    );
  }
}
