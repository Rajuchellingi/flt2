// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityHome extends StatelessWidget {
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
            // Header Section
            Container(
              width: double.infinity,
              color: Color(int.parse(_controller.loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (loyality.mainTitleWithLogin != null &&
                      loyality.mainTitleWithLogin!.isNotEmpty) ...[
                    Text(
                      loyality.mainTitleWithLogin!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(int.parse(_controller
                            .loyality.value.textColor!
                            .replaceAll('#', '0xff'))),
                      ),
                    ),
                    SizedBox(height: 6)
                  ],
                  if (loyality.titleWithoutLogin != null &&
                      loyality.titleWithoutLogin!.isNotEmpty) ...[
                    Text(
                      loyality.titleWithoutLogin!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(int.parse(_controller
                            .loyality.value.textColor!
                            .replaceAll('#', '0xff'))),
                      ),
                    )
                  ],
                ],
              ),
            ),

            // Coins Card
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    _controller.changeRoute('/loyalityReward');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coins",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.monetization_on,
                              color: Colors.amber, size: 22),
                          SizedBox(width: 6),
                          Text(
                            loyality.points.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right_outlined),
                        ],
                      )
                    ],
                  ),
                )),

            // Grid Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: [
                    _buildGridTile(Icons.history, "History", 'history'),
                    _buildGridTile(
                        Icons.discount_outlined, "Your Coupons", 'coupons'),
                    _buildGridTile(
                        Icons.wallet, "Ways to Earn", 'user-ways-to-earn'),
                    _buildGridTile(
                        Icons.redeem, "Ways to Redeem", 'user-ways-to-redeem'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildGridTile(IconData icon, String title, route) {
    return GestureDetector(
        onTap: () {
          _controller.changeWidgetPage(route);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(icon, size: 28, color: Colors.black87),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ])),
              const Icon(Icons.chevron_right, size: 22, color: Colors.black54),
            ],
          ),
        ));
  }
}
