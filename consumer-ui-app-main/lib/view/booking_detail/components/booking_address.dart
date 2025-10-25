// ignore_for_file: must_be_immutable

import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingAddress extends StatelessWidget {
  const BookingAddress({Key? key, required this.address, required this.title})
      : super(key: key);
  final title;
  final BookingAddressVM address;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
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
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black))),
                    if (address.address != null && address.address!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(address.address.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black))),
                    if (address.landmark != null &&
                        address.landmark!.isNotEmpty)
                      Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(address.landmark.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            '${address.city}, ${address.state} ${address.pinCode}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('${address.country}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Mobile Number: ${address.mobileNumber}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black))),
                  ]))
        ]);
  }
}
