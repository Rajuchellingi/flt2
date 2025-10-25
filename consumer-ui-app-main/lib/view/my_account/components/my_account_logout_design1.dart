// ignore_for_file: invalid_use_of_protected_member, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountLogoutDesign1 extends StatelessWidget {
  MyAccountLogoutDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: brightness == Brightness.dark
                  ? Colors.white
                  : kPrimaryTextColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Navigator.of(context).pop();
          _controller.logOut();
        },
        child: Text(
          "Logout",
          style: TextStyle(
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor,
            fontSize: getProportionateScreenWidth(18),
          ),
        ),
      ),
    );
  }
}
