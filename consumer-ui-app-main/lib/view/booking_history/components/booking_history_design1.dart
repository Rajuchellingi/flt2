// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_controller.dart';
import 'package:black_locust/view/booking_history/components/booking_history_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryDesign1 extends StatelessWidget {
  const BookingHistoryDesign1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingHistoryController _controller;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SafeArea(
      child: Obx(
        () => _controller.bookingList.length > 0
            ? RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: _controller.refreshPage,
                child: Stack(
                  children: [
                    Obx(() => ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller.scrollController,
                        itemCount: _controller.bookingList.length,
                        itemBuilder: (context, index) {
                          return BookingHistoryDetail(
                              controller: _controller,
                              bookingItem: _controller.bookingList[index]);
                        })),
                    Obx(() => _controller.loading.value
                        ? Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 80.0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor:
                                    (brightness == Brightness.dark &&
                                            kPrimaryColor == Colors.black)
                                        ? Colors.white
                                        : Color.fromRGBO(
                                            kPrimaryColor.red,
                                            kPrimaryColor.green,
                                            kPrimaryColor.blue,
                                            0.2),
                                color: kPrimaryColor,
                              )),
                            ),
                          )
                        : Container())
                  ],
                ),
              )
            : const Center(
                child: const Text('No bookings Found.'),
              ),
      ),
    );
  }
}
