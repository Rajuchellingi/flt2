// ignore_for_file: unused_field, invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/quick_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/common_helper.dart';

class QuickCartDesign1 extends StatelessWidget {
  final image;
  final title;
  final price;
  final dynamic product;

  QuickCartDesign1(
      {Key? key,
      required this.product,
      required this.image,
      required this.price,
      required this.title})
      : super(key: key);
  final _controller = Get.find<QuickCartController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    Future.delayed(Duration(seconds: 1), () {
      _controller.getProductVaraiants(product.options);
    });
    return Obx(() {
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
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Text(
                      CommonHelper.currencySymbol() + price.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )
                  ]))
            ]),
            const SizedBox(height: 10),
            if (product.options != null && product.options.length > 0)
              for (var element in product.options)
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          child: Text(
                            element.name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                                  if (element.values != null &&
                                      element.values.length > 0)
                                    if (product.options.length == 1)
                                      for (var variant in _controller
                                          .getAvailableVariantOptions(
                                              product, element.name))
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (variant.isAvailable!)
                                                      _controller
                                                          .getProductByVariant(
                                                              element.name,
                                                              variant.name,
                                                              product);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: _controller
                                                              .selectedProductVariants
                                                              .value
                                                              .any((da) =>
                                                                  da['type'] ==
                                                                      element
                                                                          .name &&
                                                                  da['value'] ==
                                                                      variant
                                                                          .name)
                                                          ? brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? kPrimaryColor ==
                                                                      Colors
                                                                          .black
                                                                  ? Colors.white
                                                                  : kPrimaryColor
                                                              : kPrimaryColor
                                                          : variant.isAvailable ==
                                                                  false
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  219, 219, 219)
                                                              : null,
                                                      border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 198, 198, 198),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      variant.name.toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: _controller
                                                                .selectedProductVariants
                                                                .value
                                                                .any((da) =>
                                                                    da['type'] ==
                                                                        element
                                                                            .name &&
                                                                    da['value'] ==
                                                                        variant
                                                                            .name)
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
                                                if (!variant.isAvailable!)
                                                  Positioned.fill(
                                                    child: const Divider(
                                                      color: Colors.grey,
                                                      thickness: 1.0,
                                                    ),
                                                  ),
                                              ]),
                                        )
                                    else
                                      for (var variant in element.values!)
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _controller.getProductByVariant(
                                                  element.name,
                                                  variant.name,
                                                  product);
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
                                                                element.name &&
                                                            da['value'] ==
                                                                variant.name)
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
                                                variant.name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: _controller
                                                            .selectedProductVariants
                                                            .value
                                                            .any((da) =>
                                                                da['type'] ==
                                                                    element
                                                                        .name &&
                                                                da['value'] ==
                                                                    variant
                                                                        .name)
                                                        ? brightness ==
                                                                Brightness.dark
                                                            ? kSecondaryColor ==
                                                                    Colors.white
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
                      _controller.productAddToCart(product);
                    },
                    child: const Text("Add To Cart"),
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
    });
  }
}
