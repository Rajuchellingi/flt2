// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/view/multi_booking/components/apply_same_quantity_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplySameQuantityBody extends StatelessWidget {
  ApplySameQuantityBody({
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
        if (template['instanceId'] == 'design1') {
          return ApplySameQuantityDesign1(controller: _controller);
        } else {
          return SizedBox.shrink();
        }
      }
    });
  }
}
