// ignore_for_file: invalid_use_of_protected_member, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountMenuDesign2 extends StatelessWidget {
  MyAccountMenuDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var menus = assignProfileMenu();
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20),
          for (var i = 0; i < menus.length; i++) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: i != menus.length - 1
                    ? Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )
                    : null, // No border for the last element
              ),
              child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(46),
                child: InkWell(
                  onTap: () {
                    if (design['options'][menus[i]['key']]['screenId'] ==
                        'web-view') {
                      if (menus[i]['key'] == 'referral-button')
                        _controller.openReferralPage();
                      else if (menus[i]['key'] == 'review-button')
                        _controller.openReviewPage();
                      else if (menus[i]['key'] == 'reward-button')
                        _controller.openRewardPage();
                    } else {
                      themeController.navigateByType(
                          design['options'][menus[i]['key']]['screenId']);
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text(
                              design['options'][menus[i]['key']]['label'] !=
                                      null
                                  ? design['options'][menus[i]['key']]['label']
                                  : '',
                              style: TextStyle(
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            descriptionByType(menus[i]['key'],
                                design['options'][menus[i]['key']])
                          ])),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  assignProfileMenu() {
    var menus = [];
    if (design['source']['lists'] != null &&
        design['source']['lists'].length > 0) {
      for (var menu in design['source']['lists']) {
        if (_controller.nectarMenus.contains(menu['key'])) {
          if (_controller.isRewards.value) {
            menus.add(menu);
          }
        } else {
          menus.add(menu);
        }
      }
    }
    return menus;
  }

  Widget descriptionByType(type, source) {
    final user = _controller.userProfile.value;
    final brightness = Theme.of(Get.context!).brightness;
    if (type == 'profile-button' && source['description'] != null) {
      return Container(
          child: Text(source['description'],
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontSize: 12)));
    } else if (type == 'address-button' &&
        source['show-total-count'] == true &&
        user.numberOfAddresses! > 0) {
      return Container(
          child: Text('${user.numberOfAddresses} addresses',
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontSize: 12)));
    } else if (type == 'order-history-button' &&
        source['show-total-count'] == true &&
        user.numberOfOrders! > 0) {
      return Container(
          child: Text('Already have ${user.numberOfOrders} orders',
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  fontSize: 12)));
    } else {
      return Container();
    }
  }
}
