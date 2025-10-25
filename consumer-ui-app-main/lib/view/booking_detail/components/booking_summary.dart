// ignore_for_file: must_be_immutable

import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key, required this.price}) : super(key: key);
  final BookingPriceVM price;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Booking Summary",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
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
                                child: const Text("Subtotal",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black))),
                            Expanded(
                                child: Text(
                                    price.currencySymbol.toString() +
                                        price.subTotalPrice!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black)))
                          ])),
                    if (price.discount != null && price.discount! > 0)
                      Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Discount",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black))),
                            Expanded(
                                child: Text(
                                    '-' +
                                        price.currencySymbol.toString() +
                                        price.discount!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black)))
                          ])),
                    if (price.totalGstPrice != null && price.totalGstPrice! > 0)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Taxes",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black))),
                            Expanded(
                                child: Text(
                                    price.currencySymbol.toString() +
                                        price.totalGstPrice!.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black)))
                          ])),
                    if (price.totalPrice != null && price.totalPrice! > 0)
                      Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                                child: const Text("Total",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
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
                  ]))
        ]);
  }
}
