// ignore_for_file: invalid_use_of_protected_member, unused_import, deprecated_member_use

import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/my_account/components/booking_recent_history.dart';
import 'package:black_locust/view/my_account/components/my_account_hlpline.dart';
import 'package:black_locust/view/my_account/components/my_account_music.dart';
import 'package:black_locust/view/my_account/components/my_accountRecentOrderHistory.dart';
import 'package:black_locust/view/my_account/components/my_account_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountDetailDesign1a extends StatelessWidget {
  MyAccountDetailDesign1a({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final AccountController _controller;
  final themeController = Get.find<ThemeController>();
  final p_controller = Get.find<ProfileV1Controller>();

  @override
  Widget build(BuildContext context) {
    final user = _controller.userProfile.value;
    final brightness = Theme.of(context).brightness;

    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              decoration: BoxDecoration(
                color: brightness == Brightness.dark
                    ? Colors.grey[900]
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Settings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
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
                              user.firstName ?? 'Guest User',
                              style: TextStyle(
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (user.emailId != null)
                              Text(
                                user.emailId!,
                                style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.grey[300]
                                      : Colors.black87,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MyAddressPersonalInfoBody(controller: p_controller),
                ],
              ),
            ),

            const SizedBox(height: 20),
            BookingRecentHistory(controller: _controller),
            const SizedBox(height: 20),

            // Order History
            OrderHistoryCard(controller: _controller),

            const SizedBox(height: 20),

            // Music Settings
            MusicSettingsCard(),

            const SizedBox(height: 20),

            // Help & Support
            // HelpSupportCard(),
          ],
        ),
      ),
    );
  }
}
