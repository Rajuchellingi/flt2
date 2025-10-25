import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:flutter/material.dart';

class BookingPaymentSummaryDesign2 extends StatelessWidget {
  const BookingPaymentSummaryDesign2(
      {Key? key, required this.orderSummary, required this.productCount})
      : super(key: key);

  final productCount;
  final CheckoutPriceSummaryVM orderSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Booking Overview",
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
                  "Total Products ",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  productCount.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Quantity ",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "${orderSummary.totalCartQuantity} Pieces",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
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
            Divider(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount:",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "${orderSummary.currencySymbol.toString() + "${orderSummary.total!.toStringAsFixed(2)}"}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
