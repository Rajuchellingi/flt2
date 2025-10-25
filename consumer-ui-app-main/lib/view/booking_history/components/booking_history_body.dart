// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/booking_history_controller.dart';
import 'package:black_locust/view/booking_history/components/booking_history_design1.dart';
import 'package:black_locust/view/booking_history/components/booking_history_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryBody extends StatelessWidget {
  const BookingHistoryBody({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final BookingHistoryController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var instanceId = _controller.template.value['instanceId'];
        if (instanceId == 'design2')
          return BookingHistoryDesign2(controller: _controller);
        else
          return BookingHistoryDesign1(controller: _controller);
      },
    );
  }
}
