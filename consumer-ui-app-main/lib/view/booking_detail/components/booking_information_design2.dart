import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';

class BookingInformationDesign2 extends StatelessWidget {
  const BookingInformationDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingDetailController _controller;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Booking ID'),
                Text(_controller.bookingDetail.value.bookingNo.toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ]),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  getShortStatusLabel(
                          _controller.bookingDetail.value.status.toString())
                      .toString(),
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 2),
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Booking Date'),
              Text(
                  CommonHelper.convetToDate(
                      _controller.bookingDetail.value.creationDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ))
            ]),
            Column(children: [])
          ]),
          const SizedBox(height: 2),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 2),
          const Text('Shipping Address'),
          Wrap(children: [
            if (_controller.bookingDetail.value.shippingAddress!.address !=
                    null &&
                _controller
                    .bookingDetail.value.shippingAddress!.address!.isNotEmpty)
              Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${_controller.bookingDetail.value.shippingAddress!.address.toString()}, ",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            if (_controller.bookingDetail.value.shippingAddress!.landmark !=
                    null &&
                _controller
                    .bookingDetail.value.shippingAddress!.landmark!.isNotEmpty)
              Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${_controller.bookingDetail.value.shippingAddress!.landmark.toString()}, ",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                    '${_controller.bookingDetail.value.shippingAddress!.city}, ${_controller.bookingDetail.value.shippingAddress!.state} ${_controller.bookingDetail.value.shippingAddress!.pinCode}',
                    style: const TextStyle(fontWeight: FontWeight.bold))),
          ]),
          const SizedBox(height: 2),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 2),
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Total Amount'),
              Text(
                  _controller.bookingDetail.value.price!.currencySymbol
                          .toString() +
                      _controller.bookingDetail.value.price!.totalPrice!
                          .toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ))
            ]),
            Column(children: [])
          ]),
        ]),
      ),
    );
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
