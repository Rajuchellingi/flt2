import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/loyality_coupon_wallet_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityCouponWalletBody extends StatelessWidget {
  LoyalityCouponWalletBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final LoyalityCouponWalletController _controller;
  final loyalityController = Get.find<LoyalityController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = loyalityController.loyality.value;
      var coupons = _controller.getCoupons(loyality.couponDetails!,
          _controller.searchQuery.value, _controller.status.value);
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Coupon Wallet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(
              "Track all the offers you've unlocked through loyalty rewards.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            _CouponInsights(),
            SizedBox(height: 12),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            //   decoration: BoxDecoration(
            //     color: Color(0xFFFFF8E1),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Total Value Saved:',
            //           style: TextStyle(fontWeight: FontWeight.w500)),
            //       Text('₹750',
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            //     ],
            //   ),
            // ),
            SizedBox(height: 16),
            _CouponFilterChips(controller: _controller),
            SizedBox(height: 12),
            TextField(
              onChanged: (value) {
                _controller.searchQuery.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Search by coupon title or code',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
            ),
            SizedBox(height: 16),
            if (coupons.isNotEmpty) ...[
              for (var coupon in coupons) ...[
                _CouponCard(
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
                SizedBox(height: 12),
              ]
            ] else ...[
              Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: const Text("Coupons not found",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17))))
            ],
          ],
        ),
      );
    });
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
}

class _CouponInsights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        _InsightItem(
          label: 'Total',
          value: '7',
          valueColor: Colors.black,
        ),
        _InsightItem(label: 'Active', value: '3', valueColor: Colors.green),
        _InsightItem(label: 'Used', value: '2', valueColor: Colors.blue),
        _InsightItem(label: 'Expired', value: '2', valueColor: Colors.grey),
      ],
    );
  }
}

class _InsightItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _InsightItem(
      {required this.label, required this.value, required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: valueColor.withAlpha(10),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Text(value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: valueColor)),
                Text(label,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            )));
  }
}

class _CouponFilterChips extends StatelessWidget {
  final LoyalityCouponWalletController controller;

  const _CouponFilterChips({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Chip(
            label: 'All',
            controller: controller,
            value: 'all',
            selected: controller.status.value == 'all'),
        SizedBox(width: 8),
        _Chip(
            label: 'Active',
            selected: controller.status.value == 'active',
            controller: controller,
            value: 'active'),
        SizedBox(width: 8),
        _Chip(
            label: 'Used',
            selected: controller.status.value == 'used',
            controller: controller,
            value: 'used'),
        SizedBox(width: 8),
        _Chip(
            label: 'Expired',
            selected: controller.status.value == 'inactive',
            controller: controller,
            value: 'inactive'),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final LoyalityCouponWalletController controller;

  const _Chip(
      {required this.label,
      required this.controller,
      required this.value,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.status.value = value;
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selected ? Colors.green[50] : Color(0xFFF5F5F5)),
            child: Text(label,
                style: TextStyle(
                    color: selected ? Colors.green : Colors.black,
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal))));
  }
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
