// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSetCustomizable extends StatelessWidget {
  const ProductSetCustomizable({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(context).brightness;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 219, 216, 216),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 96, 94, 94).withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Obx(
          () => Wrap(spacing: 20.0, children: [
            for (var variant in _controller.product.value.variants) ...[
              Container(
                width: (MediaQuery.of(context).size.width - 45) / 2,
                // margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (variant.trackQuantity == true &&
                        variant.continueSellingWhenOutOfStock == false) ...[
                      Text(
                        (int.tryParse(variant.totalQuantity.toString()) ?? 0) <
                                (int.tryParse(_controller.product.value.moq
                                            ?.toString() ??
                                        '0') ??
                                    0)
                            ? 'Out of Stock'
                            : "${variant.preferenceVariant?.attributeFieldValue ?? ''} (${variant.totalQuantity?.toString() ?? '0'})",
                        style: TextStyle(
                          fontSize: 12.0,
                          color:
                              (int.tryParse(variant.totalQuantity.toString()) ??
                                          0) <
                                      (int.tryParse(_controller
                                                  .product.value.moq
                                                  ?.toString() ??
                                              '0') ??
                                          0)
                                  ? Colors.red
                                  : Colors.black,
                        ),
                      )
                    ] else ...[
                      Text(
                        "${variant.preferenceVariant?.attributeFieldValue ?? ''}",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    // Quantity Input Box
                    Container(
                      width: 150, // Set the width as per your requirement
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: const TextStyle(
                              fontSize: 10.5), // Set label font size to 10.5
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10), // Adjust height
                        ),
                        keyboardType: TextInputType.number,
                        enabled:
                            (int.tryParse(variant.totalQuantity.toString()) ??
                                    0) >=
                                (int.tryParse(_controller.product.value.moq
                                            ?.toString() ??
                                        '0') ??
                                    0),
                        onChanged: (value) {
                          _controller.selectedValue(variant.variantId, value);
                        },
                      ),
                    ),
                    if (productSetting.showVariantPrice == true) ...[
                      const SizedBox(height: 10),
                      // Price Row
                      Text(
                        '${_controller.product.value.currencySymbol}${productSetting.priceDisplayType == 'mrp' ? variant.price?.mrp : variant.price?.sellingPrice} /Piece',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  ],
                ),
              )
            ]
          ]),
        ),
      ),
    );
  }
}
