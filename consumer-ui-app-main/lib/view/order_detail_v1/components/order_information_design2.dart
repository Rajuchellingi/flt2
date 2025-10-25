import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInformationDesign2 extends StatelessWidget {
  const OrderInformationDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final OrderDetailV1Controller _controller;
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
                const Text('Order ID'),
                Text(_controller.orderDetail.value.orderNo.toString(),
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
                  toBeginningOfSentenceCase(
                          _controller.orderDetail.value.status.toString())
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
              Text('Order Date'),
              Text(
                  CommonHelper.convetToDate(
                      _controller.orderDetail.value.creationDate),
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
            if (_controller.orderDetail.value.shippingAddress!.address !=
                    null &&
                _controller
                    .orderDetail.value.shippingAddress!.address!.isNotEmpty)
              Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${_controller.orderDetail.value.shippingAddress!.address.toString()}, ",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            if (_controller.orderDetail.value.shippingAddress!.landmark !=
                    null &&
                _controller
                    .orderDetail.value.shippingAddress!.landmark!.isNotEmpty)
              Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${_controller.orderDetail.value.shippingAddress!.landmark.toString()}, ",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                    '${_controller.orderDetail.value.shippingAddress!.city}, ${_controller.orderDetail.value.shippingAddress!.state} ${_controller.orderDetail.value.shippingAddress!.pinCode}',
                    style: const TextStyle(fontWeight: FontWeight.bold))),
          ]),
          const SizedBox(height: 2),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 2),
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Total Amount'),
              Text(
                  _controller.orderDetail.value.price!.currencySymbol
                          .toString() +
                      _controller.orderDetail.value.price!.totalPrice!
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
}
