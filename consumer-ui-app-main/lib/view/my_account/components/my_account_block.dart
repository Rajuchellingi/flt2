// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/my_account/components/my_account_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'my_account_detail.dart';
import 'my_account_logout.dart';
import 'my_account_menu.dart';
import 'my_account_policy.dart';

class MyAccountBlock extends StatelessWidget {
  MyAccountBlock({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var userId = GetStorage().read('utoken');
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                for (var item in blocks) ...[
                  if (item['componentId'] == 'account-detail-component' &&
                      item['visibility']['hide'] == false &&
                      userId != null)
                    MyAccountDetail(controller: _controller, design: item)
                  else if (item['componentId'] == 'account-detail-component' &&
                      item['visibility']['hide'] == false &&
                      userId == null)
                    MyAccountLogin()
                  else if (item['componentId'] == 'account-menu-component' &&
                      item['visibility']['hide'] == false &&
                      userId != null)
                    MyAccountMenu(controller: _controller, design: item)
                  else if (item['componentId'] == 'policy-component' &&
                      item['visibility']['hide'] == false)
                    MyAccountPolicy(controller: _controller, design: item)
                  else if (item['componentId'] == 'logout-component' &&
                      item['visibility']['hide'] == false &&
                      userId != null)
                    MyAccountLogout(controller: _controller, design: item)
                ],
                if (footer != null &&
                    footer.isNotEmpty &&
                    themeController.bottomBarType.value == 'design1' &&
                    footer['componentId'] == 'footer-navigation')
                  const SizedBox(height: 80),
              ])));
    });
  }
}
