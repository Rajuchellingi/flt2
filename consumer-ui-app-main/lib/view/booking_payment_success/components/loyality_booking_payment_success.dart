import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_payment_success_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyaltyBookingPaymentSuccess extends StatelessWidget {
  LoyaltyBookingPaymentSuccess({
    Key? key,
    required controller,
  })  : _bController = controller,
        super(key: key);
  final BookingPaymentSuccessController _bController;
  final loyalityController = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    var milstones = getMilestones();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Booking Confirmed Header with Gradient
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Column(children: [
                    // Success Icon
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 60,
                        color: kSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Payment Successful!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Thanks for booking with us. Let's see what you've won...",
                        style: TextStyle(
                          fontSize: 16,
                          color: kSecondaryColor.withOpacity(0.95),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.stars_rounded,
                            color: Colors.amber, size: 20),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "Every booking gets you closer to exclusive rewards",
                            style: TextStyle(
                              fontSize: 14,
                              color: kSecondaryColor.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.stars_rounded,
                            color: Colors.amber, size: 20),
                      ],
                    ),
                  ]),
                ),
              )),
          SizedBox(height: 24),

          // Scratch Card
          // Text(
          //   'Scratch to win bonus points, free items, or unlock your stage!',
          //   style: TextStyle(fontSize: 15, color: Colors.black87),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 16),
          // GestureDetector(
          //   onTap: () {
          //   },
          //   child: Container(
          //     height: 160,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [Colors.purpleAccent, Colors.blueAccent],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.touch_app, color: Colors.white, size: 36),
          //           SizedBox(height: 8),
          //           Text(
          //             'Tap to Reveal',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 24),

          // Reward Journey
          if (milstones.isNotEmpty) ...[
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.emoji_events_rounded,
                          color: kPrimaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Your Reward Journey',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  for (var rule in milstones) ...[
                    Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: kPrimaryColor.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (var i = 1;
                                    i <= rule.mileStoneStage;
                                    i++) ...[
                                  _stageCircle(
                                      isCompleted(rule.id, i), 'Stage ${i}',
                                      stage: i,
                                      highlight: isCurrentStage(rule.id, i)),
                                  if (i != rule.mileStoneStage)
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 22),
                                        height: 3,
                                        decoration: BoxDecoration(
                                          gradient: isCompleted(rule.id, i)
                                              ? LinearGradient(
                                                  colors: [
                                                    kPrimaryColor,
                                                    kPrimaryColor.withOpacity(0.6)
                                                  ],
                                                )
                                              : null,
                                          color: isCompleted(rule.id, i)
                                              ? null
                                              : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    )
                                ],
                              ]),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_giftcard_rounded,
                                  color: kPrimaryColor,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    rule.rewardTitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]))
                  ],
                ])),
            SizedBox(height: 24),
          ],

          // Reward Card
          // Card(
          //   color: Color(0xFFF7F7F7),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Row(
          //       children: [
          //         Icon(Icons.card_giftcard, color: Colors.pink, size: 32),
          //         SizedBox(width: 12),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Win a Meet & Greet with Sunny Leone!',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 15,
          //                 ),
          //               ),
          //               SizedBox(height: 4),
          //               Text(
          //                 'Complete all 5 scratch card stages to earn a ticket to an exclusive S&P event.',
          //                 style:
          //                     TextStyle(fontSize: 13, color: Colors.black54),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 24),

          // Action Buttons
          Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: [
                  // View Booking Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAndToNamed('/bookingDetail',
                            arguments: {'id': _bController.bookingId});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kSecondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_long_rounded, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'View Booking Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  // View Rewards Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        Get.offAndToNamed('/loyalityReward');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.redeem_rounded,
                            color: kPrimaryColor,
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Explore All Rewards',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 20),

          // Checkbox
          // Row(
          //   children: [
          //     Checkbox(
          //       value: false,
          //       onChanged: (val) {},
          //     ),
          //     Text(
          //       'Notify me after each booking to scratch next stage',
          //       style: TextStyle(fontSize: 13),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
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

  getMilestones() {
    var earningRules = loyalityController.loyality.value.earningRuleData!;
    if (earningRules.isNotEmpty) {
      return earningRules.where((da) => da.type == 'mile-stone');
    }
    return [];
  }
}

Widget _stageCircle(bool completed, String label,
    {bool highlight = false, int stage = 0}) {
  return Container(
      child: Column(
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: highlight || completed
              ? [
                  BoxShadow(
                    color: highlight
                        ? Colors.amber.withOpacity(0.5)
                        : kPrimaryColor.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: highlight
              ? Colors.amber
              : completed
                  ? kPrimaryColor
                  : Colors.grey[300],
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: highlight || completed
                    ? Colors.white.withOpacity(0.3)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: highlight
                  ? Text(
                      '${stage}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  : completed
                      ? Icon(Icons.check_rounded,
                          color: Colors.white, size: 22)
                      : Icon(Icons.lock_rounded,
                          color: Colors.grey[500], size: 20),
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: highlight
              ? Colors.amber[800]
              : completed
                  ? kPrimaryColor
                  : Colors.grey[600],
          fontWeight: highlight || completed ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    ],
  ));
}
