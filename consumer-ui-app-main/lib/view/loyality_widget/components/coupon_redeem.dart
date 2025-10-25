// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponRedeem extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.changeWidgetPage('user-ways-to-redeem');
                    },
                    icon: const Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade200),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Ways to Redeem",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Rewards List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller.selectedRule.value.title!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _controller.selectedRule.value.description!,
                      style: TextStyle(fontSize: 14),
                    ),
                    const Divider(height: 30),
                    const Text(
                      "How To Get Discount?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• "),
                        Expanded(
                          child: Text("Redeem the discount using your Points"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• "),
                        Expanded(
                          child: Text(
                              "Apply the coupon code at checkout to get the discount"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Redeem Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse(
                      loyality.primaryColor!.replaceAll('#', '0xff'))),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: loyality.points! >=
                        _controller.selectedRule.value.requiredCoin!
                    ? () {
                        _controller.redeemCoupon();
                      }
                    : null,
                child: Text(
                  "Redeem For ${_controller.selectedRule.value.requiredCoin} Points",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(int.parse(
                          loyality.textColor!.replaceAll('#', '0xff')))),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
