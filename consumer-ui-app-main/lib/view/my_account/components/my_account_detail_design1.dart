// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountDetailDesign1 extends StatelessWidget {
  MyAccountDetailDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final user = _controller.userProfile.value;
    final String initials =
        (user.firstName != null && user.firstName!.length >= 2)
            ? user.firstName!.substring(0, 2).toUpperCase()
            : (user.firstName != null && user.firstName!.isNotEmpty)
                ? user.firstName!.substring(0, 1).toUpperCase()
                : '!';
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(50)),
      decoration: BoxDecoration(
        color: brightness == Brightness.dark
            ? Colors.white
            : themeController.defaultStyle(
                'backgroundColor', design['style']['backgroundColor']),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                brightness == Brightness.dark ? Colors.black : Colors.white,
            child: Text(
              initials,
              style: TextStyle(
                color:
                    brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.firstName != null && user.firstName!.isNotEmpty) ...[
                  Text(
                    'Hello, ${user.firstName}',
                    style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.black
                          : themeController.defaultStyle(
                              'color', design['style']['color']),
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  user.emailId ?? '',
                  style: TextStyle(
                    color: brightness == Brightness.dark
                        ? Colors.black
                        : themeController.defaultStyle(
                            'color', design['style']['color']),
                    fontSize: getProportionateScreenWidth(14),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
