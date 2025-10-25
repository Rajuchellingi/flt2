// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_detail_size_chart_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailVariantDesign9 extends StatelessWidget {
  ProductDetailVariantDesign9(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return (_controller.productVariants != null &&
            _controller.productVariants.isNotEmpty)
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var element in _controller.productVariants)
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                element.type.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )),
                              if (_controller.isSizeChart.value &&
                                  element.type.toLowerCase() == 'size')
                                ProductDetailSizeChartDesign2(
                                    product: _controller.product.value)
                            ]),
                        const SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 7,
                            children: [
                              for (var variant in element.fieldValue ?? [])
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.getProductByVariant(
                                        element.type,
                                        variant.labelName,
                                      );
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: _controller
                                                  .selectedProductVariants
                                                  .any((da) =>
                                                      da['type'] ==
                                                          element.type &&
                                                      da['value'] ==
                                                          variant.labelName)
                                              ? brightness == Brightness.dark
                                                  ? kPrimaryColor ==
                                                          Colors.black
                                                      ? Colors.white
                                                      : kPrimaryColor
                                                  : kPrimaryColor
                                              : null,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 202, 202, 202),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          variant.labelName.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _controller
                                                    .selectedProductVariants
                                                    .any((da) =>
                                                        da['type'] ==
                                                            element.type &&
                                                        da['value'] ==
                                                            variant.labelName)
                                                ? brightness == Brightness.dark
                                                    ? kSecondaryColor ==
                                                            Colors.white
                                                        ? Colors.black
                                                        : kSecondaryColor
                                                    : kSecondaryColor
                                                : brightness == Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ))
        : Container();
  }
}
