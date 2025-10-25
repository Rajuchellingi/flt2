// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoupenCodeDesign1 extends StatelessWidget {
  CoupenCodeDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const SizedBox(height: 10),
          Container(
              child: Text(
            _controller.discountCode.value == null
                ? "Have a coupon code?"
                : "Coupon code applied",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          const SizedBox(height: 8),
          if (_controller.discountCode.value != null) ...[
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.discount_outlined, size: 18),
                  const SizedBox(width: 5),
                  Text(_controller.discountCode.value!.code!,
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: () {
                        _controller.removeDiscount();
                      },
                      child: const Icon(Icons.cancel, size: 20)),
                ]))
          ],
          GestureDetector(
              onTap: () {
                _controller.openApplyCoupen();
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          _controller.discountCode.value == null
                              ? "View Coupons"
                              : "Change Coupon",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ))),
          const SizedBox(height: 10),
          const Divider(),
        ]));
  }
}
