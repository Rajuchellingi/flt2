// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPaymentOption extends StatelessWidget {
  const BookingPaymentOption({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingPaymentController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(top: 10),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      selectedTileColor: kPrimaryColor.withOpacity(0.1),
                      selected: _controller.paymentMode.value == 'online',
                      activeColor: kPrimaryColor,
                      title: const Text('Online Payment',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      value: 'online',
                      groupValue: _controller.paymentMode.value,
                      onChanged: (value) {
                        _controller.changePaymentMode('online');
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300, width: 1.5))),
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      selectedTileColor: kPrimaryColor.withOpacity(0.1),
                      selected:
                          _controller.paymentMode.value == 'cash-on-delivery',
                      activeColor: kPrimaryColor,
                      title: const Text('Cash on Delivery',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      value: 'cash-on-delivery',
                      groupValue: _controller.paymentMode.value,
                      onChanged: (value) {
                        _controller.changePaymentMode('cash-on-delivery');
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
