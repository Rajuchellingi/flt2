// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:black_locust/common_component/circle_icon_button.dart';
import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/wishlist_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/common_helper.dart';

class WishlistProductDesign1 extends StatelessWidget {
  const WishlistProductDesign1({
    Key? key,
    required controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);
  final design;
  final WishlistController _controller;
  @override
  Widget build(BuildContext context) {
    // print("productListDetailsssss ${_controller.toJson()}");

    Color primaryColor = Theme.of(context).primaryColor;
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: Obx(() => _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (_controller.wishlist != null &&
                      _controller.wishlist.length > 0)
                  ? RefreshIndicator(
                      color: kPrimaryColor,
                      onRefresh: () => _controller.refreshPage(),
                      child: GridView.builder(
                        controller: _controller.scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: _controller.wishlist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                          controller: _controller,
                          product: _controller.wishlist[index],
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: const Text(
                            'No Product!',
                            style: const TextStyle(fontSize: 18),
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
    ));
  }
}

class ItemCard extends StatelessWidget {
  final WishlistController _controller;
  final dynamic product;

  const ItemCard({
    Key? key,
    required controller,
    this.product,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // product.sId = product.productId;
        Get.toNamed('/productDetail',
            preventDuplicates: false, arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Container(
                    height: 280,
                    width: SizeConfig.screenWidth / 2,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1.0, color: Colors.grey))),
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
                    )),
                // Container(
                //   height: 280,
                //   width: SizeConfig.screenWidth / 2,
                //   decoration: BoxDecoration(
                //       border: Border(
                //           left: BorderSide(width: 1.0, color: Colors.grey))),
                //   child: CachedNetworkImage(
                //   imageUrl:  promotionImageBaseUri +
                //         product.imageId +
                //         '/' +
                //     product.images[0].imageName,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Positioned(
                    top: 8,
                    right: 10,
                    child: CircleIconButton(
                      icon: Icons.close,
                      height: 25,
                      width: 25,
                      color: kTextColor,
                      onPressed: () {
                        _controller.removeWishList(product.sId);
                      },
                    ))
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.name != null)
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          if (product.price!.maxPrice != null &&
              product.price!.maxPrice != 0 &&
              product.price.maxPrice != product.price.minPrice)
            Text(
              CommonHelper.currencySymbol() + product.price.mrp.toString(),
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            ),
          const SizedBox(width: 10),
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
