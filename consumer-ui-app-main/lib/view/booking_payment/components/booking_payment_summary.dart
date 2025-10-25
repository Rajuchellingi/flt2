import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingPaymentSummary extends StatelessWidget {
  const BookingPaymentSummary({
    Key? key,
    required this.orderSummary,
  }) : super(key: key);

  final BookingPriceVM orderSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Summary",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal :",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "${orderSummary.currencySymbol.toString() + "${orderSummary.subTotalPrice!.toStringAsFixed(2)}"}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )),
        if (orderSummary.discount != null && orderSummary.discount! > 0)
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount :",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "- ${orderSummary.currencySymbol.toString() + "${orderSummary.discount!.toStringAsFixed(2)}"}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
        Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Taxes :",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                    "${orderSummary.currencySymbol.toString() + "${orderSummary.totalGstPrice!.toStringAsFixed(2)}"}",
                    style: const TextStyle(fontSize: 14)),
              ],
            )),
        Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total :",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${orderSummary.currencySymbol.toString() + "${orderSummary.totalPrice!.toStringAsFixed(2)}"}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
