// ignore_for_file: must_be_immutable

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key, required this.price}) : super(key: key);
  final OrderPriceVM price;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Order Summary",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor)),
          const SizedBox(height: 7),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (price.subTotalPrice != null && price.subTotalPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: Text("Subtotal",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor))),
                            Expanded(
                                child: Text(
                                    platform == 'shopify'
                                        ? CommonHelper.currencySymbol() +
                                            price.subTotalPrice!
                                                .toStringAsFixed(2)
                                        : price.currencySymbol.toString() +
                                            price.subTotalPrice!.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor)))
                          ])),
                    if (price.discount != null && price.discount! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: Text("Discount",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor))),
                            Expanded(
                                child: Text(
                                    platform == 'shopify'
                                        ? '-' +
                                            CommonHelper.currencySymbol() +
                                            price.discount!.toStringAsFixed(2)
                                        : '-' +
                                            price.currencySymbol.toString() +
                                            price.discount!.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor)))
                          ])),
                    if (price.totalGstPrice != null && price.totalGstPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: Text("Taxes",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor))),
                            Expanded(
                                child: Text(
                                    platform == 'shopify'
                                        ? CommonHelper.currencySymbol() +
                                            price.totalGstPrice!
                                                .toStringAsFixed(2)
                                        : price.currencySymbol.toString() +
                                            price.totalGstPrice!.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor)))
                          ])),
                    if (price.totalPrice != null)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: Text("Total",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor))),
                            Expanded(
                                child: Text(
                                    platform == 'shopify'
                                        ? CommonHelper.currencySymbol() +
                                            price.totalPrice!.toStringAsFixed(2)
                                        : price.currencySymbol.toString() +
                                            price.totalPrice!.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor,
                                        fontWeight: FontWeight.bold)))
                          ])),
                    if (price.refundedPrice != null && price.refundedPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(children: [
                            Expanded(
                                child: Text("Refunded",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor))),
                            Expanded(
                                child: Text(
                                    platform == 'shopify'
                                        ? "- ${CommonHelper.currencySymbol()}${price.refundedPrice!.toStringAsFixed(2)}"
                                        : "- ${price.currencySymbol.toString()}${price.refundedPrice!.toString()}",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: brightness == Brightness.dark
                                            ? Colors.white
                                            : kPrimaryTextColor)))
                          ])),
                  ]))
        ]);
  }
}
