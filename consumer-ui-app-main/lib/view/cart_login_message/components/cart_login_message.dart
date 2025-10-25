// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_login_message/components/cart_login_message_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartLoginMessage extends StatelessWidget {
  CartLoginMessage({
    Key? key,
    required this.design,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final design;
  final CartLoginMessageController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var instanceId = design['instanceId'];
    if (instanceId == 'design1') {
      return CartLoginMessageDesign1(
        design: design,
        controller: _controller,
      );
    } else {
      return Container();
    }
  }
}
