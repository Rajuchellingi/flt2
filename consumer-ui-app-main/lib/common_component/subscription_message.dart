import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/subscription_controller.dart';

class SubscriptionMessage extends StatelessWidget {
  const SubscriptionMessage({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final SubscriptionController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Center(
              child: _controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/no_subscription.webp'),
                          const SizedBox(height: 20),
                          const Text(
                            'Sorry for the inconvenience!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Your subscription has expired. Please try again later',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
            )));
  }
}
