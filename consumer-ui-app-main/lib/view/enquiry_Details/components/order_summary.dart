// ignore_for_file: must_be_immutable

import 'package:black_locust/model/enquiry_model.dart';
import 'package:flutter/material.dart';

class EnquirySummary extends StatelessWidget {
  const EnquirySummary({Key? key, required this.price}) : super(key: key);
  final OrderPriceVM price;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Enquiry Summary",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 7),
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
                                child: const Text("Subtotal",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ))),
                            Expanded(
                                child: Text(
                                    price.currencySymbol.toString() +
                                        price.subTotalPrice!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    )))
                          ])),
                    if (price.discount != null && price.discount! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Discount",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ))),
                            Expanded(
                                child: Text(
                                    '-' +
                                        price.currencySymbol.toString() +
                                        price.discount!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    )))
                          ])),
                    if (price.totalGstPrice != null && price.totalGstPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Taxes",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ))),
                            Expanded(
                                child: Text(
                                    price.currencySymbol.toString() +
                                        price.totalGstPrice!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    )))
                          ])),
                    if (price.totalPrice != null)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Total",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Expanded(
                                child: Text(
                                    price.currencySymbol.toString() +
                                        price.totalPrice!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red.shade900,
                                        fontWeight: FontWeight.bold)))
                          ])),
                    if (price.refundedPrice != null && price.refundedPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Refunded",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ))),
                            Expanded(
                                child: Text(
                                    "- ${price.currencySymbol.toString()}${price.refundedPrice!.toStringAsFixed(2)}",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 13)))
                          ])),
                  ]))
        ]);
  }
}
