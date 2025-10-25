// ignore_for_file: unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryDetailDesign2 extends StatelessWidget {
  const BookingHistoryDetailDesign2(
      {Key? key, required this.bookingItem, required controller})
      : _controller = controller,
        super(key: key);
  final bookingItem;
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
                    const Text("Booking ID"),
                    Text(bookingItem.bookingNo,
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
                    getShortStatusLabel(bookingItem.status.toString()),
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
              const Text("Booked on"),
              Text(CommonHelper.converToDateByType(bookingItem.creationDate),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 8),
            Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Products"),
                  Expanded(
                      child: Text(bookingItem.productNames.join(', '),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
            SizedBox(height: 8),
            Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount"),
                  Text("${bookingItem.currencySymbol}${bookingItem.totalPrice}",
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
                    _controller.navigateToBookingDetails(bookingItem);
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
                      const Text('View Booking Details'),
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

  String getShortStatusLabel(String status) {
    switch (status) {
      case 'created':
        return 'Created';
      case 'confirmed':
        return 'Confirmed';
      case 'cancelled':
        return 'Cancelled';
      case 'approved':
        return 'Approved';
      case 'paid-waiting-for-approval':
        return 'Awaiting Approval';
      case 'forwarded-to-admin':
        return 'Sent to Admin';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
