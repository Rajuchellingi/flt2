// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailAddToCartDeign1 extends StatelessWidget {
  ProductDetailAddToCartDeign1({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  final themeController = Get.find<ThemeController>();
  final SizeChartController sizeChartController =
      Get.find<SizeChartController>();
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(
      () {
        var firstImage = _controller.productPackImage.first;
        var image = '${firstImage.imageName}&width=150';
        var title = _controller.product.value.name;
        var price = _controller.product.value.price!.sellingPrice;
        return Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    width: 70,
                    height: 70,
                    child: CachedNetworkImageWidget(
                        fill: BoxFit.cover, image: image)),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Text(
                        CommonHelper.currencySymbol() + price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ]))
              ]),
              const SizedBox(height: 10),
              if (_controller.allVariants != null &&
                  _controller.allVariants.length > 0)
                for (var element in _controller.allVariants)
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            child: Text(
                              element.type.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            // width: (SizeConfig.screenWidth - 120),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    if (element.fieldValue != null &&
                                        element.fieldValue!.length > 0)
                                      if (element.fieldValue!.length == 1)
                                        for (var variant in element.fieldValue!)
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _controller
                                                          .getProductByVariant(
                                                              element.type,
                                                              variant
                                                                  .labelName);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 5,
                                                        horizontal: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: _controller
                                                                .selectedProductVariants
                                                                .value
                                                                .any((da) =>
                                                                    da['type'] ==
                                                                        element
                                                                            .type &&
                                                                    da['value'] ==
                                                                        variant
                                                                            .labelName)
                                                            ? brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? kPrimaryColor ==
                                                                        Colors
                                                                            .black
                                                                    ? Colors
                                                                        .white
                                                                    : kPrimaryColor
                                                                : kPrimaryColor
                                                            : null,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255,
                                                              198,
                                                              198,
                                                              198),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        variant.labelName
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: _controller
                                                                  .selectedProductVariants
                                                                  .value
                                                                  .any((da) =>
                                                                      da['type'] ==
                                                                          element
                                                                              .type &&
                                                                      da['value'] ==
                                                                          variant
                                                                              .labelName)
                                                              ? brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? kSecondaryColor ==
                                                                          Colors
                                                                              .white
                                                                      ? Colors
                                                                          .black
                                                                      : kSecondaryColor
                                                                  : kSecondaryColor
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          )
                                      else
                                        for (var variant in element.fieldValue!)
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _controller.getProductByVariant(
                                                    element.type,
                                                    variant.labelName);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: _controller
                                                          .selectedProductVariants
                                                          .value
                                                          .any((da) =>
                                                              da['type'] ==
                                                                  element
                                                                      .type &&
                                                              da['value'] ==
                                                                  variant
                                                                      .labelName)
                                                      ? brightness ==
                                                              Brightness.dark
                                                          ? kPrimaryColor ==
                                                                  Colors.black
                                                              ? Colors.white
                                                              : kPrimaryColor
                                                          : kPrimaryColor
                                                      : null,
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 198, 198, 198),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Text(
                                                  variant.labelName.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: _controller
                                                              .selectedProductVariants
                                                              .value
                                                              .any((da) =>
                                                                  da['type'] ==
                                                                      element
                                                                          .type &&
                                                                  da['value'] ==
                                                                      variant
                                                                          .labelName)
                                                          ? brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? kSecondaryColor ==
                                                                      Colors
                                                                          .white
                                                                  ? Colors.black
                                                                  : kSecondaryColor
                                                              : kSecondaryColor
                                                          : null),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
              const SizedBox(height: 10),
              Container(
                  width: SizeConfig.screenWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        _controller.productAddToCart(isPopup: true);
                      },
                      child: Text(
                        _controller.product.value.isOutofstock
                            ? "Add To Cart"
                            : "Notify Me",
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: brightness == Brightness.dark
                                ? kPrimaryColor == Colors.black
                                    ? Colors.white
                                    : kPrimaryColor
                                : kPrimaryColor),
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )))
            ]));
      },
    );
  }
}
