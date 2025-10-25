// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_apply_coupon_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponCodeDesign3 extends StatelessWidget {
  CouponCodeDesign3({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();
  final couponController = Get.find<ApplyCoupenController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          if (_controller.discountCode.value != null)
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Expanded(
                      child: Text(_controller.discountCode.value!.code!,
                          style: const TextStyle(fontWeight: FontWeight.w500))),
                  GestureDetector(
                      onTap: () {
                        _controller.removeDiscount();
                      },
                      child: const Icon(Icons.clear, color: Colors.grey)),
                ]))
          else
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    context: context,
                    builder: (BuildContext context) {
                      return CartApplyCouponDesign2(
                          controller: couponController);
                    },
                  ).then((value) {
                    if (value == true) _controller.getCartPriceDetails();
                  });
                },
                child: Row(children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              bottomLeft: const Radius.circular(20),
                            ),
                          ),
                          child: _controller.discountCode.value != null
                              ? Text(_controller.discountCode.value!.code!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500))
                              : const Text("Enter  promo code",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                        ),
                        color: kPrimaryColor,
                      ),
                      child: const Text(
                        "APPLY",
                        style: TextStyle(color: Colors.white),
                      ))
                ])),
          const SizedBox(height: 20),
        ]));
  }
}
