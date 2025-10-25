// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductColorPick extends StatelessWidget {
  const ProductColorPick({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      int totalQuantity = _controller.calculateTotalQuantity();
      var userId = GetStorage().read('utoken');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Available ${_controller.product.value.preferenceVariant.attributeLabelName} ",
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              _controller.product.value.packVariant?.length ?? 0,
              (fieldIndex) {
                final fieldValue =
                    _controller.product.value.packVariant![fieldIndex];

                // Check if the current color is in the selected attributeFieldValues
                bool isSelected = _controller.attributeFieldValues.any((attr) =>
                    attr['attributeFieldValueId'] ==
                        fieldValue.attributeFieldValueId &&
                    attr['color'] == fieldValue.fieldValue);

                return GestureDetector(
                  onTap: () {
                    if (_controller.attributeFieldValues.isNotEmpty) {
                      _controller.updateDefaultColor(fieldValue);
                    } else {
                      _controller.selectedColorVariants(fieldValue);
                    }
                  },
                  child: fieldValue.colorCode != null
                      ? Container(
                          width: 25.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                              int.parse(
                                fieldValue.colorCode!.replaceFirst('#', '0xFF'),
                              ),
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.orange
                                  : const Color.fromARGB(255, 154, 148, 148),
                              width: isSelected
                                  ? 2.0
                                  : 1.0, // Thicker border for selected
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? kPrimaryColor
                                  : Color.fromARGB(255, 154, 148, 148),
                              width: isSelected
                                  ? 2.0
                                  : 1.0, // Highlight selected text-based color
                            ),
                            borderRadius: BorderRadius.circular(3.0),
                            color: isSelected
                                ? kPrimaryColor.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Text(
                            fieldValue.fieldValue,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? kPrimaryColor
                                  : brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
          if (_controller.product.value.showPriceAfterLogin == false ||
              (_controller.product.value.showPriceAfterLogin == true &&
                  userId != null)) ...[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 15.0),
              child: const Text(
                'Selected Color & Quantity',
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ..._controller.attributeFieldValues.map((field) {
              bool isDefault = _controller.attributeFieldValues.first == field;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                    decoration: BoxDecoration(
                      color: brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 219, 216, 216),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 96, 94, 94).withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: kPrimaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 15.0, right: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "${field['color']}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (field['colorCode'] != null)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      color: field['colorCode'] != null
                                          ? Color(int.parse(field['colorCode']
                                              .replaceFirst('#', '0xFF')))
                                          : Colors.black,
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 154, 148, 148),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                alignment: Alignment.center,
                                child: Obx(() {
                                  var remainingColors =
                                      _controller.getRemainingColors();
                                  if (remainingColors.isEmpty)
                                    return const SizedBox.shrink();

                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Select another color',
                                                style: const TextStyle(
                                                    fontSize: 13.0)),
                                            content: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 8.0,
                                              children: List.generate(
                                                  remainingColors.length,
                                                  (fieldIndex) {
                                                final fieldValue =
                                                    remainingColors[fieldIndex];
                                                return GestureDetector(
                                                  onTap: () {
                                                    _controller
                                                        .selectedColorVariantsbyIndex(
                                                            fieldValue,
                                                            field,
                                                            context,
                                                            field);
                                                  },
                                                  child:
                                                      fieldValue['colorCode'] !=
                                                              null
                                                          ? Container(
                                                              width: 25.0,
                                                              height: 25.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(int.parse(fieldValue[
                                                                        'colorCode']!
                                                                    .replaceFirst(
                                                                        '#',
                                                                        '0xFF'))),
                                                                border:
                                                                    Border.all(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          154,
                                                                          148,
                                                                          148),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            154,
                                                                            148,
                                                                            148),
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3.0)),
                                                              child: Text(
                                                                fieldValue[
                                                                    'fieldValue'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Change Color',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              if (!isDefault)
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () {
                                      _controller.removeColor(field['color']);
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (field['isCustomizable'] == true) ...[
                          Wrap(
                            spacing: 20.0,
                            runSpacing: 10.0,
                            children: List.generate(
                                (field['availableSize'] as List).length,
                                (sizeIndex) {
                              var sizeInfo = field['availableSize'][sizeIndex];
                              print('sizeInfo: $sizeInfo');
                              String size = sizeInfo['size'];
                              String totalQuantity =
                                  sizeInfo['totalQuantity'].toString();
                              String sellingPrice =
                                  productSetting.priceDisplayType == 'mrp'
                                      ? sizeInfo['mrp'].toString()
                                      : sizeInfo['sellingPrice'].toString();
                              TextEditingController controller =
                                  field['inputValues'][sizeIndex]['value'];
                              bool showQuantity = sizeInfo['trackQuantity'] ==
                                      true &&
                                  sizeInfo['continueSellingWhenOutOfStock'] ==
                                      false;
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2.5,
                                margin: const EdgeInsets.only(
                                    left: 10.0, bottom: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (showQuantity) ...[
                                      Text('$size ($totalQuantity)',
                                          style:
                                              const TextStyle(fontSize: 12.0))
                                    ] else ...[
                                      Text('$size',
                                          style:
                                              const TextStyle(fontSize: 12.0))
                                    ],
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        labelText: 'Quantity',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 10.0),
                                        labelStyle: TextStyle(fontSize: 10.5),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        _controller.updateQuantity(
                                            field['color'], size, value);
                                      },
                                    ),
                                    if (productSetting.showVariantPrice ==
                                        true) ...[
                                      const SizedBox(height: 10),
                                      Text(
                                          '${_controller.product.value.currencySymbol}$sellingPrice/Piece',
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  ],
                                ),
                              );
                            }),
                          )
                        ],
                        if (field['isCustomizable'] == false) ...[
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        Text(
                                          field['isAssorted'] == false
                                              ? "1 Set: ${field['setQuantity']} Pieces;"
                                              : field['isAssorted'] == true
                                                  ? "1 Set: ${field['setQuantity']} Pieces; Assorted ${field['fieldValue']};"
                                                  : "",
                                          style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(width: 5),
                                        for (var variant
                                            in field['availableSize']) ...[
                                          Text(
                                            "${variant['size']} = ${variant['moq']}; ",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 20, left: 0)),
                                        const Text(
                                          "Quantity",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 13.0),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            var value =
                                                int.parse(field['value'].text) -
                                                    1;
                                            if (value > 0) {
                                              _controller.updateQuantity(
                                                  field['color'],
                                                  null,
                                                  value.toString());
                                            }
                                            // _controller.quantityMinus(
                                            //     size == null ? 0 : size, _controller.product.value);
                                          },
                                        ),
                                        Container(
                                          height:
                                              getProportionateScreenWidth(30),
                                          width:
                                              getProportionateScreenWidth(40),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey[300]!),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              field['value'].text,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            var value =
                                                int.parse(field['value'].text) +
                                                    1;
                                            _controller.updateQuantity(
                                                field['color'],
                                                null,
                                                value.toString());
                                          },
                                        ),
                                      ],
                                    ),
                                  ]))
                        ],
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            GestureDetector(onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  var remainingColors = _controller.getRemainingColors();
                  return AlertDialog(
                    title: const Text('Select another color',
                        style: const TextStyle(fontSize: 13.0)),
                    content: Container(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: List.generate(remainingColors.length ?? 0,
                            (fieldIndex) {
                          final fieldValue = remainingColors[fieldIndex];
                          return GestureDetector(
                            onTap: () {
                              _controller.selectedColorVariants(fieldValue);
                              Navigator.pop(context);
                            },
                            child: fieldValue['colorCode'] != null
                                ? Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(
                                          fieldValue['colorCode']!
                                              .replaceFirst('#', '0xFF'))),
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 154, 148, 148),
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(
                                              255, 154, 148, 148),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    child: Text(
                                      fieldValue['fieldValue'],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              );
            }, child: Obx(() {
              var remainingColors = _controller.getRemainingColors();
              if (remainingColors.isEmpty) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(left: 5.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.add,
                          size: 15.0,
                          color: const Color.fromARGB(255, 229, 29, 11)),
                      const Text(
                        'Add Another Color and Quantity',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: const Color.fromARGB(255, 229, 29, 11),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Total Quantity: $totalQuantity',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ]
        ],
      );
    });
  }
}
