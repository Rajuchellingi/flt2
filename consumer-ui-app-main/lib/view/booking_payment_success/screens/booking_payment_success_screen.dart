// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, unused_element, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_payment_success_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/booking_payment_success/components/booking_payment_success_body.dart';
import 'package:black_locust/view/booking_payment_success/components/loyality_booking_payment_success.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPaymentSuccessScreen extends StatelessWidget {
  final themeController = Get.find<ThemeController>();
  final _controller = Get.find<BookingPaymentSuccessController>();
  final loyalityController = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      return SafeArea(
          child: Scaffold(
        appBar: (header != null && header.isNotEmpty)
            ? AppBar(
                backgroundColor: themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                elevation: 0.0,
                forceMaterialTransparency: true,
                title: CommonHeader(header: header),
              )
            : null,
        body: _controller.isLoading.value == true
            ? LoadingIcon(
                logoPath: themeController.logo.value,
              )
            : loyalityController.isLoyality.value
                ? LoyaltyBookingPaymentSuccess(controller: _controller)
                : BookingPaymentSuccessBody(controller: _controller),
      ));
    });
  }

  Color _getProgressBackgroundColor(Brightness brightness) {
    if (brightness == Brightness.dark && kPrimaryColor == Colors.black) {
      return Colors.white;
    }
    return Color.fromRGBO(
      kPrimaryColor.red,
      kPrimaryColor.green,
      kPrimaryColor.blue,
      0.2,
    );
  }
}
