// ignore_for_file: unused_element

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/account_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/size_config.dart';

class MyAccountLogin extends StatelessWidget {
  final AccountSettingController aController =
      Get.find<AccountSettingController>();
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Welcome",
          style: TextStyle(
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor,
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.05),
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(56),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                  color: brightness == Brightness.dark
                      ? kPrimaryColor == Colors.black
                          ? Colors.white
                          : kPrimaryColor
                      : kPrimaryColor),
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.toNamed('/login', arguments: {"path": "/myAccount"});
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: getProportionateScreenWidth(18),
              ),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(56),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.toNamed('/register', arguments: Get.arguments);
            },
            child: Text(
              "Create Account",
              style: TextStyle(
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor,
                fontSize: getProportionateScreenWidth(18),
              ),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        // Obx(() {
        //   return Column(
        //     children: aController.accoundMenuCollections
        //         .map((item) => _buildPolicyOptionsSection(context, item))
        //         .toList(),
        //   );
        // }),
      ],
    );
  }

  Widget _buildPolicyOptionsSection(context, data) {
    // print("data ${data}");
    return Column(
      children: [
        _buildOptionButtonWithoutIcon(
          context,
          label: data['title'],
          onPressed: () {
            Get.toNamed('/pages', arguments: data);
          },
        ),
      ],
    );
  }

  Widget _buildOptionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(46),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.black),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Text(
                    label,
                    style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor,
                      fontSize: getProportionateScreenWidth(14),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButtonWithoutIcon(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(46),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icon(icon, color: Colors.black),
                  Text(
                    label,
                    style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor,
                      fontSize: getProportionateScreenWidth(14),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
