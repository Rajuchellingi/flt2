// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaysToRedeem extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button + Title
            Row(
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
                Text(
                  loyality.waysToRedeemTitle.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                // First Reward
                if (loyality.redemptionRuleData!.isNotEmpty) ...[
                  for (var coupon in loyality.redemptionRuleData!) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (coupon.title != null &&
                                  coupon.title!.isNotEmpty) ...[
                                Text(
                                  coupon.title!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2)
                              ],
                              if (coupon.description != null &&
                                  coupon.description!.isNotEmpty) ...[
                                Text(
                                  coupon.description!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(),
                    ),
                  ]
                ] else ...[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      alignment: Alignment.center,
                      child: Text("No data found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)))
                ]
              ],
            ))),
            // const Spacer(),

            // Join Now Button
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _controller.changeRoute('/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse(_controller
                      .loyality.value.primaryColor!
                      .replaceAll('#', '0xff'))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  loyality.callToActionSignUpText!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(int.parse(_controller.loyality.value.textColor!
                        .replaceAll('#', '0xff'))),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Sign In
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                      onTap: () {
                        _controller.changeRoute('/login');
                      },
                      child: Text(
                        loyality.calltoActionSignInText.toString(),
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
