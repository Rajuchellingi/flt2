// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/loyality_controller.dart';
import 'scratch_spin_section.dart';

class LoyalityRewardBody extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Coins Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(loyality.rewardMobileBannerLink!)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total Coins: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        loyality.points.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    loyality.loginMainTitle!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    loyality.loginDescription!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    child: const Text('Start Booking',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            if (loyality.customerHistoryDetails!.isNotEmpty) ...[
              // Recent Coins Earned
              Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                  child: Text('Recent Coins Earned',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))),
                              if (loyality.customerHistoryDetails!.length > 3)
                                GestureDetector(
                                    onTap: () {
                                      _controller.isViewAll.value =
                                          !_controller.isViewAll.value;
                                    },
                                    child: Text(
                                        "View ${_controller.isViewAll.value ? 'less' : 'all'}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline)))
                            ]),
                            const SizedBox(height: 8),
                            if (_controller.isViewAll.value == true) ...[
                              Container(
                                  height: 220,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      for (var history in getHistoryData(
                                          loyality.customerHistoryDetails,
                                          _controller.isViewAll.value)) ...[
                                        _coinRow(
                                            history.title,
                                            history.creationDate,
                                            history.redeemCoins),
                                        SizedBox(height: 10),
                                      ]
                                    ],
                                  )))
                            ] else ...[
                              Column(children: [
                                for (var history in getHistoryData(
                                    loyality.customerHistoryDetails,
                                    _controller.isViewAll.value)) ...[
                                  _coinRow(history.title, history.creationDate,
                                      history.redeemCoins),
                                  SizedBox(height: 10),
                                ]
                              ]),
                            ],
                            const SizedBox(height: 6),
                            Text(
                              'Keep booking for more coins and rewards!',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13),
                            )
                          ]))),
              const SizedBox(height: 24)
            ],

            // Scratch Cards & Spin Wheels Section
            ScratchSpinSection(),
            const SizedBox(height: 24),

            if (loyality.customerAchievementsDetails!.isNotEmpty) ...[
              Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Achievements & Progress
                            Text('Your Achievements & Progress',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 15),
                            Column(children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  for (var rule in getMilestones()) ...[
                                    Container(
                                        width: getMilestones().length > 1
                                            ? (SizeConfig.screenWidth / 2) - 40
                                            : SizeConfig.screenWidth,
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  '/loyalityAchievement',
                                                  arguments: {"rule": rule});
                                            },
                                            child: _achievementIcon(
                                                isUnlocked(rule)
                                                    ? Icons.check_circle
                                                    : Icons.lock,
                                                rule.rewardTitle!,
                                                isUnlocked(rule)
                                                    ? 'Unlocked'
                                                    : 'Earn to Unlock',
                                                isUnlocked(rule)
                                                    ? kPrimaryColor
                                                    : Colors.grey)))
                                  ],
                                  // _achievementIcon(
                                  //     Icons.lock,
                                  //     'Bulk Booking King',
                                  //     'Earn to Unlock',
                                  //     Colors.grey),
                                ],
                              ),
                              // LinearProgressIndicator(
                              //   value: 0.75,
                              //   backgroundColor: Colors.grey[300],
                              //   color: Colors.blue,
                              // ),
                              // const SizedBox(height: 8),
                              // Text(
                              //   'Only 3 more orders to unlock \'Reorder Champion\' badge!',
                              //   style: TextStyle(
                              //       fontSize: 13,
                              //       color: Colors.grey[700]),
                              // ),
                            ]),
                          ]))),
              const SizedBox(height: 24)
            ],

            // Earn More Coins
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Complete your next order to earn more coins and unlock exclusive rewards!',
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor.withAlpha(30),
                        foregroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                      child: const Text('Earn More Coins',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  isUnlocked(rule) {
    var achievements = _controller.loyality.value.customerAchievementsDetails!
        .where((da) => da.earningRuleId == rule.id);
    return achievements.first.currentStage == rule.mileStoneStage;
  }

  getMilestones() {
    var earningRules = _controller.loyality.value.earningRuleData!;
    if (earningRules.isNotEmpty) {
      return earningRules.where((da) => da.type == 'mile-stone');
    }
    return [];
  }

  getHistoryData(history, isViewAll) {
    if (history == null || history.isEmpty) {
      return [];
    }

    if (history.length <= 3) {
      return history;
    } else {
      if (!isViewAll) {
        return history.sublist(0, 3);
      } else {
        return history;
      }
    }
  }

  Widget _coinRow(String title, String date, String coins) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 232, 232),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(date,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$coins coins',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(int.parse(_controller
                          .loyality.value.primaryColor!
                          .replaceAll('#', '0xff')))),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _achievementIcon(
      IconData icon, String title, String subtitle, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 36),
        const SizedBox(height: 4),
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(subtitle, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}
