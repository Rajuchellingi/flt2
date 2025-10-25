import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1SummaryAddress extends StatelessWidget {
  const CheckoutV1SummaryAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  final CheckoutAddressVM address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivering to ${address.contactName}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(child: Text(address.address.toString())),
        if (address.landmark != null && address.landmark!.isNotEmpty)
          Container(child: Text(address.landmark.toString())),
        Container(child: Text(address.city.toString())),
        Container(
            child: Text(
                '${address.state}, ${address.pinCode}, ${address.country}')),
        Container(child: Text('Phone number: ${address.mobileNumber}')),
        const SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "Change Address",
              style: TextStyle(color: Colors.blue[400]),
            ))
      ],
    );
  }
}
