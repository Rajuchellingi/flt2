// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridCarouselPromotionDesign1 extends StatelessWidget {
  GridCarouselPromotionDesign1(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  final productSettingController = Get.find<ProductSettingController>();
  final commonReviewController = Get.find<CommonReviewController>();

  @override
  Widget build(BuildContext context) {
    var products = promotionProducts();
    int rowCount = design['source']['row-count'] ?? 2;
    final brightness = Theme.of(context).brightness;

    List<List<dynamic>> rows = List.generate(rowCount, (_) => []);

    for (int i = 0; i < products.length; i++) {
      rows[i % rowCount].add(products[i]);
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: rows.map((rowItems) {
              return Row(
                children: rowItems.map((item) {
                  return GestureDetector(
                      onTap: () {
                        _controller.navigateToProductDetails(item);
                      },
                      child: Container(
                        width: SizeConfig.screenWidth / 1.3,
                        margin: const EdgeInsets.all(8),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: SizeConfig.screenWidth / 4,
                                  width: SizeConfig.screenWidth / 4,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImageWidget(
                                        fill: BoxFit.cover,
                                        image: item.imageUrl != null
                                            ? platform == 'shopify'
                                                ? '${item.imageUrl}&width=170'
                                                : item.imageUrl.toString()
                                            : '',
                                      ))),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    const SizedBox(height: 7),
                                    Text(item.productName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            // color: Colors.black,
                                            color: brightness == Brightness.dark
                                                ? Colors.white
                                                : kPrimaryTextColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                    if (commonReviewController
                                            .isLoading.value ==
                                        false) ...[
                                      IntrinsicWidth(
                                          child: commonReviewController
                                              .ratingsWidget(item.sId,
                                                  color: kPrimaryColor,
                                                  showAverage: false)),
                                    ],
                                    if (item.showPrice == true) ...[
                                      kDefaultHeight(5),
                                      if (platform == 'shopify')
                                        buildShopifyProductPrice(item)
                                      else
                                        buildRietailProductPrice(item)
                                    ],
                                  ]))
                            ]),
                      ));
                }).toList(),
              );
            }).toList(),
          ),
        ));
  }

  Column buildRietailProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    final productSetting = productSettingController.productSetting.value;
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.type == 'set' || product.type == 'pack') ...[
                  Container(
                      child: productSetting.priceDisplayType == 'mrp'
                          ? Text(
                              'MRP : ${CommonHelper.currencySymbol()}${product.price?.mrp}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor),
                            )
                          : Text(
                              '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor),
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
                          CommonHelper.currencySymbol() +
                              product.price.mrp.toString(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor),
                        )),
                  Text(
                    CommonHelper.currencySymbol() +
                        product.price.sellingPrice.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  )
                ]
              ])
        ]);
  }

  Column buildShopifyProductPrice(product) {
    final brightness = Theme.of(Get.context!).brightness;
    // print("product ${product.toJson()}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.type == 'set' || product.type == 'pack') ...[
                  Container(
                      child: Text(
                    '${CommonHelper.currencySymbol()}${product.price?.sellingPrice}${product.type == "pack" || product.type == "set" ? " / piece" : ""}',
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
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          CommonHelper.currencySymbol() +
                              product.price.mrp.round().toString(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor),
                        )),
                  Text(
                    CommonHelper.currencySymbol() +
                        product.price.sellingPrice.round().toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  )
                ]
              ])
        ]);
  }

  promotionProducts() {
    var result = [];
    if (_controller.collectionProducts.value.length > 0) {
      var products = _controller.collectionProducts.value.firstWhere(
          (element) =>
              element['collection'] == design['source']['collection'] &&
              element['count'] == design['source']['count']);

      if (products != null) result = products['products'];
    }
    return result;
  }
}
