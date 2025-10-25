// ignore_for_file: unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryDetailDesign3 extends StatelessWidget {
  const OrderHistoryDetailDesign3(
      {Key? key, required this.orderItem, required controller})
      : _controller = controller,
        super(key: key);
  final orderItem;
  final _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
      color: brightness == Brightness.dark ? Colors.black : Colors.white,
      elevation: 2,
      surfaceTintColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      // borderOnForeground: true,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Order ID"),
                    Text(orderItem.orderNo,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    orderItem.status,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Placed on"),
              Text(CommonHelper.converToDateByType(orderItem.creationDate),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 8),
            Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Products"),
                  Expanded(
                      child: Text(orderItem.productNames.join(', '),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
            SizedBox(height: 8),
            Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount"),
                  Text("${orderItem.currencySymbol}${orderItem.totalPrice}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ]),
            SizedBox(height: 12),
            // Container(
            //   padding: EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Color(0xFFFFFAEC),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.stars, color: Colors.orange),
            //       SizedBox(width: 8),
            //       Text("Coins Earned", style: TextStyle(color: Colors.grey)),
            //       Spacer(),
            //       Text(order['coins']!,
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //     ],
            //   ),
            // ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    _controller.navigateToOrderDetails(orderItem);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor.withAlpha(30),
                    foregroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 5,
                    children: [
                      const Text('View Order Details'),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  String orderQuantity(products) {
    num quantity = 0;
    for (var product in products) {
      quantity += product.quantity;
    }
    return quantity.toString();
  }

  String formatDate(String utcDate) {
    DateTime dateTime = DateTime.parse(utcDate);
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }
}
