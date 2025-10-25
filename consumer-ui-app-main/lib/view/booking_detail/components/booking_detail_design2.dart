// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/view/booking_detail/components/booking_information_design2.dart';
import 'package:black_locust/view/booking_detail/components/booking_products_design2.dart';
import 'package:black_locust/view/booking_detail/components/booking_summary_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailDesign2 extends StatelessWidget {
  final BookingDetailController _controller;

  const BookingDetailDesign2({
    Key? key,
    required BookingDetailController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _controller.bookingDetail != null
            ? RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: _controller.refreshPage,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookingInformationDesign2(controller: _controller),
                        const SizedBox(height: 10),
                        BookingProductsDesign2(
                          controller: _controller,
                          products: _controller.bookingDetail.value.products,
                        ),
                        const SizedBox(height: 10),
                        BookingDetailSummaryDesign2(
                          price: _controller.bookingDetail.value.price!,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: const Text("No booking details available."),
              ));
  }
}
