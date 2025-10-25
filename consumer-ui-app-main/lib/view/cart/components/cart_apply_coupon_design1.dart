// ignore_for_file: unused_field, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/view/cart/components/cart_apply_coupon_input_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartApplyCouponDesign1 extends StatelessWidget {
  final controller;

  const CartApplyCouponDesign1({
    Key? key,
    required this.controller,
  })  : _controller = controller,
        super(key: key);
  final ApplyCoupenController _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      return Container(
          height: SizeConfig.screenHeight / 1.7,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              color: brightness == Brightness.dark ? Colors.black : kBackground,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_controller.isLoading.value == false) ...[
                  Center(
                      child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey))),
                  const SizedBox(height: 10),
                  CartApplyCoupenInputDesign1(controller: _controller),
                  const SizedBox(height: 10),
                  const Text("Your Promo Codes",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  if (_controller.coupenCodes.value != null &&
                      _controller.coupenCodes.length > 0) ...[
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      for (var element in _controller.coupenCodes.value)
                        Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                color: brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (element.heading != null) ...[
                                    Text(element.heading,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    const SizedBox(height: 5),
                                  ],
                                  Text(element.couponCode,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              )),
                              const SizedBox(width: 15),
                              Column(children: [
                                Text(getDaysRemaining(element.endDate),
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                                const SizedBox(height: 5),
                                InkWell(
                                    onTap: () {
                                      _controller.applyDiscountCoupen(element);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Text("Apply",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white))))
                              ])
                            ]))
                    ])))
                  ] else ...[
                    const Expanded(
                        child: Center(
                            child: Text("No Promo Codes Available",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400))))
                  ]
                ] else ...[
                  Container(
                      height: (SizeConfig.screenHeight / 1.7) - 20,
                      child: const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ))
                ]
              ]));
    });
  }

  String getDaysRemaining(String targetDateString) {
    DateTime targetDate = DateTime.parse(targetDateString);
    DateTime currentDate = DateTime.now();
    int daysRemaining = targetDate.difference(currentDate).inDays;
    return '$daysRemaining days remaining';
  }
}
