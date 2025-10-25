// ignore_for_file: unused_field, invalid_use_of_protected_member, must_be_immutable

import 'package:black_locust/common_component/quick_cart_design1.dart';
import 'package:black_locust/common_component/quick_cart_design2.dart';
import 'package:black_locust/common_component/quick_cart_design3.dart';
import 'package:black_locust/controller/quick_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickCart extends StatelessWidget {
  final image;
  final title;
  final price;
  String design;
  final dynamic product;

  QuickCart(
      {Key? key,
      required this.product,
      required this.image,
      this.design = 'design1',
      required this.price,
      required this.title})
      : super(key: key);
  final _controller = Get.find<QuickCartController>();

  @override
  Widget build(BuildContext context) {
    if (design == 'design2') {
      return SafeArea(
          child: QuickCartDesign2(
        image: image,
        price: price,
        product: product,
        title: title,
      ));
    } else if (design == 'design3') {
      return SafeArea(
          child: QuickCartDesign3(
        image: image,
        price: price,
        product: product,
        title: title,
      ));
    } else {
      return SafeArea(
          child: QuickCartDesign1(
        image: image,
        price: price,
        product: product,
        title: title,
      ));
    }
  }
}
