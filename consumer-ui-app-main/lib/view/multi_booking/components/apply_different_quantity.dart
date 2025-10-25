// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/model/multi_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_component/cached_network_image.dart';
import '../../../config/configConstant.dart';

class ApplyDifferentQuantitySheet extends StatelessWidget {
  final int selectedProducts;
  final VoidCallback? onCancel;
  final MultiBookingController _controller;

  ApplyDifferentQuantitySheet({
    Key? key,
    required this.selectedProducts,
    this.onCancel,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pack Quantity for All Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.inventory_2, color: Colors.red, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '$selectedProducts Products Selected',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ..._controller.products.value.map<Widget>((prod) {
                MultiBookingProductVM product = prod;
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
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
                                  Get.toNamed('/detail', arguments: product);
                                },
                                child: CachedNetworkImageWidget(
                                  image: productImageUrl +
                                      product.image!.imageId.toString() +
                                      '/' +
                                      "78-102" +
                                      "/" +
                                      product.image!.imageName.toString(),
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
                                      Get.toNamed('/detail',
                                          arguments: product);
                                    },
                                    child: Text(
                                      product.productName.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                const SizedBox(height: 5),
                                if (product.type == 'set' &&
                                    product.isCustomizable == false &&
                                    product.isAssorted == true)
                                  Container(
                                      child: Text(
                                    "1 Set = ${product.moq} Pieces; Assorted ${product.setQuantity!.variantType};",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  )),
                                if (product.type == 'set' &&
                                    product.isCustomizable == false &&
                                    product.isAssorted == false)
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "1 Set = ${product.moq} Pieces; ${getSetQuantity(product.setQuantity!.variantQuantites)}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      )),
                                if (product.type == 'pack' &&
                                    product.isCustomizable == false) ...[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "1 Pack = ${product.moq} Pieces;",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    ),
                                  ),
                                  if (product.packQuantity!.setQuantities !=
                                          null &&
                                      product.packQuantity!.setQuantities!
                                          .isNotEmpty)
                                    for (var qty
                                        in product.packQuantity!.setQuantities!)
                                      Container(
                                          margin: EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            "${qty.attributeFieldValue}: ${getSetQuantity(qty.variantQuantites)}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54),
                                          ))
                                ],
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (product.priceDisplayType == 'mrp') ...[
                                      Text(
                                        product.currencySymbol.toString() +
                                            product.price!.mrp.toString() +
                                            (product.type == "pack" ||
                                                    product.type == "set"
                                                ? " / Piece"
                                                : ""),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
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
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                    const SizedBox(width: 5),
                                    if (product.priceDisplayType ==
                                            'mrp-and-selling-price' &&
                                        product.type != "pack" &&
                                        product.type != "set") ...[
                                      // Text(
                                      //   'MRP: ',
                                      //   style: TextStyle(fontSize: 11),
                                      // ),
                                      Text(
                                        product.currencySymbol.toString() +
                                            product.price!.mrp.toString(),
                                        style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 7),
                                    ],
                                    Text(
                                      (product.discount != null &&
                                              product.discount! > 0)
                                          ? '${product.discount} % Off'
                                          : '',
                                      style: headingStyle.copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                // Text(
                                //   "Price:  " +
                                //       product.currencySymbol.toString() +
                                //       product.price!.sellingPrice.toString(),
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14,
                                //   ),
                                // ),
                                // const SizedBox(height: 10),
                                if ((product.type == "pack" &&
                                        product.isCustomizable == false) ||
                                    (product.type == "set" &&
                                        product.isCustomizable == false) ||
                                    (product.type == "set" &&
                                        product.isAssorted == true) ||
                                    product.type == "product")
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("QTY:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 10),
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 1),
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        size: 14)),
                                                onTap: () {
                                                  _controller
                                                      .minusProductQuantity(
                                                          product);
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 15),
                                                // width:
                                                //     60, // Adjusted width to accommodate the text properly
                                                // height: 35,
                                                alignment: Alignment.center,
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(5),
                                                //   border: Border.all(
                                                //       color: Colors.grey),
                                                // ),
                                                child: Text(
                                                  _controller
                                                      .getVariantController(
                                                          product, null, null)
                                                      .text,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 1),
                                                      ),
                                                    ),
                                                    child: const Icon(Icons.add,
                                                        size: 14)),
                                                onTap: () {
                                                  _controller
                                                      .addProductQuantity(
                                                          product);
                                                },
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (product.type == "pack" &&
                          product.isCustomizable == true) ...[
                        Container(
                          child: Column(
                            children: [
                              for (var set in product.packVariant!) ...[
                                Column(children: [
                                  Row(children: [
                                    if (set.attributeFieldSetting == 'color' &&
                                        set.colorCode != null) ...[
                                      CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(int.parse(set
                                              .colorCode!
                                              .replaceAll('#', '0xff')))),
                                      const SizedBox(width: 5),
                                    ],
                                    Text(set.attributeFieldValue.toString())
                                  ]),
                                  Container(
                                      child: Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: [
                                        for (var option
                                            in set.variantOptions!) ...[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                          option
                                                              .attributeFieldValue
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        )),
                                                        // if (variant.trackQuantity == true &&
                                                        //     variant.continueSellingWhenOutOfStock ==
                                                        //         false)
                                                        //   Text(' (${variant.totalQuantity})',
                                                        //       style:
                                                        //           const TextStyle(fontSize: 12))
                                                      ]),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                      width: 100,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: TextField(
                                                          controller: _controller
                                                              .getVariantController(
                                                                  product,
                                                                  set.setId,
                                                                  option
                                                                      .variantId),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  height: 1),
                                                          cursorColor:
                                                              Colors.black,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorHeight: 15,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              isDense: true
                                                              // contentPadding: EdgeInsets.only(
                                                              //     left: 5, bottom: 15),
                                                              ),
                                                          // onChanged: (value) {
                                                          //   int newQuantity = int.tryParse(value) ??
                                                          //       variant.quantity;
                                                          //   _controller
                                                          //       .updateProductQuantityWithInput(
                                                          //           product.sId,
                                                          //           variant.variantId,
                                                          //           newQuantity,
                                                          //           product.setId);
                                                          // },
                                                          onChanged: (value) {},
                                                        ),
                                                      )),
                                                ],
                                              )),
                                        ]
                                      ]))
                                ]),
                                SizedBox(height: 10)
                              ]
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      if (product.type == "set" &&
                          product.isCustomizable == true)
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: product.variants!.map<Widget>((variant) {
                            final TextEditingController controller =
                                _controller.getVariantController(
                                    product, null, variant.variantId);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                            child: Text(
                                          variant.preferenceVariant!
                                              .attributeFieldValue
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        )),
                                        // if (variant.trackQuantity == true &&
                                        //     variant.continueSellingWhenOutOfStock ==
                                        //         false)
                                        //   Text(' (${variant.totalQuantity})',
                                        //       style:
                                        //           const TextStyle(fontSize: 12))
                                      ]),
                                  const SizedBox(height: 5),
                                  Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: controller,
                                          style: const TextStyle(
                                              fontSize: 14, height: 1),
                                          cursorColor: Colors.black,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          cursorHeight: 15,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true
                                              // contentPadding: EdgeInsets.only(
                                              //     left: 5, bottom: 15),
                                              ),
                                          // onChanged: (value) {
                                          //   int newQuantity = int.tryParse(value) ??
                                          //       variant.quantity;
                                          //   _controller
                                          //       .updateProductQuantityWithInput(
                                          //           product.sId,
                                          //           variant.variantId,
                                          //           newQuantity,
                                          //           product.setId);
                                          // },
                                          onChanged: (value) {},
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 22),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _controller.onSubmitAddToCart();
                    },
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _controller.onSubmitDifferentQuantity();
                    },
                    child: const Text(
                      'Submit Booking form',
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
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
