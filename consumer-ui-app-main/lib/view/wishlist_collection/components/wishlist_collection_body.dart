// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/wishlist_collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/size_config.dart';

class WishlistCollectionBody extends StatelessWidget {
  WishlistCollectionBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final WishlistCollectionController _controller;

  @override
  Widget build(BuildContext context) {
    // print("wishlistCollection--->>>>:override ${_controller.productList.map((e) => e.toJson()).toList()}");

    return
        // Obx(() =>
        Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Three dots button for menu options
        Expanded(
          // height: MediaQuery.of(context).size.height - 100,
          child: Obx(() {
            if (_controller.isLoading.value) {
              return const Center(child: const CircularProgressIndicator());
            } else if (_controller.productList.value.isNotEmpty) {
              return RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: _controller.refreshPage,
                child: Stack(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      controller: _controller.scrollController,
                      itemCount: _controller.productList.value.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                        controller: _controller,
                        product: _controller.productList.value[index],
                      ),
                    ),
                    Obx(() {
                      return _controller.loading.value
                          ? Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 80.0,
                                child: const Center(
                                    child: const CircularProgressIndicator()),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                ),
              );
            } else {
              return const Center(child: const Text('No Product!'));
            }
          }),
        ),
      ],
    );
    // );
  }
}

class ItemCard extends StatelessWidget {
  final dynamic product;

  const ItemCard({Key? key, required this.product, required controller})
      : _controller = controller,
        super(key: key);

  final WishlistCollectionController _controller;

  @override
  Widget build(BuildContext context) {
    void _showRemoveFromCollectionSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Remove from Collection",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.deleteCollection(product);
                  Navigator.of(context).pop();
                },
                child: const Text("Continue",
                    style: const TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.w500)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        _controller.navigateToProductDetails(product);
      },
      child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(width: 1.0, color: Color.fromARGB(255, 225, 222, 222)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(
                    // height: 280,
                    width: SizeConfig.screenWidth / 2 - 0,
                    child: CachedNetworkImageWidget(
                      image:
                          '${productImageUrl + product.imageId.toString() + '/' + "420-560" + '/'}${product.images != null ? product.images.imageName.toString() : ''}',
                    ),
                  ),
                  product.isOutofstock
                      ? Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: SizeConfig.screenWidth / 2 - 20,
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
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: _showRemoveFromCollectionSheet,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ),
                    ],
                  ),
                  if (product.showPrice) buildProductPrice(product),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            // SizedBox(width: 125),
          ],
        ),
      ),
    );
  }

  Column buildProductPrice(product) {
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
                  '${product.price.currencySymbol}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
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
                        product.price.currencySymbol +
                            product.price.mrp.toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      )),
                Text(
                  product.price.currencySymbol +
                      product.price.sellingPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ]
            ],
          ))
        ]);
  }
}
