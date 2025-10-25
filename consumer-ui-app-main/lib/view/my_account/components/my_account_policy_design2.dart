// ignore_for_file: invalid_use_of_protected_member, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/account_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountPolicyDesign2 extends StatelessWidget {
  MyAccountPolicyDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final AccountSettingController aController =
      Get.find<AccountSettingController>();
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: aController.accoundMenuCollections
            .map((item) => _buildPolicyOptionsSection(context, item))
            .toList(),
      );
    });
  }

  Widget _buildPolicyOptionsSection(context, data) {
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

  Widget _buildOptionButtonWithoutIcon(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    final brightness = Theme.of(context).brightness;

    return Container(
      decoration: const BoxDecoration(
          border: const Border(
        top: const BorderSide(width: 0.2, color: Colors.grey),
      )),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(46),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                label,
                style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontSize: 15,
                ),
              )),
              Icon(Icons.arrow_forward_ios,
                  size: 16,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
            ],
          ),
        ),
      ),
    );
  }
}
