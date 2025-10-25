// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ColorTextOrButton extends StatelessWidget {
  const ColorTextOrButton(
      {Key? key,
      required this.itemValue,
      required this.colorCode,
      required this.onPress})
      : super(key: key);
  final Color colorCode;
  final itemValue;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Text(
            itemValue,
            style: TextStyle(color: colorCode, fontWeight: FontWeight.w500),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorCode.withOpacity(0.15)),
      ),
    );
  }
}
