// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/model/multi_booking_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiBookingDesign2 extends StatelessWidget {
  MultiBookingDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final MultiBookingController _controller;
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    final productSetting = productSettingController.productSetting.value;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text("${_controller.products.value.length} Products Selected",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(height: 5),
        Text("Review your wholesale selection"),
        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              Get.toNamed('/applySameQuantity', arguments: {
                'productIds': _controller.productIds,
                'pageId': 'apply-same-quantity'
              });
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Apply Same Quantity",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold)))),
        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              Get.toNamed('/applyDifferentQuantity', arguments: {
                'productIds': _controller.productIds,
                'pageId': 'apply-different-quantity'
              });
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Apply Different Quantity",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold)))),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
        Expanded(
            child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                // shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: _controller.products.value.length,
                itemBuilder: (context, index) {
                  MultiBookingProductVM product =
                      _controller.products.value[index];
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),

                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          leading: CachedNetworkImageWidget(
                            image: productImageUrl +
                                product.image!.imageId.toString() +
                                '/' +
                                "78-102" +
                                "/" +
                                product.image!.imageName.toString(),
                          ),
                          title: Text(
                            product.productName.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (productSetting.priceDisplayType ==
                                        'mrp') ...[
                                      Text(
                                        product.currencySymbol.toString() +
                                            product.price!.mrp.toString() +
                                            (product.type == "pack" ||
                                                    product.type == "set"
                                                ? " / Piece"
                                                : ""),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )
                                    ] else ...[
                                      Text(
                                        product.currencySymbol.toString() +
                                            product.price!.sellingPrice
                                                .toString() +
                                            (product.type == "pack" ||
                                                    product.type == "set"
                                                ? " / Piece"
                                                : ""),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                    const SizedBox(width: 5),
                                    if (productSetting.priceDisplayType ==
                                            'mrp-and-selling-price' &&
                                        product.type != "pack" &&
                                        product.type != "set") ...[
                                      // Text(
                                      //   'MRP: ',
                                      //   style: TextStyle(fontSize: 11),
                                      // ),
                                      Text(
                                        product.currencySymbol!.toString() +
                                            product.price!.mrp.toString(),
                                        style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 7),
                                    ],
                                  ],
                                ),
                                if (product.type == 'set' &&
                                    product.isCustomizable == false &&
                                    product.isAssorted == true) ...[
                                  Container(
                                      child: Text(
                                          "1 Set = ${product.moq} Pieces; Assorted ${product.setQuantity!.variantType};",
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ))),
                                ] else if (product.type == 'set' &&
                                    product.isCustomizable == false) ...[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "1 Set = ${product.setQuantity?.totalQuantity} Pieces; ${getSetQuantity(product.setQuantity!.variantQuantites)}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      )),
                                ] else if (product.type == 'set' &&
                                    product.isCustomizable == true) ...[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Minimum Order: ${product.moq}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      )),
                                ] else if (product.type == 'pack' &&
                                    product.isCustomizable == false) ...[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "1 Pack = ${product.packQuantity?.totalQuantity} Pieces;",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      )),
                                ] else if (product.type == 'pack' &&
                                    product.isCustomizable == true) ...[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Minimum Order: ${product.moq}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      )),
                                ],
                              ]),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.delete),
                            onPressed: () {
                              _controller.removeProduct(index);
                            },
                          )));
                }))
      ]),
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
