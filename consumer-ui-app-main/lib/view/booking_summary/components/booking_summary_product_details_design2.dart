import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/configConstant.dart';

class BookingSummaryProductDetailsDesign2 extends StatelessWidget {
  BookingSummaryProductDetailsDesign2({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<CartProductsVM> products;
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    final productSetting = productSettingController.productSetting.value;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var element in products)
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/detail', arguments: element);
                        },
                        child: CachedNetworkImageWidget(
                          image: productImageUrl +
                              element.image!.imageId! +
                              '/' +
                              "78-102" +
                              "/" +
                              element.image!.imageName!,
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
                              Get.toNamed('/detail', arguments: element);
                            },
                            child: Text(
                              element.productName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(height: 3),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quantity: ${element.totalCartQuantity}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              if (productSetting.priceDisplayType == 'mrp') ...[
                                Text(
                                  element.price!.currencySymbol.toString() +
                                      element.price!.mrp.toString() +
                                      (element.type == "pack" ||
                                              element.type == "set"
                                          ? " / Piece"
                                          : ""),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                )
                              ] else ...[
                                Text(
                                    element.price!.currencySymbol.toString() +
                                        element.price!.sellingPrice.toString() +
                                        (element.type == "pack" ||
                                                element.type == "set"
                                            ? " / Piece"
                                            : ""),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    )),
                              ],
                            ]),
                        const SizedBox(height: 3),
                        if (element.productVariant != null &&
                            element.productVariant!.isNotEmpty)
                          for (var attr in element.productVariant!)
                            Container(
                                child: Text(
                              "${attr.attributeLabelName} : ${attr.attributeFieldValue}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black54),
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
                          if (element.packQuantity!.setQuantities != null &&
                              element.packQuantity!.setQuantities!.isNotEmpty)
                            for (var qty
                                in element.packQuantity!.setQuantities!)
                              Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "${qty.attributeFieldValue}: ${getSetQuantity(qty.variantQuantites)}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  ))
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
                                    color: Colors.black),
                              )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                child: Text(
                                  "${element.price!.currencySymbol.toString() + element.totalPrice.toString()}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          )
      ],
    );
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
