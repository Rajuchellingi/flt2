import 'package:black_locust/controller/loyality_coupon_wallet_controller.dart';
import 'package:black_locust/view/loyality_coupon_wallet/components/loyality_coupon_wallet_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityCouponWalletScreen extends StatelessWidget {
  final _controller = Get.find<LoyalityCouponWalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Coupons', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: LoyalityCouponWalletBody(controller: _controller),
    );
  }
}
