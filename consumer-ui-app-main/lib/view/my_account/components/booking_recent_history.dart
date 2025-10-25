import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingRecentHistory extends StatelessWidget {
  const BookingRecentHistory({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final AccountController _controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Booking History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Recent Bookings',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            /// Order Details Box
            if (_controller.recentOrder.value.booking != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Order ID + Status
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booking ID: ${_controller.recentOrder.value.booking!.bookingNo}',
                          style: TextStyle(fontSize: 13),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            getShortStatusLabel(_controller
                                    .recentOrder.value.booking!.status
                                    .toString())
                                .toString(),
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// Product Info
                    Text(
                      _controller.recentOrder.value.booking!.productNames!
                          .join(', '),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Booked: ${CommonHelper.converToDateByType(_controller.recentOrder.value.booking!.creationDate)}',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 12),

                    /// Amount and Coins Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount\n${_controller.recentOrder.value.booking!.currencySymbol}${_controller.recentOrder.value.booking!.totalPrice}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   'Coins Earned\n500 Coins',
                        //   style: TextStyle(
                        //     color: Colors.green,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        //   textAlign: TextAlign.right,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// View All Orders Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Implement navigation
                    Get.toNamed('/bookingHistory');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor.withAlpha(30),
                    foregroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('View All Bookings'),
                ),
              )
            ] else ...[
              Container(
                  alignment: Alignment.center,
                  child:
                      Text("Bookings Not Found", textAlign: TextAlign.center))
            ]
          ],
        ),
      ),
    );
  }

  String getShortStatusLabel(String status) {
    switch (status) {
      case 'created':
        return 'Created';
      case 'confirmed':
        return 'Confirmed';
      case 'cancelled':
        return 'Cancelled';
      case 'approved':
        return 'Approved';
      case 'paid-waiting-for-approval':
        return 'Awaiting Approval';
      case 'forwarded-to-admin':
        return 'Sent to Admin';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
