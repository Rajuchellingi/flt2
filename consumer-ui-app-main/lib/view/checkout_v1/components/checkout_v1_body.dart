// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_address.dart';
import 'package:black_locust/view/checkout_v1/components/checkout_v1_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1Body extends StatelessWidget {
  const CheckoutV1Body({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CheckoutV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          // physics: AlwaysScrollableScrollPhysics(),
          child: (_controller.checkoutData.value.products != null &&
                  _controller.checkoutData.value.products.isNotEmpty)
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: _controller.currentStage.value == 'address'
                      ? CheckoutV1Address(controller: _controller)
                      : _controller.currentStage.value == 'summary'
                          ? CheckoutV1Summary(controller: _controller)
                          : Container())
              : Container(
                  height: SizeConfig.screenHeight / 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty_cart.png',
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
