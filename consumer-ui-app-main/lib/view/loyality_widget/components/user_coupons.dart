// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCoupons extends StatelessWidget {
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
            // Header Row
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.changeWidgetPage('back');
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
                  const Text(
                    "Coupons",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // History List
            if (loyality.couponDetails!.isNotEmpty) ...[
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: loyality.couponDetails!.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final coupon = loyality.couponDetails![index];
                  return ListTile(
                    onTap: () {
                      _controller.setSelectedCoupon(coupon);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 20,
                      child: const Text("🎁"),
                    ),
                    title: Text(
                      coupon.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      coupon.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    trailing:
                        const Icon(Icons.chevron_right, color: Colors.black54),
                  );
                },
              )),
            ] else ...[
              Center(child: Container(child: Text("No activity found")))
            ],
          ],
        ),
      );
    });
  }
}
