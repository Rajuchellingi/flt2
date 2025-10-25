// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductsV1 extends StatelessWidget {
  CartProductsV1({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final CartV1Controller _controller;
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    final productSetting = productSettingController.productSetting.value;
    // print("totlSummary ${_controller.totlSummary}");
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            const Divider(),
            ..._controller.productList.value.map<Widget>((product) {
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
                                    product.image.imageId +
                                    '/' +
                                    "78-102" +
                                    "/" +
                                    product.image.imageName,
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
                                    Get.toNamed('/detail', arguments: product);
                                  },
                                  child: Text(
                                    product.productName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              const SizedBox(height: 5),
                              if (product.sTypename == 'product') ...[
                                if (product.productVariant != null &&
                                    product.productVariant!.isNotEmpty)
                                  for (var element in product.productVariant!)
                                    Text(
                                        "${element.attributeLabelName} : ${element.attributeFieldValue}"),
                                SizedBox(height: 5)
                              ],
                              if (product.sTypename == "pack" &&
                                  product.isCustomizable == true) ...[
                                if (product.setIsCustomizable == false) ...[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "1 Set = ${product.setQuantityValue} Pieces; ${getSetQuantity(product.variants)}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ))
                                ] else if (product.isAssorted == true) ...[
                                  Container(
                                      child: Text(
                                    "1 Set = ${product.setQuantityValue} Pieces; Assorted ${product.preferenceVariant!.attributeLabelName};",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  )),
                                ]
                              ],
                              if (product.sTypename == 'set' &&
                                  product.isCustomizable == false &&
                                  product.isAssorted == true)
                                Container(
                                    child: Text(
                                  "1 Set = ${product.moq} Pieces; Assorted ${product.setQuantity!.variantType};",
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                )),
                              if (product.sTypename == 'set' &&
                                  product.isCustomizable == false &&
                                  product.isAssorted == false)
                                Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "1 Set = ${product.moq} Pieces; ${getSetQuantity(product.setQuantity!.variantQuantites)}",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    )),
                              if (product.sTypename == 'pack' &&
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
                                  if (productSetting.priceDisplayType ==
                                      'mrp') ...[
                                    Text(
                                      product.price.currencySymbol +
                                          product.price.mrp.toString() +
                                          (product.sTypename == "pack" ||
                                                  product.sTypename == "set"
                                              ? " / Piece"
                                              : ""),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    )
                                  ] else ...[
                                    Text(
                                      product.price.currencySymbol +
                                          product.price.sellingPrice
                                              .toString() +
                                          (product.sTypename == "pack" ||
                                                  product.sTypename == "set"
                                              ? " / Piece"
                                              : ""),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                  const SizedBox(width: 5),
                                  if (productSetting.priceDisplayType ==
                                          'mrp-and-selling-price' &&
                                      product.sTypename != "pack" &&
                                      product.sTypename != "set") ...[
                                    // Text(
                                    //   'MRP: ',
                                    //   style: TextStyle(fontSize: 11),
                                    // ),
                                    Text(
                                      product.price.currencySymbol +
                                          product.price.mrp.toString(),
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                  ],
                                  Text(
                                    (product.price.discount != null &&
                                            product.price.discount > 0)
                                        ? '${product.price.discount} % Off'
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
                              Text(
                                "Price:  " +
                                    product.price.currencySymbol +
                                    product.totalPrice.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if ((product.sTypename == "pack" &&
                                      product.isCustomizable == false) ||
                                  (product.sTypename == "pack" &&
                                      product.isCustomizable == true &&
                                      product.setIsCustomizable == false) ||
                                  (product.sTypename == "set" &&
                                      product.isCustomizable == false) ||
                                  (product.sTypename == "set" &&
                                      product.isAssorted == true) ||
                                  product.sTypename == "product")
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  padding: EdgeInsets.symmetric(
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
                                                if (product.quantity > 1) {
                                                  // Decrease quantity
                                                  _controller
                                                      .updateProductQuantityReduce(
                                                          product.sId,
                                                          product.variantId,
                                                          product.quantity ==
                                                                  null
                                                              ? 0
                                                              : product
                                                                  .quantity,
                                                          product);
                                                }
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
                                                product.quantity.toString(),
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
                                                // Increase quantity
                                                _controller
                                                    .updateProductQuantityAdd(
                                                        product.sId,
                                                        product.variantId,
                                                        product.quantity == null
                                                            ? 0
                                                            : product.quantity,
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
                    if ((product.sTypename == "pack" &&
                            product.isCustomizable == true &&
                            product.setIsCustomizable == true) ||
                        (product.sTypename == "set" &&
                            product.isCustomizable == true))
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: product.variants.map<Widget>((variant) {
                          final TextEditingController controller =
                              TextEditingController(
                            text:
                                variant.quantity != null && variant.quantity > 0
                                    ? variant.quantity.toString()
                                    : '',
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Text(
                                    variant.attributeFieldValue,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  if (variant.trackQuantity == true &&
                                      variant.continueSellingWhenOutOfStock ==
                                          false)
                                    Text(' (${variant.totalQuantity})',
                                        style: const TextStyle(fontSize: 12))
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
                                        onChanged: (value) {
                                          int? newQuantity =
                                              int.tryParse(value);
                                          // if (newQuantity == null) {
                                          //   newQuantity = variant.quantity;
                                          // }
                                          _controller
                                              .updateProductQuantityWithInput(
                                            product.sId,
                                            variant.variantId,
                                            newQuantity,
                                            product.setId,
                                          );
                                        },
                                      ),
                                    )),
                                if (productSetting.showVariantPrice ==
                                    true) ...[
                                  const SizedBox(height: 5),
                                  if (productSetting.priceDisplayType ==
                                      'mrp') ...[
                                    Text(
                                      '${product.price.currencySymbol + variant.mrp.toString()} / Piece',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    )
                                  ] else ...[
                                    Text(
                                      '${product.price.currencySymbol + variant.sellingPrice.toString()} / Piece',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    )
                                  ]
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _controller.moveToWishlist(
                                  product.sId, product.productId, product);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child:
                                        Icon(Icons.favorite_border, size: 18),
                                  ),
                                  const Text("Move to Wishlist",
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: const Icon(CupertinoIcons.delete,
                                        size: 16)),
                                const Text("Remove",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Confirm Removal",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Are you sure you want to remove this product from your cart?",
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _controller.removeProduct(
                                                  product.sId, product.setId);
                                            },
                                            child: const Text("Remove"),
                                            style: ElevatedButton.styleFrom(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      );
    });
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
