// ignore_for_file: unused_local_variable

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/model/enquiry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryProductDetails extends StatelessWidget {
  const EnquiryProductDetails({
    Key? key,
    required this.products,
    required this.orderDetail,
  }) : super(key: key);

  final List<OrderProductsVM> products;
  final MyEnquiryDetailVM orderDetail;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Product Details",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                const SizedBox(height: 3),
                                if (element.productVariant != null &&
                                    element.productVariant!.isNotEmpty)
                                  for (var attr in element.productVariant!)
                                    Container(
                                        child: Text(
                                      "${attr.attributeLabelName} : ${attr.attributeFieldValue}",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    )),
                                if (element.type == 'set' &&
                                    element.isCustomizable == false &&
                                    element.isAssorted == true)
                                  Container(
                                      child: Text(
                                    "1 Set = ${element.moq} Pieces; Assorted ${element.setQuantity!.variantType};",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  )),
                                if (element.type == 'set' &&
                                    element.isCustomizable == false &&
                                    element.isAssorted == false)
                                  Container(
                                      child: Text(
                                    "1 Set = ${element.moq} Pieces; ${getSetQuantity(element.setQuantity!.variantQuantites)}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  )),
                                if (element.type == 'pack' &&
                                    element.isCustomizable == false) ...[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "1 Pack = ${element.moq} Pieces;",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    ),
                                  ),
                                  if (element.packQuantity!.setQuantities !=
                                          null &&
                                      element.packQuantity!.setQuantities!
                                          .isNotEmpty)
                                    for (var qty
                                        in element.packQuantity!.setQuantities!)
                                      Container(
                                          margin: EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            "${qty.attributeFieldValue}: ${getSetQuantity(qty.variantQuantites)}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54),
                                          ))
                                ],
                                if (element.quantity != null &&
                                    element.quantity! > 1) ...[
                                  const SizedBox(height: 3),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      if (orderDetail.priceDisplayType ==
                                          'mrp') ...[
                                        Text(
                                          element.price!.currencySymbol
                                                  .toString() +
                                              element.price!.mrp.toString() +
                                              " / Piece",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        )
                                      ] else ...[
                                        Text(
                                            element.price!.currencySymbol
                                                    .toString() +
                                                element.price!.sellingPrice
                                                    .toString() +
                                                " / Piece",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ))
                                      ],
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
                                          color: kPrimaryColor,
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
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${element.price!.currencySymbol.toString() + element.totalPrice.toString()}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if ((element.type == 'pack' &&
                              element.isCustomizable == true) ||
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
                                            child: const Text(
                                              'Variant',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'QTY',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
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
                                                      style: const TextStyle(
                                                          fontSize: 12)))),
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
                                                      style: const TextStyle(
                                                          fontSize: 12)))),
                                          TableCell(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  color: Colors.white,
                                                  child: Text(
                                                      element.price!
                                                              .currencySymbol
                                                              .toString() +
                                                          variant.totalPrice
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 12))))
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
