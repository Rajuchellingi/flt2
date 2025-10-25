import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:flutter/material.dart';

class CheckoutV1PaymentSummary extends StatelessWidget {
  const CheckoutV1PaymentSummary({
    Key? key,
    required this.orderSummary,
  }) : super(key: key);

  final CheckoutPriceSummaryVM orderSummary;

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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price (${orderSummary.totalCartQuantity} Pieces) : ",
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              orderSummary.currencySymbol.toString() +
                  "${orderSummary.subTotal!.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
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
        if (orderSummary.taxes != null && orderSummary.taxes!.length > 0)
          for (var element in orderSummary.taxes!)
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${element.labelName} :",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "${orderSummary.currencySymbol.toString() + "${element.amount!.toStringAsFixed(2)}"}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        // const SizedBox(height: 5),
        if (orderSummary.totalTax != null && orderSummary.totalTax! > 0)
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tax : ",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "${orderSummary.currencySymbol.toString() + "${orderSummary.totalTax!.toStringAsFixed(2)}"}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "${orderSummary.currencySymbol.toString() + "${orderSummary.total!.toStringAsFixed(2)}"}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
