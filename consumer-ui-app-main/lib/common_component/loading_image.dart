import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Stack(
      children: [
        Center(
          child: Container(
            // width: getProportionateScreenWidth(60),
            // height: getProportionateScreenHeight(60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white),
            child: const Padding(
              padding: const EdgeInsets.all(10),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
