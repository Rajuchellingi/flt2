// ignore_for_file: deprecated_member_use

import '../const/size_config.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton(
      {Key? key, required this.icon, required this.onPressed, this.color})
      : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(30),
      width: getProportionateScreenWidth(30),
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              backgroundColor: color!.withOpacity(0.5),
              padding: EdgeInsets.zero),
          onPressed: onPressed,
          child: Icon(icon)),
    );
  }
}
