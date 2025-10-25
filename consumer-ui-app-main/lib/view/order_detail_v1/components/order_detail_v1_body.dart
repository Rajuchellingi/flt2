// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/view/order_detail_v1/components/order_detail_v1_design1.dart';
import 'package:black_locust/view/order_detail_v1/components/order_detail_v1_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailV1Body extends StatelessWidget {
  final OrderDetailV1Controller _controller;

  const OrderDetailV1Body({
    Key? key,
    required OrderDetailV1Controller controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var instanceId = _controller.template.value['instanceId'];
        if (instanceId == 'design2')
          return OrderDetailV1Design2(controller: _controller);
        else
          return OrderDetailV1Design1(controller: _controller);
      },
    );
  }
}
