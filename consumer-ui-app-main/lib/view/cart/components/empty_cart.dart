import 'package:black_locust/const/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        CachedNetworkImage(
          height: 225,
          width: 225,
          color: brightness == Brightness.light ? Colors.black : Colors.white,
          imageUrl:
              "https://toautomation-image.s3.ap-south-1.amazonaws.com/ri/toautomation/file/4767/7eb421c5-1275-429a-a3f3-7e74bfbe9eb7-8593283.png",
        ),

        const Center(
            child: const Text(
          'Your cart is empty!',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
        const SizedBox(height: 60),
        // Divider()
      ],
    ));
  }

  Padding buildPadding(childp) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 2),
      child: childp,
    );
  }
}
