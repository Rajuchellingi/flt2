import 'dart:async';
import 'dart:math';

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/model/loyality.model.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scratcher/scratcher.dart';

class ScratchSpinSection extends StatelessWidget {
  final LoyalityController controller = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = controller.loyality.value;
      var scratchHistory = loyality.customerScratchcardHistory ?? [];

      if (scratchHistory.isEmpty) {
        return SizedBox.shrink();
      }

      return Card(
        color: Colors.white,
        borderOnForeground: true,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Scratch Cards & Spin Wheels',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (scratchHistory.length > 6)
                    GestureDetector(
                      onTap: () {
                        controller.isViewAllScratchCard.value =
                            !controller.isViewAllScratchCard.value;
                      },
                      child: Text(
                        "View ${controller.isViewAllScratchCard.value ? 'less' : 'all'}",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _buildScratchCardsGrid(scratchHistory),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildScratchCardsGrid(
      List<CustomerScratchcardHistoryVM> scratchHistory) {
    var displayItems =
        _getScratchCards(scratchHistory, controller.isViewAllScratchCard.value);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemCount: displayItems.length,
      itemBuilder: (context, index) {
        var item = displayItems[index];
        return _buildScratchCard(item);
      },
    );
  }

  Widget _buildScratchCard(CustomerScratchcardHistoryVM item) {
    if (item.type == 'spin-wheel') {
      return _buildSpinWheelCard(item);
    } else {
      return _buildScratchCardItem(item);
    }
  }

  Widget _buildScratchCardItem(CustomerScratchcardHistoryVM item) {
    var scratchCondition = item.scartchCardCondition?.isNotEmpty == true
        ? item.scartchCardCondition!.first
        : null;

    if (item.visibility == true) {
      // Already scratched - show reward details
      return GestureDetector(
        onTap: () {
          _showScratchedCardDetails(item);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(int.parse(controller.loyality.value.primaryColor!
                    .replaceAll('#', '0xff'))),
                Color(int.parse(controller.loyality.value.primaryColor!
                        .replaceAll('#', '0xff')))
                    .withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: Offset(0, 6),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color(int.parse(controller.loyality.value.primaryColor!
                        .replaceAll('#', '0xff')))
                    .withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: ScratchPatternPainter(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.card_giftcard,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      scratchCondition?.scratchCardLabel ?? 'Reward',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rewarded: ${_formatDate(item.creationDate)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Checkmark badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Not scratched yet - show scratch card with animation
      return _AnimatedScratchCard(
        onTap: () {
          _showScratchCardDialog(item);
        },
      );
    }
  }

  Widget _buildSpinWheelCard(CustomerScratchcardHistoryVM item) {
    var spinWheelCondition = item.spinWheelCondition?.firstWhere(
      (da) => da.spinWheelId == item.seletedSpinWheelId,
      orElse: () => item.spinWheelCondition!.first,
    );

    if (item.visibility == true) {
      // Already spun - show reward details
      return GestureDetector(
        onTap: () {
          _showSpunWheelDetails(item);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(int.parse(controller.loyality.value.primaryColor!
                    .replaceAll('#', '0xff'))),
                Color(int.parse(controller.loyality.value.primaryColor!
                        .replaceAll('#', '0xff')))
                    .withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: Offset(0, 6),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color(int.parse(controller.loyality.value.primaryColor!
                        .replaceAll('#', '0xff')))
                    .withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: CircularPatternPainter(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.album,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      spinWheelCondition?.spinWheelLabel ?? 'Reward',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rewarded: ${_formatDate(item.creationDate)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Checkmark badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Not spun yet - show spin wheel with animation
      return _AnimatedSpinWheelCard(
        onTap: () {
          _showSpinWheelDialog(item);
        },
      );
    }
  }

  List<CustomerScratchcardHistoryVM> _getScratchCards(
      List<CustomerScratchcardHistoryVM> history, bool isViewAllScratchCard) {
    if (history.isEmpty) {
      return [];
    }

    if (history.length <= 6) {
      return history;
    } else {
      if (!isViewAllScratchCard) {
        return history.sublist(0, 6);
      } else {
        return history;
      }
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  // SCRATCH CARD DIALOG WITH ACTUAL SCRATCHING
  void _showScratchCardDialog(CustomerScratchcardHistoryVM item) {
    var scratchCondition = item.scartchCardCondition?.isNotEmpty == true
        ? item.scartchCardCondition!.first
        : null;

    final confettiController =
        ConfettiController(duration: Duration(seconds: 3));
    bool isScratched = false;

    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          confettiController.dispose();
          return true;
        },
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Confetti
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: confettiController,
                      blastDirection: pi / 2,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      gravity: 0.1,
                      colors: [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Scratch Card',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Scratch to reveal your reward!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _SilverScratchCard(
                              scratchCondition: scratchCondition,
                              controller: controller,
                              onScratched: () {
                                if (!isScratched) {
                                  setState(() {
                                    isScratched = true;
                                  });
                                  confettiController.play();
                                  _redeemScratchCard(item);
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(double.infinity, 45),
                          ),
                          onPressed: () {
                            confettiController.dispose();
                            Get.back();
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // SPIN WHEEL DIALOG WITH ACTUAL SPINNING
  void _showSpinWheelDialog(CustomerScratchcardHistoryVM item) {
    final confettiController =
        ConfettiController(duration: Duration(seconds: 3));
    final StreamController<int> selected = StreamController<int>();

    // Prepare wheel items
    List<FortuneItem> items = [];
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    if (item.spinWheelCondition != null &&
        item.spinWheelCondition!.isNotEmpty) {
      for (int i = 0; i < item.spinWheelCondition!.length; i++) {
        var condition = item.spinWheelCondition![i];
        items.add(
          FortuneItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                condition.spinWheelLabel ?? 'Prize ${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            style: FortuneItemStyle(
              color: colors[i % colors.length],
              borderColor: Colors.white,
              borderWidth: 2,
            ),
          ),
        );
      }
    }

    bool isSpinning = false;
    bool isSpun = false;
    bool isScratched = false;
    int? winningIndex;
    SpinWheelConditionVM? winningCondition;

    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          confettiController.dispose();
          selected.close();
          return true;
        },
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Confetti
                  if (isSpun)
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: confettiController,
                        blastDirection: pi / 2,
                        blastDirectionality: BlastDirectionality.explosive,
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        gravity: 0.1,
                        colors: [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple,
                        ],
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🎰',
                          style: TextStyle(fontSize: 42),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Spin to Win!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try your luck and win amazing rewards',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        // Show wheel or reward based on state
                        if (!isSpun)
                          Container(
                            height: 320,
                            width: 320,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Outer decorative ring
                                Container(
                                  height: 320,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 3,
                                    ),
                                  ),
                                ),
                                // Fortune Wheel
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: FortuneWheel(
                                    selected: selected.stream,
                                    animateFirst: false,
                                    items: items,
                                    onAnimationEnd: () {
                                      if (winningIndex != null) {
                                        confettiController.play();
                                        _redeemSpinWheel(item, winningIndex!);
                                        // Update the state to show reward
                                        setState(() {
                                          isSpun = true;
                                          winningCondition =
                                              item.spinWheelCondition![
                                                  winningIndex!];
                                        });
                                      }
                                    },
                                    indicators: [
                                      FortuneIndicator(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: TriangleIndicator(
                                            color: Color(int.parse(controller
                                                .loyality.value.primaryColor!
                                                .replaceAll('#', '0xff'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Center button decoration
                                Positioned(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.grey.shade300,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.stars,
                                      color: Color(int.parse(controller
                                          .loyality.value.primaryColor!
                                          .replaceAll('#', '0xff'))),
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isSpun && winningCondition != null)
                          // Check if it's a scratch card or direct reward
                          winningCondition!.isScratchCard == true
                              ? // Show scratch card if not scratched yet
                              !isScratched
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: _SilverScratchCardSpinResult(
                                          winningCondition: winningCondition!,
                                          controller: controller,
                                          onScratched: () {
                                            setState(() {
                                              isScratched = true;
                                            });
                                            if (winningCondition!
                                                    .isScratchCard ==
                                                true)
                                              controller.redeemSpinWheel(
                                                  item.scratchCardId,
                                                  winningCondition!.spinWheelId,
                                                  item.earningRuleId);
                                          },
                                        ),
                                      ),
                                    )
                                  : // Show reward after scratching
                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(int.parse(controller
                                                .loyality.value.primaryColor!
                                                .replaceAll('#', '0xff'))),
                                            Color(int.parse(controller.loyality
                                                    .value.primaryColor!
                                                    .replaceAll('#', '0xff')))
                                                .withOpacity(0.8),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 3,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'You Won!',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          if (winningCondition!.spinWheelType ==
                                              'redemption') ...[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                winningCondition!
                                                            .spinWheelDiscountType ==
                                                        'percentage'
                                                    ? '${winningCondition!.spinWheelValue}% OFF'
                                                    : '₹${winningCondition!.spinWheelValue} OFF',
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ] else ...[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '${winningCondition!.spinWheelValue}',
                                                    style: TextStyle(
                                                      fontSize: 42,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      shadows: [
                                                        Shadow(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          offset: Offset(0, 3),
                                                          blurRadius: 8,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Icon(
                                                    Icons.monetization_on,
                                                    color: Colors.amber,
                                                    size: 42,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          SizedBox(height: 16),
                                          Text(
                                            winningCondition!.spinWheelLabel ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 12),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Reward added to your account',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                              : // Show reward directly if not a scratch card
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(int.parse(controller
                                            .loyality.value.primaryColor!
                                            .replaceAll('#', '0xff'))),
                                        Color(int.parse(controller
                                                .loyality.value.primaryColor!
                                                .replaceAll('#', '0xff')))
                                            .withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'You Won!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      if (winningCondition!.spinWheelType ==
                                          'redemption') ...[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            winningCondition!
                                                        .spinWheelDiscountType ==
                                                    'percentage'
                                                ? '${winningCondition!.spinWheelValue}% OFF'
                                                : '₹${winningCondition!.spinWheelValue} OFF',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${winningCondition!.spinWheelValue}',
                                                style: TextStyle(
                                                  fontSize: 42,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Icon(
                                                Icons.monetization_on,
                                                color: Colors.amber,
                                                size: 42,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      SizedBox(height: 16),
                                      Text(
                                        winningCondition!.spinWheelLabel ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 12),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Reward added to your account',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        SizedBox(height: 20),
                        if (!isSpinning && !isSpun)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color(int.parse(controller
                                      .loyality.value.primaryColor!
                                      .replaceAll('#', '0xff'))),
                                  Color(int.parse(controller
                                          .loyality.value.primaryColor!
                                          .replaceAll('#', '0xff')))
                                      .withOpacity(0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(int.parse(controller
                                          .loyality.value.primaryColor!
                                          .replaceAll('#', '0xff')))
                                      .withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: kSecondaryColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: Size(double.infinity, 56),
                              ),
                              onPressed: () {
                                if (!isSpinning) {
                                  setState(() {
                                    isSpinning = true;
                                    winningIndex =
                                        Random().nextInt(items.length);
                                    selected.add(winningIndex!);
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.autorenew, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'SPIN NOW!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              foregroundColor: kSecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              confettiController.dispose();
                              selected.close();
                              Get.back();
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Show already scratched card details
  void _showScratchedCardDetails(CustomerScratchcardHistoryVM item) {
    var scratchCondition = item.scartchCardCondition?.isNotEmpty == true
        ? item.scartchCardCondition!.first
        : null;

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Icon(
                Icons.card_giftcard,
                size: 80,
                color: Color(int.parse(controller.loyality.value.primaryColor!
                    .replaceAll('#', '0xff'))),
              ),
              SizedBox(height: 16),
              if (scratchCondition?.scratchCardType == 'redemption') ...[
                Text(
                  scratchCondition?.scratchCardDiscountType == 'percentage'
                      ? '${scratchCondition?.scratchCardValue}% off'
                      : '₹${scratchCondition?.scratchCardValue} off',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(int.parse(controller
                        .loyality.value.primaryColor!
                        .replaceAll('#', '0xff'))),
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${scratchCondition?.scratchCardValue}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(int.parse(controller
                            .loyality.value.primaryColor!
                            .replaceAll('#', '0xff'))),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 32,
                    ),
                  ],
                ),
              ],
              SizedBox(height: 16),
              Text(
                scratchCondition?.scratchCardLabel ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Rewarded on: ${_formatDate(item.creationDate)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 45),
                ),
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show already spun wheel details
  void _showSpunWheelDetails(CustomerScratchcardHistoryVM item) {
    var spinWheelCondition = item.spinWheelCondition?.firstWhere(
      (da) => da.spinWheelId == item.seletedSpinWheelId,
      orElse: () => item.spinWheelCondition!.first,
    );

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '🎉',
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(height: 16),
              if (spinWheelCondition?.spinWheelType == 'redemption') ...[
                Text(
                  spinWheelCondition?.spinWheelDiscountType == 'percentage'
                      ? '${spinWheelCondition?.spinWheelValue}% off'
                      : '₹${spinWheelCondition?.spinWheelValue} off',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(int.parse(controller
                        .loyality.value.primaryColor!
                        .replaceAll('#', '0xff'))),
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${spinWheelCondition?.spinWheelValue}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(int.parse(controller
                            .loyality.value.primaryColor!
                            .replaceAll('#', '0xff'))),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 32,
                    ),
                  ],
                ),
              ],
              SizedBox(height: 16),
              Text(
                spinWheelCondition?.spinWheelLabel ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Rewarded on: ${_formatDate(item.creationDate)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 45),
                ),
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Redeem scratch card via API
  Future<void> _redeemScratchCard(CustomerScratchcardHistoryVM item) async {
    try {
      await controller.redeemScratchCard(item);
    } catch (e) {
      print('Error redeeming scratch card: $e');
    }
  }

  // Redeem spin wheel via API
  Future<void> _redeemSpinWheel(
      CustomerScratchcardHistoryVM item, int winningIndex) async {
    try {
      var winningCondition = item.spinWheelCondition![winningIndex];
      if (winningCondition.isScratchCard == false)
        await controller.redeemSpinWheel(item.scratchCardId,
            winningCondition.spinWheelId, item.earningRuleId);
    } catch (e) {
      print('Error redeeming spin wheel: $e');
    }
  }
}

// Animated Scratch Card Widget
class _AnimatedScratchCard extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedScratchCard({required this.onTap});

  @override
  State<_AnimatedScratchCard> createState() => _AnimatedScratchCardState();
}

class _AnimatedScratchCardState extends State<_AnimatedScratchCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFB300),
                    Color(0xFFFF6F00),
                    Color(0xFFFFB300),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.5),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: GoldenPatternPainter(),
                      ),
                    ),
                    // Shimmer effect
                    Positioned.fill(
                      child: Transform.translate(
                        offset: Offset(_shimmerAnimation.value * 200, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 20,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Center(
                              child: Text(
                            'SCRATCH ME!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: Colors.orange.withOpacity(0.5),
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    // Sparkles
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Text(
                        '✨',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        '✨',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Animated Spin Wheel Card Widget
class _AnimatedSpinWheelCard extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedSpinWheelCard({required this.onTap});

  @override
  State<_AnimatedSpinWheelCard> createState() => _AnimatedSpinWheelCardState();
}

class _AnimatedSpinWheelCardState extends State<_AnimatedSpinWheelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6A1B9A),
                    Color(0xFF8E24AA),
                    Color(0xFF6A1B9A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.6),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: WheelPatternPainter(),
                      ),
                    ),
                    // Shimmer effect
                    Positioned.fill(
                      child: Transform.translate(
                        offset: Offset(_shimmerAnimation.value * 200, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Rotating wheel icon
                          Transform.rotate(
                            angle: _rotationAnimation.value,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.album,
                                color: Colors.white,
                                size: 20,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'SPIN TO WIN!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: Colors.purple.withOpacity(0.5),
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Corner decorations
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Text(
                        '🎰',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        '🎲',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom painter for scratch card pattern
class ScratchPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw diagonal lines pattern
    for (double i = 0; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        paint,
      );
    }

    for (double i = 0; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(size.width - i, 0),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Golden pattern painter for unscratched cards
class GoldenPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw star pattern
    for (double x = 0; x < size.width; x += 40) {
      for (double y = 0; y < size.height; y += 40) {
        _drawStar(canvas, Offset(x, y), 8, paint);
      }
    }

    // Draw diagonal lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (double i = 0; i < size.width + size.height; i += 30) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        linePaint,
      );
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      double angle = (i * 4 * pi / 5) - pi / 2;
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Sparkles painter for reward reveal
class SparklesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // Random sparkles across the card
    final sparklePositions = [
      Offset(size.width * 0.2, size.height * 0.15),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 0.15, size.height * 0.7),
      Offset(size.width * 0.85, size.height * 0.75),
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.3, size.height * 0.9),
      Offset(size.width * 0.7, size.height * 0.5),
    ];

    for (final pos in sparklePositions) {
      _drawSparkle(canvas, pos, paint);
    }
  }

  void _drawSparkle(Canvas canvas, Offset center, Paint paint) {
    final path = Path();
    const double size = 8;

    // Create 4-pointed star
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx + size * 0.3, center.dy - size * 0.3);
    path.lineTo(center.dx + size, center.dy);
    path.lineTo(center.dx + size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx, center.dy + size);
    path.lineTo(center.dx - size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx - size, center.dy);
    path.lineTo(center.dx - size * 0.3, center.dy - size * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Circular pattern painter for spin wheel cards
class CircularPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw concentric circles
    for (double radius = 20; radius < size.width; radius += 20) {
      canvas.drawCircle(center, radius, paint);
    }

    // Draw radial lines
    for (double angle = 0; angle < 2 * pi; angle += pi / 6) {
      final x = center.dx + size.width * cos(angle);
      final y = center.dy + size.width * sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Wheel pattern painter for unspun cards
class WheelPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw wheel segments pattern
    for (int i = 0; i < 8; i++) {
      double angle = (i * 2 * pi / 8);
      final x1 = center.dx;
      final y1 = center.dy;
      final x2 = center.dx + 100 * cos(angle);
      final y2 = center.dy + 100 * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }

    // Draw decorative circles
    for (double radius = 30; radius < 80; radius += 25) {
      canvas.drawCircle(center, radius, paint);
    }

    // Draw small decorative dots
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    for (double angle = 0; angle < 2 * pi; angle += pi / 4) {
      for (double radius = 40; radius < 90; radius += 25) {
        final x = center.dx + radius * cos(angle);
        final y = center.dy + radius * sin(angle);
        canvas.drawCircle(Offset(x, y), 3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Scratch overlay pattern painter for the silver scratch surface
class ScratchOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Add metallic texture with diagonal lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Diagonal lines pattern for metallic effect
    for (double i = -size.height; i < size.width + size.height; i += 8) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        linePaint,
      );
    }

    // Add subtle dots for texture
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    for (double x = 10; x < size.width; x += 20) {
      for (double y = 10; y < size.height; y += 20) {
        canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
      }
    }

    // Add shine highlights
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Diagonal shine lines
    for (double i = 0; i < size.width + size.height; i += 60) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + 40, 40),
        shinePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Silver scratch card widget with attractive overlay
class _SilverScratchCard extends StatefulWidget {
  final ScratchCardConditionVM? scratchCondition;
  final LoyalityController controller;
  final VoidCallback onScratched;

  const _SilverScratchCard({
    required this.scratchCondition,
    required this.controller,
    required this.onScratched,
  });

  @override
  State<_SilverScratchCard> createState() => _SilverScratchCardState();
}

class _SilverScratchCardState extends State<_SilverScratchCard> {
  @override
  Widget build(BuildContext context) {
    return Scratcher(
      brushSize: 50,
      threshold: 50,
      color: Colors.grey.shade300,
      image: Image.asset('assets/images/scratch_card.png',
          height: 250, width: 250),
      onChange: (value) {
        if (value > 50) {
          widget.onScratched();
        }
      },
      accuracy: ScratchAccuracy.medium,
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                      .replaceAll('#', '0xff')))
                  .withOpacity(0.8),
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            // Background sparkles
            Positioned.fill(
              child: CustomPaint(
                painter: SparklesPainter(),
              ),
            ),
            // Reward content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 50,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Center(
                    child: Text(
                  'Congratulations! 🎉',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 10),
                if (widget.scratchCondition?.scratchCardType ==
                    'redemption') ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.scratchCondition?.scratchCardDiscountType ==
                              'percentage'
                          ? '${widget.scratchCondition?.scratchCardValue}% OFF'
                          : '₹${widget.scratchCondition?.scratchCardValue} OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.scratchCondition?.scratchCardValue}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: Offset(0, 3),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 52,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.scratchCondition?.scratchCardLabel ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Silver scratch card widget for spin wheel results
class _SilverScratchCardSpinResult extends StatefulWidget {
  final SpinWheelConditionVM winningCondition;
  final LoyalityController controller;
  final VoidCallback onScratched;

  const _SilverScratchCardSpinResult({
    required this.winningCondition,
    required this.controller,
    required this.onScratched,
  });

  @override
  State<_SilverScratchCardSpinResult> createState() =>
      _SilverScratchCardSpinResultState();
}

class _SilverScratchCardSpinResultState
    extends State<_SilverScratchCardSpinResult> {
  @override
  Widget build(BuildContext context) {
    return Scratcher(
      brushSize: 50,
      threshold: 50,
      color: Colors.grey.shade300,
      image: Image.asset('assets/images/scratch_card.png',
          height: 250, width: 250),
      onChange: (value) {
        if (value > 50) {
          widget.onScratched();
        }
      },
      accuracy: ScratchAccuracy.medium,
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                      .replaceAll('#', '0xff')))
                  .withOpacity(0.8),
              Color(int.parse(widget.controller.loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            // Background sparkles
            Positioned.fill(
              child: CustomPaint(
                painter: SparklesPainter(),
              ),
            ),
            // Reward content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 50,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Center(
                    child: Text(
                  'Congratulations! 🎉',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 10),
                if (widget.winningCondition.spinWheelType == 'redemption') ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.winningCondition.spinWheelDiscountType ==
                              'percentage'
                          ? '${widget.winningCondition.spinWheelValue}% OFF'
                          : '₹${widget.winningCondition.spinWheelValue} OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.winningCondition.spinWheelValue}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: Offset(0, 3),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 52,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.winningCondition.spinWheelLabel ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
