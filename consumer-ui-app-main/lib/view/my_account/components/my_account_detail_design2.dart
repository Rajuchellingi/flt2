// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountDetailDesign2 extends StatelessWidget {
  MyAccountDetailDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final user = _controller.userProfile.value;
    final brightness = Theme.of(context).brightness;
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: brightness == Brightness.dark
                  ? Colors.white
                  : kPrimaryTextColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: AssetImage(
                  "assets/images/profile_avatar.jpg",
                ),
                radius: 35.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstName ?? '',
                      style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                    if (user.emailId != null)
                      Text(
                        user.emailId ?? '',
                        style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
