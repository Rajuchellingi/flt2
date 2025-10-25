// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/loyality_widget/components/coupon_redeem.dart';
import 'package:black_locust/view/loyality_widget/components/loyality_home.dart';
import 'package:black_locust/view/loyality_widget/components/loyality_login.dart';
import 'package:black_locust/view/loyality_widget/components/redeemed_coupon.dart';
import 'package:black_locust/view/loyality_widget/components/user_activity_history.dart';
import 'package:black_locust/view/loyality_widget/components/user_coupons.dart';
import 'package:black_locust/view/loyality_widget/components/user_ways_to_earn.dart';
import 'package:black_locust/view/loyality_widget/components/user_ways_to_redeem.dart';
import 'package:black_locust/view/loyality_widget/components/ways_to_earn.dart';
import 'package:black_locust/view/loyality_widget/components/ways_to_redeem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityRoute extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var route = _controller.route.value;
      if (route == 'login') return LoyalityLogin();
      if (route == 'home')
        return LoyalityHome();
      else if (route == 'ways-to-earn')
        return WaysToEarn();
      else if (route == 'ways-to-redeem')
        return WaysToRedeem();
      else if (route == 'history')
        return UserActivityHistory();
      else if (route == 'coupons')
        return UserCoupons();
      else if (route == 'user-ways-to-earn')
        return UserWaysToEarn();
      else if (route == 'user-ways-to-redeem')
        return UserWaysToRedeem();
      else if (route == 'coupon-redeem')
        return CouponRedeem();
      else if (route == 'redeemed-coupon')
        return RedeemedCoupon();
      else
        return SizedBox.shrink();
    });
  }
}
