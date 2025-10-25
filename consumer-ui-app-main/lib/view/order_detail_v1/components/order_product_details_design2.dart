// ignore_for_file: unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderProductDetailsDesign2 extends StatelessWidget {
  const OrderProductDetailsDesign2({
    Key? key,
    required this.products,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final List<OrderProductsVM> products;
  final OrderDetailV1Controller _controller;

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
                      const Text('Order ID :'),
                      Text(
                        _controller.orderDetail.value.orderNo.toString(),
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
                    toBeginningOfSentenceCase(
                            _controller.orderDetail.value.status.toString())
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
                    _controller.orderDetail.value.creationDate),
              )
            ]),
            const SizedBox(height: 15),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Total Amount'),
                Text(
                    _controller.orderDetail.value.price!.currencySymbol
                            .toString() +
                        _controller.orderDetail.value.price!.subTotalPrice!
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
}
