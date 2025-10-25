// ignore_for_file: invalid_use_of_protected_member, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountMenuDesign3 extends StatelessWidget {
  MyAccountMenuDesign3({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          for (var menu in design['source']['lists']) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(46),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    overlayColor: kPrimaryColor,
                    side: BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    themeController.navigateByType(
                        design['options'][menu['key']]['screenId']);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Icon(icon, color: Colors.black),

                          themeController.iconByTheme(
                              design['options'][menu['key']]['icon'],
                              brightness == Brightness.dark
                                  ? kPrimaryColor
                                  : kPrimaryColor),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Text(
                            design['options'][menu['key']]['label'],
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    ],
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
