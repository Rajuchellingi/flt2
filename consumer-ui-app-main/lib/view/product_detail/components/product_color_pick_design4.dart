// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductColorPickDesign4 extends StatelessWidget {
  const ProductColorPickDesign4(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final _controller;
  final design;
  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      int totalQuantity = _controller.calculateTotalQuantity();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              _controller.product.value.preferenceVariant.attributeLabelName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Color.fromARGB(255, 227, 227, 227),
                    width: 1.0, // Highlight selected text-based color
                  )),
              child: Row(
                children: List.generate(
                  _controller.product.value.packVariant?.length ?? 0,
                  (fieldIndex) {
                    final fieldValue =
                        _controller.product.value.packVariant![fieldIndex];

                    // Check if the current color is in the selected attributeFieldValues
                    bool isSelected = _controller.attributeFieldValues.any(
                        (attr) =>
                            attr['attributeFieldValueId'] ==
                                fieldValue.attributeFieldValueId &&
                            attr['color'] == fieldValue.fieldValue);

                    return Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (_controller.attributeFieldValues.isNotEmpty) {
                          _controller.updateDefaultColor(fieldValue);
                        } else {
                          _controller.selectedColorVariants(fieldValue);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color:
                              isSelected ? kPrimaryColor : Colors.transparent,
                        ),
                        child: Text(
                          fieldValue.fieldValue,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? kSecondaryColor
                                : brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ));
                  },
                ),
              )),
          const SizedBox(height: 10),
          ..._controller.attributeFieldValues.map((field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color Header
                      Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${field['color']}",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (field['colorCode'] != null)
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(field['colorCode']
                                      .replaceFirst('#', '0xFF'))),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 154, 148, 148),
                                    width: 1,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Customizable Sizes
                      if (field['isCustomizable'] == true)
                        Column(
                          spacing: 10.0,
                          children: List.generate(
                            (field['availableSize'] as List).length,
                            (sizeIndex) {
                              var sizeInfo = field['availableSize'][sizeIndex];
                              String size = sizeInfo['size'];
                              String colorCode =
                                  sizeInfo['colorCode'] ?? '#FFFFFF';
                              String sellingPrice =
                                  productSetting.priceDisplayType == 'mrp'
                                      ? sizeInfo['mrp'].toString()
                                      : sizeInfo['sellingPrice'].toString();

                              // Initialize quantity as RxInt
                              RxInt quantity = (field['inputValues'][sizeIndex]
                                          ['value'] as TextEditingController)
                                      .text
                                      .isEmpty
                                  ? 0.obs
                                  : int.parse((field['inputValues'][sizeIndex]
                                                  ['value']
                                              as TextEditingController)
                                          .text)
                                      .obs;

                              return Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Quantity Selector with separate backgrounds
                                    Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Decrease Button
                                            InkWell(
                                              onTap: () {
                                                if (quantity.value > 0) {
                                                  quantity.value--;
                                                  _controller.updateQuantity(
                                                      field['color'],
                                                      size,
                                                      quantity.value
                                                          .toString());
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              215,
                                                              215,
                                                              215)),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            // Quantity Display
                                            Expanded(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 215, 215, 215)),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Text(
                                                '${quantity.value > 0 ? _controller.getQuantityMetaValues(field['metafields'], quantity.value, design['source']) : quantity.value.toString()}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            const SizedBox(width: 5),
                                            // Increase Button
                                            InkWell(
                                              onTap: () {
                                                if (quantity.value <
                                                    sizeInfo['totalQuantity']) {
                                                  quantity.value++;
                                                  _controller.updateQuantity(
                                                      field['color'],
                                                      size,
                                                      quantity.value
                                                          .toString());
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              215,
                                                              215,
                                                              215)),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 15),
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: kPrimaryColor.withAlpha(50)),
                                        child: Text(
                                            'Total Order Quantity: ${quantity} ${sizeInfo['size']} ',
                                            style: const TextStyle(
                                                color: kPrimaryColor))),
                                    const SizedBox(height: 15),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 219, 219, 219)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Selling Price: "),
                                                Text(
                                                    '${_controller.product.value.currencySymbol}${sizeInfo['sellingPrice']}')
                                              ]),
                                          if (quantity.value > 0) ...[
                                            const SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "Total order value for ${quantity.value} ${sizeInfo['size']}: "),
                                                  Text(
                                                      '${_controller.product.value.currencySymbol}${sizeInfo['sellingPrice'] * quantity.value}')
                                                ])
                                          ]
                                        ])),
                                    const SizedBox(height: 15),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 245, 245, 245),
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 245, 245, 245)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(children: [
                                          Row(spacing: 5, children: [
                                            const Icon(CupertinoIcons.cube_box,
                                                color: kPrimaryColor),
                                            const Text("Inventory Status ",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                          const SizedBox(height: 10),
                                          Row(spacing: 5, children: [
                                            const Text("In Stock: ",
                                                style: TextStyle(
                                                    color: kPrimaryColor)),
                                            Text(
                                                '${_controller.getQuantityMetaValues(field['metafields'], sizeInfo['totalQuantity'], design['source'])}')
                                          ])
                                        ]))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      );
    });
  }
}
