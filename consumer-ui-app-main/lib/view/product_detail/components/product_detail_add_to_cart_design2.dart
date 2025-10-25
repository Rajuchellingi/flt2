// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailAddToCartDeign2 extends StatelessWidget {
  ProductDetailAddToCartDeign2({Key? key, required controller})
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
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: brightness == Brightness.dark ? Colors.black : kBackground,
            ),
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Center(
                  child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey))),
              const SizedBox(height: 15),
              for (var element in _controller.allVariants) ...[
                SizedBox(height: 10),
                Container(
                    child: Text(
                  'Select ${element.type.toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                )),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: [
                    for (var variant in _controller
                        .getProductAvailableVariantOptions(element.type))
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Stack(children: [
                            GestureDetector(
                              onTap: () {
                                _controller.getProductByVariant(
                                    element.type, variant.name);
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: _controller
                                            .selectedProductVariants.value
                                            .any((da) =>
                                                da['type'] == element.type &&
                                                da['value'] == variant.name)
                                        ? kPrimaryColor
                                        : variant.isAvailable == false
                                            ? const Color.fromARGB(
                                                255, 219, 219, 219)
                                            : null,
                                    border: Border.all(
                                      color: _controller
                                              .selectedProductVariants.value
                                              .any((da) =>
                                                  da['type'] == element.type &&
                                                  da['value'] == variant.name)
                                          ? kPrimaryColor
                                          : brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    variant.name.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: _controller
                                              .selectedProductVariants.value
                                              .any((da) =>
                                                  da['type'] == element.type &&
                                                  da['value'] == variant.name)
                                          ? kSecondaryColor
                                          : brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor,
                                    ),
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
                          ])),
                  ],
                ),
              ],
              if (_controller.isSizeChart.value &&
                  _controller.allVariants
                      .any((e) => e.type.toLowerCase() == 'size')) ...[
                const SizedBox(height: 15),
                const Divider(height: 0.5, thickness: 0.5),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: InkWell(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Size Info",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: brightness == Brightness.dark
                                        ? Colors.white
                                        : kPrimaryTextColor)),
                            Icon(Icons.keyboard_arrow_right_outlined,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor)
                          ]),
                      onTap: () {
                        sizeChartController
                            .showSizeChartOpen(_controller.product.value);
                        _showSizeChartBottomSheet(context);
                      },
                    )),
                const Divider(height: 0.5, thickness: 0.5),
              ],
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: SizeConfig.screenWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        _controller.productAddToCart(isPopup: true);
                      },
                      child: Text(
                          _controller.product.value.isOutofstock
                              ? "Add To Cart"
                              : "Notify Me",
                          style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: kSecondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 15))))
            ]));
      },
    );
  }

  void _showSizeChartBottomSheet(BuildContext context) {
    final brightness = Theme.of(context).brightness;
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Size Chart',
                          style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor),
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
