// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RedeemedCoupon extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      var coupon = _controller.selectedCoupon.value;
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
                      _controller.changeWidgetPage('coupons');
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
                ],
              ),
            ),

            // Rewards List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coupon.title.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      coupon.description.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // Coupon Code Box with Copy Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        color: _controller.isCopied.value
                            ? const Color.fromARGB(255, 238, 255, 238)
                            : null,
                        border: Border.all(
                            color: _controller.isCopied.value
                                ? Colors.green
                                : Colors.black54),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!_controller.isCopied.value) ...[
                            Text(
                              coupon.couponCode.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                _controller.copyCouponCode();
                              },
                            )
                          ] else ...[
                            Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: const Text(
                                      "Copied!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.green),
                                    )))
                          ]
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Expiry Info
                    Row(
                      children: [
                        const Icon(Icons.hourglass_bottom, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "Expires on ${calculateExpiryDate(coupon.creationDate.toString(), coupon.expiryDays!)}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Button
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
                onPressed: () {
                  _controller.changeRoute('/home');
                },
                child: Text(
                  "Apply Coupon Code",
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

  String calculateExpiryDate(String creationDate, int expiryDays) {
    // Parse the creation date from ISO8601 string
    DateTime parsedDate = DateTime.parse(creationDate);

    // Add expiry days
    DateTime expiryDate = parsedDate.add(Duration(days: expiryDays));

    // Format date as "Month Day, Year"
    String formattedDate = DateFormat("MMMM d, y").format(expiryDate);

    return formattedDate;
  }
}
