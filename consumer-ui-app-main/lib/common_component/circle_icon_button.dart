// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../const/constant.dart';
import '../const/size_config.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {Key? key,
      required this.icon,
      required this.height,
      required this.width,
      required this.color,
      required this.onPressed})
      : super(key: key);
  final IconData icon;
  final double height;
  final double width;
  final Color? color;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: new CircleBorder(),
      splashColor: kPrimaryColor.withOpacity(0.3),
      onTap: onPressed,
      child: Container(
        height: getProportionateScreenHeight(height),
        width: getProportionateScreenWidth(width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color!.withOpacity(0.1),
          // border:
          //     Border.all(color: kPrimaryColor.withOpacity(0.20), width: 0.5)
        ),
        child: Icon(
          icon,
          color: color,
          size: getProportionateScreenHeight(kDefaultPadding),
        ),
      ),
    );
  }
}
