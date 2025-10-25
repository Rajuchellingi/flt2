// ignore_for_file: deprecated_member_use

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/order_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConfirmedBody extends StatefulWidget {
  const OrderConfirmedBody({
    Key? key,
    required controller,
  })  : _bController = controller,
        super(key: key);
  final OrderConfirmationController _bController;
  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmedBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget._bController.isOrder.value == true
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(30.0),
                        child: const Icon(
                          Icons.check_circle_outline_sharp,
                          color: Colors.teal,
                          size: 100,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Thank you for Order!',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your order is confirmed! For more details, please click on "View Order."',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      if (platform == 'shopify') {
                        Get.offAndToNamed('/orderHistory', arguments: {
                          'id': widget._bController.orderId,
                          "isOrderDetail": true
                        });
                      } else {
                        Get.offAndToNamed('/orderDetail',
                            arguments: {'id': widget._bController.orderId});
                      }
                    },
                    child: const Text("View Order",
                        style: const TextStyle(color: Colors.black))),
                const SizedBox(height: 5),
                OutlinedButton(
                    onPressed: () {
                      Get.offAndToNamed('/home');
                    },
                    child: const Text("Continue Shopping",
                        style: const TextStyle(color: Colors.black)))
              ],
            ),
          )
        : const Center(
            child: const Text("Order Not Found",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))));
  }
}
