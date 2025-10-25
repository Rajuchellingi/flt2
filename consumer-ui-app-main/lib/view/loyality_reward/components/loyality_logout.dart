// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityLogout extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner Section
              if (loyality.rewardMobileBannerLink != null &&
                  loyality.rewardMobileBannerLink!.isNotEmpty)
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(loyality.rewardMobileBannerLink!),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (loyality.logoutTitle != null &&
                            loyality.logoutTitle!.isNotEmpty) ...[
                          Text(
                            loyality.logoutTitle.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (loyality.logoutDescription != null &&
                            loyality.logoutDescription!.isNotEmpty) ...[
                          Text(
                            loyality.logoutDescription.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        // Action Buttons
                        if (loyality.callToActionSignupText != null &&
                            loyality.callToActionSignupText!.isNotEmpty) ...[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Color(int.parse(_controller
                                  .loyality.value.primaryColor!
                                  .replaceAll('#', '0xff'))),
                              minimumSize: Size(double.infinity, 45),
                            ),
                            onPressed: () {
                              _controller.changeRoute('/register');
                            },
                            child: Text(
                              loyality.callToActionSignupText.toString(),
                              style: TextStyle(
                                color: Color(int.parse(_controller
                                    .loyality.value.textColor!
                                    .replaceAll('#', '0xff'))),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (loyality.callToActionLoginText != null &&
                            loyality.callToActionLoginText!.isNotEmpty) ...[
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(color: Colors.white, width: 2),
                              minimumSize: Size(double.infinity, 45),
                            ),
                            onPressed: () {
                              _controller.changeRoute('/login');
                            },
                            child: Text(
                              loyality.callToActionLoginText.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // How It Works Section
              if (loyality.explainerTitle != null &&
                  loyality.explainerTitle!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(int.parse(_controller.loyality.value.primaryColor!
                                .replaceAll('#', '0xff')))
                            .withOpacity(0.05),
                        Color(int.parse(_controller.loyality.value.primaryColor!
                                .replaceAll('#', '0xff')))
                            .withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(int.parse(_controller
                              .loyality.value.primaryColor!
                              .replaceAll('#', '0xff')))
                          .withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(int.parse(_controller
                                  .loyality.value.primaryColor!
                                  .replaceAll('#', '0xff'))),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.lightbulb_outline,
                              color: Color(int.parse(_controller
                                  .loyality.value.textColor!
                                  .replaceAll('#', '0xff'))),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              loyality.explainerTitle.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (loyality.explainerDescription != null &&
                          loyality.explainerDescription!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          loyality.explainerDescription.toString(),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),

                      // Step Cards
                      _buildStepCard(
                        number: '1',
                        icon: Icons.person_add_outlined,
                        title: loyality.sectionOneTitle ?? '',
                        description: loyality.sectionOneDescription ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildStepCard(
                        number: '2',
                        icon: Icons.shopping_bag_outlined,
                        title: loyality.sectionTwoTitle ?? '',
                        description: loyality.sectionTwoDescription ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildStepCard(
                        number: '3',
                        icon: Icons.card_giftcard_outlined,
                        title: loyality.sectionThreeTitle ?? '',
                        description: loyality.sectionThreeDescription ?? '',
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Ways To Earn Section
              if (_getWaysToEarn().isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ways To Earn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Complete these actions to earn reward coins',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._getWaysToEarn().map((earningRule) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildEarningCard(earningRule),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Ways To Redeem Section
              if (_getWaysToRedeem().isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ways To Redeem',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Here\'s how you can spend your coins for discounts',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._getWaysToRedeem().map((redemption) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildRedeemCard(redemption),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Footer Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.gift,
                          size: 40,
                          color: Color(int.parse(_controller
                              .loyality.value.primaryColor!
                              .replaceAll('#', '0xff'))),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Start Your Rewards Journey Today!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign up now to start earning coins and unlock exclusive rewards with every purchase.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  // Build Step Card Widget
  Widget _buildStepCard({
    required String number,
    required IconData icon,
    required String title,
    required String description,
  }) {
    if (title.isEmpty) return SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(int.parse(_controller.loyality.value.primaryColor!
                          .replaceAll('#', '0xff'))),
                      Color(int.parse(_controller.loyality.value.primaryColor!
                              .replaceAll('#', '0xff')))
                          .withOpacity(0.7),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(int.parse(_controller
                              .loyality.value.primaryColor!
                              .replaceAll('#', '0xff')))
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Color(int.parse(_controller.loyality.value.textColor!
                      .replaceAll('#', '0xff'))),
                  size: 28,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(int.parse(_controller
                          .loyality.value.primaryColor!
                          .replaceAll('#', '0xff'))),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: TextStyle(
                        color: Color(int.parse(_controller
                            .loyality.value.primaryColor!
                            .replaceAll('#', '0xff'))),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build Earning Card Widget
  Widget _buildEarningCard(dynamic earningRule) {
    final description = earningRule.rewardDescription != null &&
            earningRule.rewardDescription!.isNotEmpty
        ? earningRule.rewardDescription!
        : '${earningRule.rewardTitle ?? ''} reward ${earningRule.rewardCoin ?? 0} Coins!';

    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          earningRule.rewardTitle ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[600],
        ),
        onTap: () {
          _showEarningRuleDialog(earningRule);
        },
      ),
    );
  }

  // Build Redeem Card Widget
  Widget _buildRedeemCard(dynamic redemption) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Color(int.parse(_controller.loyality.value.primaryColor!
                    .replaceAll('#', '0xff')))
                .withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.gift,
            color: Color(int.parse(_controller.loyality.value.primaryColor!
                .replaceAll('#', '0xff'))),
          ),
        ),
        title: Text(
          redemption.title ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (redemption.description != null &&
                redemption.description!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                redemption.description!,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              'Starts at ${redemption.requiredCoin} Points',
              style: TextStyle(
                color: Color(int.parse(_controller.loyality.value.primaryColor!
                    .replaceAll('#', '0xff'))),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[600],
        ),
        onTap: () {
          _showRedemptionDialog(redemption);
        },
      ),
    );
  }

  // Get Ways To Earn list
  List<dynamic> _getWaysToEarn() {
    var earningRules = _controller.loyality.value.earningRuleData;
    if (earningRules == null || earningRules.isEmpty) return [];

    return earningRules
        .where((rule) =>
            rule.status == true &&
            ['order', 'signup', 'birthday', 'social-share']
                .contains(rule.type ?? ''))
        .toList();
  }

  // Get Ways To Redeem list
  List<dynamic> _getWaysToRedeem() {
    var redemptionRules = _controller.loyality.value.redemptionRuleData;
    if (redemptionRules == null || redemptionRules.isEmpty) return [];

    return redemptionRules.where((rule) => rule.isPublished == true).toList();
  }

  // Show Earning Rule Dialog
  void _showEarningRuleDialog(dynamic earningRule) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                earningRule.rewardTitle ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Win Points for every spend and redeem them for exclusive rewards.',
                style: TextStyle(
                  // color: Colors.grey[700],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(int.parse(_controller
                      .loyality.value.primaryColor!
                      .replaceAll('#', '0xff'))),
                  minimumSize: Size(double.infinity, 45),
                ),
                onPressed: () {
                  Get.back();
                  _controller.changeRoute('/register');
                },
                child: Text(
                  'Sign Up and Get Free Points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(int.parse(_controller.loyality.value.textColor!
                        .replaceAll('#', '0xff'))),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      _controller.changeRoute('/login');
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(int.parse(_controller
                            .loyality.value.primaryColor!
                            .replaceAll('#', '0xff'))),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Redemption Dialog
  void _showRedemptionDialog(dynamic redemption) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                redemption.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Redeem your points for exclusive discounts and rewards.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(int.parse(_controller
                      .loyality.value.primaryColor!
                      .replaceAll('#', '0xff'))),
                  minimumSize: Size(double.infinity, 45),
                ),
                onPressed: () {
                  Get.back();
                  _controller.changeRoute('/register');
                },
                child: Text(
                  'Sign Up and Get Free Points',
                  style: TextStyle(
                    color: Color(int.parse(_controller.loyality.value.textColor!
                        .replaceAll('#', '0xff'))),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      _controller.changeRoute('/login');
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(int.parse(_controller
                            .loyality.value.primaryColor!
                            .replaceAll('#', '0xff'))),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
