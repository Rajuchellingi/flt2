// ignore_for_file: unused_local_variable

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<OrderProductsVM> products;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Product Details",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor),
      ),
      const SizedBox(height: 5),
      Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: products.asMap().entries.map<Widget>((entry) {
                final index = entry.key;
                final element = entry.value;
                return Container(
                  decoration: BoxDecoration(
                    border: index != (products.length - 1)
                        ? Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          )
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/productDetail',
                                      arguments: element);
                                },
                                child: CachedNetworkImageWidget(
                                  image: productImage(element.image),
                                ),
                              )),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/productDetail',
                                          arguments: element);
                                    },
                                    child: Text(
                                      element.productName.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor),
                                    )),
                                const SizedBox(height: 3),
                                if (element.productVariant != null &&
                                    element.productVariant!.isNotEmpty)
                                  for (var attr in element.productVariant!)
                                    Container(
                                        child: Text(
                                      "${attr.attributeLabelName} : ${attr.attributeFieldValue}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor,
                                      ),
                                    )),
                                if (element.type == "pack" &&
                                    element.isCustomizable == true) ...[
                                  if (element.setIsCustomizable == false) ...[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "1 Set = ${element.setMoqPieces} Pieces; ${getSetQuantity(element.variants)}",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54),
                                        ))
                                  ] else if (element.isAssorted == true) ...[
                                    Container(
                                        child: Text(
                                      "1 Set = ${element.setMoqPieces} Pieces; Assorted ${element.preferenceVariant!.attributeLabelName};",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    )),
                                  ]
                                ],
                                if (element.type == 'set' &&
                                    element.isCustomizable == false &&
                                    element.isAssorted == true)
                                  Container(
                                      child: Text(
                                    "1 Set = ${element.moq} Pieces; Assorted ${element.setQuantity!.variantType};",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor),
                                  )),
                                if (element.type == 'set' &&
                                    element.isCustomizable == false &&
                                    element.isAssorted == false)
                                  Container(
                                      child: Text(
                                    "1 Set = ${element.moq} Pieces; ${getSetQuantity(element.setQuantity!.variantQuantites)}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor),
                                  )),
                                if (element.type == 'pack' &&
                                    element.isCustomizable == false) ...[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "1 Pack = ${element.moq} Pieces;",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor),
                                    ),
                                  ),
                                  if (element.packQuantity!.setQuantities !=
                                          null &&
                                      element.packQuantity!.setQuantities!
                                          .isNotEmpty)
                                    for (var qty
                                        in element.packQuantity!.setQuantities!)
                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            "${qty.attributeFieldValue}: ${getSetQuantity(qty.variantQuantites)}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : kPrimaryTextColor),
                                          ))
                                ],
                                if (element.quantity != null &&
                                    element.quantity! > 1) ...[
                                  const SizedBox(height: 3),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        element.price!.currencySymbol
                                                .toString() +
                                            element.price!.sellingPrice
                                                .toString() +
                                            " / Piece",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: brightness == Brightness.dark
                                                ? Colors.white
                                                : kPrimaryTextColor),
                                      ),
                                      const SizedBox(width: 5),
                                      // if (element.type != "pack" &&
                                      //     element.type != "set") ...[
                                      //   Text(
                                      //     CommonHelper.currencySymbol() +
                                      //         element.price!.mrp.toString(),
                                      //     style: TextStyle(
                                      //       decoration:
                                      //           TextDecoration.lineThrough,
                                      //       fontSize: 12,
                                      //     ),
                                      //   ),
                                      //   SizedBox(width: 7),
                                      // ],
                                      Text(
                                        (element.price!.discount != null &&
                                                element.price!.discount! > 0)
                                            ? '${element.price!.discount} % Off'
                                            : '',
                                        style: headingStyle.copyWith(
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                                if (element.type == 'product' ||
                                    (element.type == 'set' &&
                                        element.isCustomizable == false) ||
                                    (element.type == 'pack' &&
                                        element.isCustomizable == false))
                                  Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Quantity : ${element.quantity} ${element.type == 'set' ? "Set" : element.type == 'pack' ? "Pack" : ''}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : kPrimaryTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                if (element.type == 'pack' &&
                                    element.isCustomizable == true &&
                                    element.setIsCustomizable == false)
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Quantity : ${element.setQuantityValue} Set",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      )),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    platform == 'shopify'
                                        ? "${CommonHelper.currencySymbol() + element.totalPrice.toString()}"
                                        : "${element.price!.currencySymbol.toString() + element.totalPrice.toString()}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if ((element.type == 'pack' &&
                              element.isCustomizable == true &&
                              element.setIsCustomizable == true) ||
                          (element.type == 'set' &&
                              element.isCustomizable == true))
                        Container(
                            child: Container(
                                width: SizeConfig.screenWidth,
                                padding: const EdgeInsets.all(10),
                                child: Table(
                                    border:
                                        TableBorder.all(color: Colors.black12),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Variant',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : kPrimaryTextColor,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'QTY',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : kPrimaryTextColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : kPrimaryTextColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      for (var variant in element.variants!)
                                        TableRow(children: [
                                          TableCell(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  color: Colors.white,
                                                  child: Text(
                                                      variant
                                                          .attributeFieldValue
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : kPrimaryTextColor)))),
                                          TableCell(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  color: Colors.white,
                                                  child: Text(
                                                      variant.quantity
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : kPrimaryTextColor)))),
                                          TableCell(
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 15),
                                                  color: Colors.white,
                                                  child: Text(
                                                      platform == 'shopify'
                                                          ? CommonHelper.currencySymbol() +
                                                              variant.totalPrice
                                                                  .toString()
                                                          : element.price!
                                                                  .currencySymbol
                                                                  .toString() +
                                                              variant.totalPrice
                                                                  .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : kPrimaryTextColor))))
                                        ])
                                    ])))
                    ],
                  ),
                );
              }).toList()))
    ]);
  }

  String productImage(image) {
    if (image != null && image.imageName != null) {
      if (platform == 'to-automation') {
        return productImageUrl +
            image.imageId +
            '/' +
            "78-102" +
            "/" +
            image.imageName;
      } else {
        return image.imageName;
      }
    } else {
      return errorImageUrl;
    }
  }

  getSetQuantity(setQuantity) {
    var quantity = '';
    if (setQuantity != null && setQuantity.isNotEmpty)
      for (var element in setQuantity) {
        quantity += '${element.attributeFieldValue} = ${element.moq}; ';
      }
    return quantity;
  }
}
