// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/booking_payment_success_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPaymentSuccessBody extends StatefulWidget {
  const BookingPaymentSuccessBody({
    Key? key,
    required controller,
  })  : _bController = controller,
        super(key: key);
  final BookingPaymentSuccessController _bController;
  @override
  _BookingConfirmationPageState createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingPaymentSuccessBody>
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
    return Obx(() => widget._bController.isBooked.value == true
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
                  'Thank you for Payment!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your booking payment was successful. You can view your booking details or continue shopping.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      Get.offAndToNamed('/bookingDetail',
                          arguments: {'id': widget._bController.bookingId});
                    },
                    child: const Text("View Booking",
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
            child: const Text("Booking Not Found",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))));
  }
}
