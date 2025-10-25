// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_apply_coupon_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponCodeDesign2 extends StatelessWidget {
  CouponCodeDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();
  final couponController = Get.find<ApplyCoupenController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Icon(Icons.sell_outlined),
                  const SizedBox(width: 5),
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
                      return CartApplyCouponDesign1(
                          controller: couponController);
                    },
                  ).then((value) {
                    if (value == true) _controller.getCartPriceDetails();
                  });
                },
                child: Stack(children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        color: brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            bottomLeft: const Radius.circular(12),
                            topRight: const Radius.circular(20),
                            bottomRight: const Radius.circular(20)),
                      ),
                      child: _controller.discountCode.value != null
                          ? Text(_controller.discountCode.value!.code!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))
                          : const Text("Enter your promo code",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500))),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )))
                ])),
          const SizedBox(height: 20),
        ])));
  }
}
