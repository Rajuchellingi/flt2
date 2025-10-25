import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/loyality_achievement_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityAchievementBody extends StatelessWidget {
  LoyalityAchievementBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final LoyalityAchievementController _controller;
  final loyalityController = Get.find<LoyalityController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = loyalityController.loyality.value;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _StageProgress(
                controller: _controller,
              ),
            ),
            Divider(thickness: 1),
            if (loyality.couponDetails!.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Coupons You've Won",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/loyalityCouponWallet');
                        },
                        child: Text("View Details",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 14))),
                  ],
                ),
              ),
              for (var coupon in getCouponList(loyality.couponDetails!))
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: _CouponCard(
                    status: coupon.status!,
                    date: CommonHelper.formatLongDate(coupon.creationDate!),
                    title: coupon.title!,
                    code: coupon.couponCode!,
                    unlockedFrom: coupon.description!,
                    loyalityController: loyalityController,
                    expiryDays: coupon.expiryDays!,
                    validUntil: getValidUntilDate(
                        coupon.creationDate!, coupon.expiryDays!),
                    daysRemaining: getRemainingDays(
                        coupon.creationDate!, coupon.expiryDays!),
                  ),
                )
            ],
            SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}

getCouponList(data) {
  if (data.length > 3) {
    return data.sublist(0, 3); // return only first 3
  } else {
    return data; // return all if 3 or less
  }
}

String getValidUntilDate(String creationDate, int totalDays) {
  // Parse ISO date string
  DateTime date = DateTime.parse(creationDate);

  // Add totalDays
  DateTime validUntil = date.add(Duration(days: totalDays));

  // Format to "Month day, Year"
  return "${_getMonthName(validUntil.month)} ${validUntil.day}, ${validUntil.year}";
}

String _getMonthName(int month) {
  const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return months[month - 1];
}

int getRemainingDays(String startDate, int totalDays) {
  DateTime start = DateTime.parse(startDate);
  DateTime today = DateTime.now();

  // Calculate how many days have passed
  int daysPassed = today.difference(start).inDays;

  // Remaining days
  int remaining = totalDays - daysPassed;

  return remaining > 0 ? remaining : 0; // never return negative days
}

class _StageProgress extends StatelessWidget {
  _StageProgress({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final LoyalityAchievementController _controller;
  final loyalityController = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var rule = _controller.selectedRule.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "You Are on Stage ${currentStage(rule.id)} of ${rule.mileStoneStage}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )),
          SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 1; i <= rule.mileStoneStage!; i++) ...[
                        _stageCircle(isCompleted(rule.id, i), 'Stage ${i}',
                            stage: i, highlight: isCurrentStage(rule.id, i)),
                        if (i != rule.mileStoneStage)
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 18),
                              height: 2,
                              color: isCompleted(rule.id, i)
                                  ? kPrimaryColor
                                  : Colors.grey,
                            ),
                          )
                      ],
                    ]),
                SizedBox(height: 8),
                Text(
                  rule.rewardDescription!,
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                )
              ])),
        ],
      );
    });
  }

  bool isCompleted(ruleId, stage) {
    var achievements =
        loyalityController.loyality.value.customerAchievementsDetails!;
    if (achievements.isNotEmpty) {
      var currentData = achievements.where((da) => da.earningRuleId == ruleId);
      var currentStage =
          int.tryParse(currentData.first.currentStage.toString()) != null
              ? int.parse(currentData.first.currentStage)
              : 0;
      return currentStage >= stage;
    }
    return false;
  }

  bool isCurrentStage(ruleId, stage) {
    var achievements =
        loyalityController.loyality.value.customerAchievementsDetails!;
    if (achievements.isNotEmpty) {
      var currentData = achievements.where((da) => da.earningRuleId == ruleId);
      var currentStage =
          int.tryParse(currentData.first.currentStage.toString()) != null
              ? int.parse(currentData.first.currentStage)
              : 0;
      return currentStage + 1 == stage;
    }
    return false;
  }

  int currentStage(ruleId) {
    var achievements =
        loyalityController.loyality.value.customerAchievementsDetails!;
    if (achievements.isNotEmpty) {
      var currentData = achievements.where((da) => da.earningRuleId == ruleId);
      var currentStage =
          int.tryParse(currentData.first.currentStage.toString()) != null
              ? int.parse(currentData.first.currentStage)
              : 0;
      return currentStage + 1;
    }
    return 1;
  }
}

Widget _stageCircle(bool completed, String label,
    {bool highlight = false, int stage = 0}) {
  return Container(
      child: Column(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundColor: highlight
            ? Colors.yellow
            : completed
                ? kPrimaryColor
                : Colors.grey[300],
        child: highlight
            ? Text('${stage}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            : completed
                ? Icon(Icons.check, color: Colors.white, size: 18)
                : Icon(Icons.lock, color: Colors.grey, size: 18),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: highlight
              ? Colors.yellow[800]
              : completed
                  ? kPrimaryColor
                  : Colors.grey,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ],
  ));
}

class _CouponCard extends StatelessWidget {
  final String status;
  final String date;
  final String title;
  final String code;
  final String unlockedFrom;
  final String validUntil;
  final LoyalityController loyalityController;
  final int daysRemaining;
  final int expiryDays;

  _CouponCard({
    required this.status,
    required this.expiryDays,
    required this.loyalityController,
    required this.date,
    required this.title,
    required this.code,
    required this.unlockedFrom,
    required this.validUntil,
    required this.daysRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 0,
          borderOnForeground: true,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: status == "active"
                            ? Colors.blue[100]
                            : status == "new"
                                ? Colors.yellow[100]
                                : Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: status == "active"
                              ? Colors.blue
                              : status == "new"
                                  ? Colors.orange
                                  : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(date,
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
                SizedBox(height: 8),
                Text(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: loyalityController.copiedCode.value == code
                            ? const Color.fromARGB(255, 236, 255, 237)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (loyalityController.copiedCode.value == code) ...[
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              child: const Text("Copied!",
                                  style: TextStyle(color: Colors.green)))
                        ] else ...[
                          Text(code,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.copy, color: kPrimaryColor),
                            onPressed: () {
                              loyalityController.copyHistoryCoupon(code);
                            },
                            tooltip: "Copy",
                          )
                        ],
                      ],
                    )),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text(unlockedFrom, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text("Valid until: $validUntil",
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: getProgress(expiryDays, daysRemaining),
                  backgroundColor: kPrimaryColor.withAlpha(50),
                  color: kPrimaryColor,
                ),
                SizedBox(height: 4),
                Text("$daysRemaining days remaining",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: kPrimaryColor.withAlpha(30),
                    foregroundColor: kPrimaryColor,
                    minimumSize: Size(double.infinity, 40),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  child: Text("Use This Coupon"),
                ),
              ],
            ),
          ),
        ));
  }

  double getProgress(int totalDays, int remainingDays) {
    if (totalDays <= 0) return 0.0;
    double progress = (totalDays - remainingDays) / totalDays;
    return progress.clamp(0.0, 1.0);
  }
}
