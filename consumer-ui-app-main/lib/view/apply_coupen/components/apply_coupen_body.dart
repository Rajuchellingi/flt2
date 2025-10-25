// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/view/apply_coupen/components/apply_coupen_input.dart';
import 'package:black_locust/view/apply_coupen/components/coupen_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyCoupenBody extends StatelessWidget {
  const ApplyCoupenBody({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final ApplyCoupenController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? Container(
              child: const Center(
              child: const CircularProgressIndicator(color: kPrimaryColor),
            ))
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ApplyCoupenInput(controller: _controller),
              if (_controller.coupenCodes.value != null &&
                  _controller.coupenCodes.length > 0) ...[
                Expanded(child: CoupenList(controller: _controller))
              ],
            ]),
    );
  }
}
