// ignore_for_file: must_be_immutable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/model/cart_v1_model.dart';
import 'package:black_locust/view/cart_v1/components/cart_address_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSummary extends StatelessWidget {
  CartSummary({Key? key, required this.price, required this.controller})
      : super(key: key);
  CartProductPriceSummary price;
  final productSettingController = Get.find<ProductSettingController>();
  final CartV1Controller controller;

  @override
  Widget build(BuildContext context) {
    final productSetting = productSettingController.productSetting.value;
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (productSetting.cartSummaryType == 'quantity-summary') ...[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                "Total Quantity :",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              Text(
                "${price.totalCartQuantity} Pieces",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade900),
              )
            ])
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price (${price.totalCartQuantity} Pieces) ",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  price.currencySymbol.toString() +
                      "${price.subTotal!.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            if (price.discount != null && price.discount! > 0)
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Discount :",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        "- ${price.currencySymbol.toString() + "${price.discount!.toStringAsFixed(2)}"}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  )),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total :",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text(
                  "${price.currencySymbol.toString() + "${price.total!.toStringAsFixed(2)}"}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade900),
                ),
              ],
            )
          ],
          const SizedBox(height: 15),
          if (controller.isDownloadQuotation.value) ...[
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: OutlinedButton(
                  onPressed: () {
                    controller.downloadQuotation();
                  },
                  child: Text(
                    controller.quotationDownloadText.value.isNotEmpty
                        ? controller.quotationDownloadText.value
                        : "Download Quotation",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: kPrimaryColor),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                  ),
                ))
          ],
          if (controller.isInvoiceDownload.value) ...[
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: OutlinedButton(
                  onPressed: () async {
                    await controller.getAddress();
                    showModalBottomSheet(
                      showDragHandle: true,
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CartAddressDesign1(controller: controller));
                      },
                    );
                  },
                  child: Text(
                    controller.invoiceDownloadText.value.isNotEmpty
                        ? controller.invoiceDownloadText.value
                        : "Download Invoice",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: kPrimaryColor),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                  ),
                ))
          ]
          // ElevatedButton(
          //   onPressed: () {
          //     Get.toNamed('/checkout');
          //   },
          //   child: Text("Proceed to Checkout"),
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: Size(double.infinity, 50),
          //   ),
          // ),
        ],
      ),
    );
  }
}
