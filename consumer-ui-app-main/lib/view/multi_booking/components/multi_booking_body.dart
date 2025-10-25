// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/view/multi_booking/components/multi_booking_design1.dart';
import 'package:black_locust/view/multi_booking/components/multi_booking_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiBookingBody extends StatelessWidget {
  MultiBookingBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final MultiBookingController _controller;
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    var template = _controller.template.value;
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (template['instanceId'] == 'design2') {
          return MultiBookingDesign2(controller: _controller);
        } else {
          return MultiBookingDesign1(controller: _controller);
        }
      }
    });
  }
}
