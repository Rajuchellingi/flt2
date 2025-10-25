// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:black_locust/controller/booking_summary_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/booking_summary/components/booking_summary_design1.dart';
import 'package:black_locust/view/booking_summary/components/booking_summary_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSummaryBody extends StatelessWidget {
  BookingSummaryBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingSummaryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var template = _controller.template.value;
      if (template['instanceId'] == 'design2') {
        return BookingSummaryDesign2(controller: _controller);
      } else {
        return BookingSummaryDesign1(controller: _controller);
      }
    });
  }
}
