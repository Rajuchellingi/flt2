import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingDetailSummaryDesign2 extends StatelessWidget {
  const BookingDetailSummaryDesign2({Key? key, required this.price})
      : super(key: key);
  final BookingPriceVM price;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Price Breakdown',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 10),
      Card(
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        elevation: 2,
        surfaceTintColor:
            brightness == Brightness.dark ? Colors.black : Colors.white,
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8),
            buildRow(
                'Product Total',
                price.currencySymbol.toString() +
                    price.subTotalPrice!.toStringAsFixed(2)),
            if (price.totalGstPrice != null && price.totalGstPrice! > 0)
              buildRow(
                'Tax',
                price.currencySymbol.toString() +
                    price.totalGstPrice!.toStringAsFixed(2),
              ),
            if (price.discount != null && price.discount! > 0)
              buildRow(
                  'Discount',
                  price.currencySymbol.toString() +
                      price.discount!.toStringAsFixed(2)),
            Divider(),
            buildTotalRow(
                'Grand Total',
                price.currencySymbol.toString() +
                    price.totalPrice!.toStringAsFixed(2)),
          ]),
        ),
      )
    ]);
  }

  Widget buildTotalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
