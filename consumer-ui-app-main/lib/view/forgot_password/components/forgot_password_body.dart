// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/forgot_password_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/forgot_password/components/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/size_config.dart';

class ForgotPasswordBody extends StatelessWidget {
  final _controller = Get.find<ForgotPasswordController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() => Column(children: [
          if (_controller.isLoading.value == true)
            LoadingIcon(
              logoPath: themeController.logo.value,
            ),
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 70),
                          ForgotPasswordForm()
                        ],
                      ),
                    ),
                  ))),
        ]));
  }
}
