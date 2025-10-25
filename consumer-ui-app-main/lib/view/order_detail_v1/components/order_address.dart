// ignore_for_file: must_be_immutable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderAddress extends StatelessWidget {
  const OrderAddress({Key? key, required this.address, required this.title})
      : super(key: key);
  final title;
  final OrderAddressVM address;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor)),
          const SizedBox(height: 7),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (address.contactName != null &&
                        address.contactName!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(address.contactName.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor))),
                    if (address.address != null && address.address!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(address.address.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor))),
                    if (address.landmark != null &&
                        address.landmark!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(address.landmark.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            '${address.city}, ${address.state} ${address.pinCode}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('${address.country}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor))),
                    if (address.mobileNumber != null &&
                        address.mobileNumber!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('Mobile Number: ${address.mobileNumber}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor))),
                  ]))
        ]);
  }
}
