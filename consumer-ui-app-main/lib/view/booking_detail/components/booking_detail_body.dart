// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/view/booking_detail/components/booking_detail_design1.dart';
import 'package:black_locust/view/booking_detail/components/booking_detail_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailBody extends StatelessWidget {
  final BookingDetailController _controller;

  const BookingDetailBody({
    Key? key,
    required BookingDetailController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var instanceId = _controller.template.value['instanceId'];
        if (instanceId == 'design2')
          return BookingDetailDesign2(controller: _controller);
        else
          return BookingDetailDesign1(controller: _controller);
      },
    );
  }
}
