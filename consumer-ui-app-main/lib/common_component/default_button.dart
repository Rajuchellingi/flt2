import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';

import '../const/size_config.dart';

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    this.text = 'Click',
    this.isBorder = true,
    this.isDisable = false,
    this.width = double.infinity,
    required this.press,
  }) : super(key: key);
  final String text;
  final bool isBorder;
  final bool isDisable;
  final double width;
  var press;
  void test() {}
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      width: width,
      height: getProportionateScreenHeight(56),
      decoration: new BoxDecoration(
        border: Border.all(
            color: isDarkMode && kPrimaryColor == Colors.black
                ? Colors.white
                : kPrimaryColor),
        gradient: new RadialGradient(
          colors: isDisable
              ? [kSecondaryColor, kSecondaryColor]
              : [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor
                ],
        ),
        borderRadius:
            isBorder ? BorderRadius.circular(20) : BorderRadius.circular(0),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
