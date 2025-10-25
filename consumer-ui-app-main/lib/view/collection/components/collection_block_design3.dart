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

class CollectionBlockDesign3 extends StatelessWidget {
  CollectionBlockDesign3({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final commonReviewController = Get.find<CommonReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var collectionData = _controller.collectionData.value;
    var collectionCatalog = collectionData.collectionCatalog;
    var footer = _controller.template.value['layout'] != null
        ? _controller.template.value['layout']['footer']
        : null;
    return Obx(() => Stack(children: [
          Column(
            children: [
              if (_controller.collectionData.value.showDownloadCatalog ==
                      true &&
                  (_controller.collectionData.value?.catalogUrl != null ||
                      _controller.collectionData.value.collectionCatalog !=
                          null))
                // Container(
                //     margin: EdgeInsets.fromLTRB(10, 5, 15, 5),
                //     alignment: Alignment.centerRight,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: kPrimaryColor,
                //         foregroundColor: Colors.white,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //       ),
                //       onPressed: () {
                //         _controller.downloadCatalog();
                //       },
                //       child: Text(_controller
                //           .collectionData.value.downloadCatalogButtonName),
                //     )),
                Container(
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
                            _controller.downloadCatalog(
                                file.fileName, file.fileUrl);
                          },
                          child: Text(collectionData.downloadCatalogButtonName),
                        )
                      : Container(
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
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              onChanged: (selectedName) {
                                if (selectedName != null) {
                                  var selectedItem =
                                      collectionCatalog.firstWhere(
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
                                    _controller.selectedCatalog.value =
                                        selectedItem.name;
                                    _controller.downloadCatalog(
                                        selectedItem.fileName,
                                        selectedItem.fileUrl);
                                  }
                                }
                              },
                              items: collectionCatalog
                                  .map<DropdownMenuItem<String>>((item) {
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
                        ),
                ),
              Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : (_controller.productList.value != null &&
                              _controller.productList.value.length > 0)
                          ? RefreshIndicator(
                              color: kPrimaryColor,
                              onRefresh: _controller.refreshPage,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                                child:
                                                    const SizedBox(height: 5)),
                                            for (var i = 0;
                                                i <
                                                    _controller.productList
                                                        .value.length;
                                                i++)
                                              Container(
                                                  width:
                                                      _controller.productWidth(
                                                          _controller
                                                              .viewType.value,
                                                          i,
                                                          15),
                                                  child: ItemCard(
                                                    index: i,
                                                    design: design,
                                                    product: _controller
                                                        .productList.value[i],
                                                    ratingWidget: commonReviewController
                                                                .isLoading
                                                                .value ==
                                                            false
                                                        ? commonReviewController
                                                            .ratingsWidget(
                                                                _controller
                                                                    .productList
                                                                    .value[i]
                                                                    .sId,
                                                                color:
                                                                    kPrimaryColor,
                                                                emptyHeight:
                                                                    25.0,
                                                                showAverage:
                                                                    false)
                                                        : null,
                                                    controller: _controller,
                                                  )),
                                            const SizedBox(height: 5),
                                            if (_controller.isRelatedProduct.value &&
                                                _controller.relatedProducts
                                                        .value.length >
                                                    0 &&
                                                _controller.allLoaded.value ==
                                                    true)
                                              Container(
                                                  width: SizeConfig.screenWidth,
                                                  child: CollectionRelatedProducts(
                                                      controller: _controller,
                                                      design:
                                                          relatedProductBlock(),
                                                      products: _controller
                                                          .relatedProducts
                                                          .value)),
                                            if (_controller.productCollections
                                                        .value.length >
                                                    0 &&
                                                _controller.allLoaded.value ==
                                                    true) ...[
                                              Container(
                                                  width: SizeConfig.screenWidth,
                                                  child:
                                                      CollectionRelatedProductsByCollection(
                                                          controller:
                                                              _controller))
                                            ],
                                            if (footer != null &&
                                                footer.isNotEmpty &&
                                                themeController
                                                        .bottomBarType.value ==
                                                    'design1' &&
                                                footer['componentId'] ==
                                                    'footer-navigation')
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
                                              child:
                                                  const CircularProgressIndicator(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container())
                                ]),
                              ))
                          : Center(
                              child: Text('No Record Found!',
                                  style: TextStyle(
                                      color: brightness == Brightness.dark
                                          ? Colors.white
                                          : kPrimaryTextColor)),
                            ))
            ],
          ),
        ]));
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
  final ratingWidget;
  final productSettingController = Get.find<ProductSettingController>();

  ItemCard(
      {Key? key,
      required this.product,
      required this.index,
      required this.design,
      this.ratingWidget,
      required controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var instance = themeController.instance('product');
    return Obx(() => GestureDetector(
        onTap: () {
          _controller.navigateToProductDetails(product);
        },
        child: Stack(children: [
          _controller.viewType.value == 'large'
              ? Stack(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              // Product Image with fixed height
                              Container(
                                height: 130,
                                width: 110,
                                // margin: EdgeInsets.only(bottom: 5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    child: CachedNetworkImageWidget(
                                        fill: BoxFit.cover,
                                        image: product.imageUrl != null
                                            ? platform == 'shopify'
                                                ? '${product.imageUrl}&width=270'
                                                : product.imageUrl.toString()
                                            : '')),
                              ),
                              // Out of Stock Overlay
                              if (product.availableForSale == false &&
                                  _controller.viewType.value != 'small')
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Product Name
                                  Container(
                                    width: SizeConfig.screenWidth - 160,
                                    child: Text(
                                      product.productName.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),

                                  // if (product.vendor != null) ...[
                                  //   Container(
                                  //       width: SizeConfig.screenWidth - 160,
                                  //       child: Text(
                                  //         product.vendor!,
                                  //         // textAlign: TextAlign.center,
                                  //         maxLines: 1,
                                  //         overflow: TextOverflow.ellipsis,
                                  //         style: const TextStyle(
                                  //             color: Colors.grey, fontSize: 12),
                                  //       ))
                                  // ],
                                  IntrinsicWidth(child: ratingWidget),
                                  if (product.showPrice == true) ...[
                                    kDefaultHeight(3),
                                    if (platform == 'shopify')
                                      buildShopifyProductPrice(
                                          product, instance)
                                    else
                                      buildRietailProductPrice(product)
                                  ],
                                ]),
                          )
                        ],
                      )),
                  if (instance != null &&
                      instance['source']['show-wishlist'] == true &&
                      _controller.viewType.value != 'small')
                    Positioned(
                      right: -2,
                      bottom: 0,
                      child: IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          elevation: 4,
                          shadowColor: Colors.grey.withOpacity(0.5),
                        ),
                        autofocus: _controller.wishlistFlag.value,
                        icon: _controller.getWishListonClick(product)
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_sharp),
                        iconSize: 18,
                        color: _controller.getWishListonClick(product)
                            ? Colors.red
                            : Colors.white,
                        onPressed: () {
                          if (platform == 'to-automation') {
                            _controller.openWishListPopup(product.sId, product);
                          } else {
                            _controller
                                .addProductToWishList(product.sId.toString());
                          }
                        },
                      ),
                    ),
                  // Add to Cart Button inside image
                  if (instance != null &&
                      instance['source']['show-add-to-cart'] == true &&
                      _controller.viewType.value != 'small')
                    Positioned(
                      right: 45,
                      bottom: 0,
                      child: IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          elevation: 4,
                          shadowColor: Colors.grey.withOpacity(0.5),
                        ),
                        constraints: BoxConstraints(),
                        padding: const EdgeInsets.all(12),
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.white),
                        iconSize: 18,
                        // color: Colors.black,
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return QuickCart(
                                design: 'design2',
                                title: product.productName,
                                product: product,
                                image: product.imageUrl != null
                                    ? platform == 'shopify'
                                        ? '${product.imageUrl}&width=270'
                                        : product.imageUrl.toString()
                                    : '',
                                price: product.price!.sellingPrice,
                              );
                            },
                          );
                        },
                      ),
                    ),
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        // Product Image with fixed height
                        Container(
                          height: _controller.productHeight(
                              _controller.viewType.value, index),
                          width: _controller.productWidth(
                              _controller.viewType.value, index, 15),
                          // margin: EdgeInsets.only(bottom: 5),
                          child: ClipRRect(
                              borderRadius:
                                  _controller.viewType.value == 'small'
                                      ? BorderRadius.circular(3)
                                      : BorderRadius.circular(10.0),
                              child: CachedNetworkImageWidget(
                                  fill: BoxFit.cover,
                                  image: product.imageUrl != null
                                      ? platform == 'shopify'
                                          ? _controller.assignProductImage(
                                              product.imageUrl,
                                              _controller.viewType.value,
                                              index)
                                          : product.imageUrl.toString()
                                      : '')),
                        ),
                        // Out of Stock Overlay
                        if (product.availableForSale == false &&
                            _controller.viewType.value != 'small')
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
                        // Wishlist Button inside image

                        // Ribbon inside image
                        // if (product.ribbon != null)
                        //   Positioned(
                        //     top: 2,
                        //     left: 2,
                        //     child: Container(
                        //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        //       decoration: BoxDecoration(
                        //         color: Color(
                        //           int.parse(
                        //             product.ribbon.colorCode!.replaceAll('#', '0xff'),
                        //           ),
                        //         ),
                        //         borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(10),
                        //           bottomRight: Radius.circular(10),
                        //         ),
                        //       ),
                        //       child: Text(
                        //         product.ribbon.name,
                        //         style: TextStyle(
                        //           fontSize: 10,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    if (_controller.viewType.value != 'small') ...[
                      // SizedBox(height: 5),
                      // Product Name and Price Section
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(child: ratingWidget),
                            // if (product.vendor != null) ...[
                            //   Container(
                            //       // margin: const EdgeInsets.only(top: 5),
                            //       width: SizeConfig.screenWidth / 3.5,
                            //       child: Text(
                            //         product.vendor!,
                            //         // textAlign: TextAlign.center,
                            //         maxLines: 1,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 12),
                            //       ))
                            // ] else ...[
                            //   const SizedBox(height: 20)
                            // ],
                            // Product Name
                            Container(
                              width: _controller.productWidth(
                                  _controller.viewType.value, index, 30),
                              child: Text(
                                product.productName.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: brightness == Brightness.dark
                                        ? Colors.white
                                        : kPrimaryTextColor,
                                    // color: kTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            if (product.showPrice == true) ...[
                              kDefaultHeight(2),
                              if (platform == 'shopify')
                                buildShopifyProductPrice(product, instance)
                              else
                                buildRietailProductPrice(product)
                            ],

                            // Available Sizes (conditionally displayed)
                            if (instance != null &&
                                instance['source']['show-variants'] ==
                                    true) ...[
                              // SizedBox(height: 5),
                              buildAvailableOptions(product),
                            ],
                          ],
                        ),
                      )
                    ],
                  ],
                ),
          if (instance != null &&
              instance['source']['show-wishlist'] == true &&
              _controller.viewType.value != 'small')
            Positioned(
              right: -4,
              top:
                  _controller.productHeight(_controller.viewType.value, index) -
                      27,
              child: IconButton.filledTonal(
                style: IconButton.styleFrom(backgroundColor: kPrimaryColor),
                autofocus: _controller.wishlistFlag.value,
                icon: _controller.getWishListonClick(product)
                    ? const Icon(Icons.favorite_sharp)
                    : const Icon(Icons.favorite_border_sharp),
                iconSize: 18,
                color: _controller.getWishListonClick(product)
                    ? Colors.red
                    : Colors.white,
                onPressed: () {
                  if (platform == 'to-automation') {
                    _controller.openWishListPopup(product.sId, product);
                  } else {
                    _controller.addProductToWishList(product.sId.toString());
                  }
                },
              ),
            ),
          if (product.ribbon != null && _controller.viewType.value != 'small')
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
          // Add to Cart Button inside image

          if (instance != null &&
              instance['source']['show-add-to-cart'] == true &&
              _controller.viewType.value != 'small')
            Positioned(
              right: -3.5,
              top:
                  _controller.productHeight(_controller.viewType.value, index) -
                      75,
              child: IconButton.filledTonal(
                style: IconButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                constraints: BoxConstraints(),
                padding: const EdgeInsets.all(12),
                icon: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.white),
                iconSize: 18,
                // color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return QuickCart(
                        design: 'design2',
                        title: product.productName,
                        product: product,
                        image: product.imageUrl != null
                            ? platform == 'shopify'
                                ? '${product.imageUrl}&width=270'
                                : product.imageUrl.toString()
                            : '',
                        price: product.price!.sellingPrice,
                      );
                    },
                  );
                },
              ),
            ),
        ])));
  }

  buildAvailableOptions(ProductCollectionListVM product) {
    final brightness = Theme.of(Get.context!).brightness;
    List<ProductSizeOptions> options = _controller.getAvailableOptions(product);
    if (options != null && options.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
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
                            color: variant.isAvailable!
                                ? brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor
                                : Colors.grey,
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
      );
    } else {
      return Container(); // Return an empty container if no options are available
    }
  }

  Column buildShopifyProductPrice(product, instance) {
    final brightness = Theme.of(Get.context!).brightness;

    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,

            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (product.type == 'set' || product.type == 'pack') ...[
                Container(
                    child: Text(
                  '${CommonHelper.currencySymbol()} ${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                ))
              ] else if (product.type != 'set' && product.type != 'pack') ...[
                if (product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        CommonHelper.currencySymbol() +
                            product.price.mrp.round().toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor),
                      )),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Text(
                      CommonHelper.currencySymbol() +
                          product.price.sellingPrice.round().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryColor)),
                ),
                if (instance['source']['show-discount'] == true &&
                    product.price.mrp != 0 &&
                    product.price.mrp != null &&
                    product.price.mrp != product.price.sellingPrice)
                  Text(
                    "Save ${calculateSavingsPercentage(product.price.mrp, product.price.sellingPrice)}%",
                    style: TextStyle(
                        color: Color(0XFFC20000),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  )
              ]
            ],
          )
        ]);
  }

  int calculateSavingsPercentage(double mrp, double sellingPrice) {
    if (mrp <= 0) return 0; // Avoid division by zero
    double saved = mrp - sellingPrice;
    return ((saved / mrp) * 100).round();
  }

  Column buildRietailProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;

    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,

            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (product.type == 'set' || product.type == 'pack') ...[
                Container(
                    child: productSetting.priceDisplayType == 'mrp'
                        ? Text(
                            'MRP : ${product.price.currencySymbol} ${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          )
                        : Text(
                            '${product.price.currencySymbol} ${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
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
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryTextColor),
                  )
                ] else ...[
                  Text(
                    product.price.currencySymbol +
                        product.price.sellingPrice.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryTextColor),
                  )
                ]
              ]
            ],
          )
        ]);
  }
}
