// ignore_for_file: unnecessary_null_comparison, unused_element, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_add_to_cart_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailVariantDesign4 extends StatelessWidget {
  ProductDetailVariantDesign4(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();
  final SizeChartController sizeChartController =
      Get.find<SizeChartController>();

  @override
  Widget build(BuildContext context) {
    // final brightness = Theme.of(context).brightness;
    return (_controller.allVariants != null &&
            _controller.allVariants.isNotEmpty)
        ? Obx(() => Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Wrap(runSpacing: 10, spacing: 10, children: [
                    for (var element in _controller.allVariants)
                      InkWell(
                        child: Container(
                          width: (SizeConfig.screenWidth - 80) / 2,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(children: [
                            Expanded(
                                child: Text(variantName(element),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis))),
                            const SizedBox(width: 7),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.white)
                          ]),
                        ),
                        onTap: () {
                          openAddToCart(context);

                          // showModalBottomSheet(
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.vertical(
                          //       top: Radius.circular(30),
                          //     ),
                          //   ),
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.vertical(
                          //             top: Radius.circular(30),
                          //           ),
                          //           color: brightness == Brightness.dark
                          //               ? Colors.black
                          //               : Colors.white,
                          //         ),
                          //         width: SizeConfig.screenWidth,
                          //         padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                          //         child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Center(
                          //                   child: Container(
                          //                       width: 50,
                          //                       height: 5,
                          //                       decoration: BoxDecoration(
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   7),
                          //                           color: Colors.grey))),
                          //               SizedBox(height: 15),
                          //               Container(
                          //                   child: Text(
                          //                 'Select ${element.type.toString()}',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 17),
                          //               )),
                          //               SizedBox(
                          //                 height: 10,
                          //               ),
                          //               Wrap(
                          //                 runSpacing: 5,
                          //                 spacing: 5,
                          //                 children: [
                          //                   for (var variant
                          //                       in element.fieldValue ?? [])
                          //                     Padding(
                          //                       padding:
                          //                           const EdgeInsets.all(3.0),
                          //                       child: GestureDetector(
                          //                         onTap: () {
                          //                           _controller
                          //                               .getProductByVariant(
                          //                             element.type,
                          //                             variant.labelName,
                          //                           );
                          //                           Get.back();
                          //                         },
                          //                         child: Obx(
                          //                           () => Container(
                          //                             padding: const EdgeInsets
                          //                                 .symmetric(
                          //                               vertical: 7,
                          //                               horizontal: 15,
                          //                             ),
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(5),
                          //                               color: _controller
                          //                                       .selectedProductVariants
                          //                                       .any((da) =>
                          //                                           da['type'] ==
                          //                                               element
                          //                                                   .type &&
                          //                                           da['value'] ==
                          //                                               variant
                          //                                                   .labelName)
                          //                                   ? kPrimaryColor
                          //                                   : null,
                          //                               border: Border.all(
                          //                                 color: _controller
                          //                                         .selectedProductVariants
                          //                                         .any((da) =>
                          //                                             da['type'] ==
                          //                                                 element
                          //                                                     .type &&
                          //                                             da['value'] ==
                          //                                                 variant
                          //                                                     .labelName)
                          //                                     ? kPrimaryColor
                          //                                     : brightness ==
                          //                                             Brightness
                          //                                                 .dark
                          //                                         ? Colors.white
                          //                                         : Colors
                          //                                             .black,
                          //                                 width: 1.0,
                          //                               ),
                          //                             ),
                          //                             child: Text(
                          //                               variant.labelName
                          //                                   .toString(),
                          //                               style: TextStyle(
                          //                                 fontSize: 14,
                          //                                 fontWeight:
                          //                                     FontWeight.w500,
                          //                                 color: _controller
                          //                                         .selectedProductVariants
                          //                                         .any((da) =>
                          //                                             da['type'] ==
                          //                                                 element
                          //                                                     .type &&
                          //                                             da['value'] ==
                          //                                                 variant
                          //                                                     .labelName)
                          //                                     ? kSecondaryColor
                          //                                     : brightness ==
                          //                                             Brightness
                          //                                                 .dark
                          //                                         ? Colors.white
                          //                                         : Colors
                          //                                             .black,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                 ],
                          //               ),
                          //               if (_controller.isSizeChart.value &&
                          //                   element.type.toLowerCase() ==
                          //                       'size') ...[
                          //                 SizedBox(height: 15),
                          //                 Divider(height: 0.5, thickness: 0.5),
                          //                 Container(
                          //                     padding: EdgeInsets.symmetric(
                          //                         vertical: 10, horizontal: 5),
                          //                     child: InkWell(
                          //                       child: Row(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .center,
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Text("Size Info",
                          //                                 style: TextStyle(
                          //                                     fontSize: 16)),
                          //                             Icon(Icons
                          //                                 .keyboard_arrow_right_outlined)
                          //                           ]),
                          //                       onTap: () {
                          //                         sizeChartController
                          //                             .showSizeChartOpen(
                          //                                 _controller
                          //                                     .product.value);
                          //                         _showSizeChartBottomSheet(
                          //                             context);
                          //                       },
                          //                     )),
                          //                 Divider(height: 0.5, thickness: 0.5),
                          //               ]
                          //             ]));
                          // },
                          // );
                        },
                      )
                  ])),
                  if (design['source']['show-wishlist'] == true) ...[
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        _controller
                            .addToWishList(_controller.product.value.sId);
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            (_controller.wishlistFlag.value != null &&
                                    _controller.getWishListonClick(
                                        _controller.product.value))
                                ? Icons.favorite_sharp
                                : Icons.favorite_border_outlined,
                            size: 18,
                            color: (_controller.wishlistFlag.value != null &&
                                    _controller.getWishListonClick(
                                        _controller.product.value))
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ])))
        : Container();
  }

  String variantName(variant) {
    var value = _controller.selectedProductVariants
        .firstWhere((da) => da['type'] == variant.type, orElse: () => null);
    if (value != null && value['value'] != null)
      return value['value'];
    else
      return variant.type;
  }

  openAddToCart(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: const Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return ProductDetailAddToCartDeign2(controller: _controller);
        });
  }

  void _showSizeChartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Size Chart',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => sizeChartController.isLoading.value
                          ? const Center(
                              child: const CircularProgressIndicator(),
                            )
                          : WebViewWidget(
                              controller: sizeChartController.webViewController,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {});
  }
}
