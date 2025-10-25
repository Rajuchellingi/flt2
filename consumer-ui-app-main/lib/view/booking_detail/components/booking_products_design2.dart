// ignore_for_file: unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingProductsDesign2 extends StatelessWidget {
  const BookingProductsDesign2({
    Key? key,
    required this.products,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final List<BookingProductsVM> products;
  final BookingDetailController _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Booking Items",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Booking ID :'),
                      Text(
                        _controller.bookingDetail.value.bookingNo.toString(),
                      )
                    ]),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    getShortStatusLabel(
                            _controller.bookingDetail.value.status.toString())
                        .toString(),
                    style: TextStyle(
                      color: kPrimaryLightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Wrap(children: [
              for (var i = 0; i < products.length; i++) ...[
                Text(products[i].productName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                if (i < products.length - 1)
                  const Text(', ',
                      style: TextStyle(fontWeight: FontWeight.bold))
              ]
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Booked: '),
              Text(
                CommonHelper.convetToDate(
                    _controller.bookingDetail.value.creationDate),
              )
            ]),
            const SizedBox(height: 15),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Total Amount'),
                Text(
                    _controller.bookingDetail.value.price!.currencySymbol
                            .toString() +
                        _controller.bookingDetail.value.price!.subTotalPrice!
                            .toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ]),
              Column(children: [])
            ]),
          ]),
        ),
      )
    ]);
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
