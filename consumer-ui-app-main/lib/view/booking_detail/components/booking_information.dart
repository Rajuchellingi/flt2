import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/booking_detail/components/booking_cancel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingInformation extends StatelessWidget {
  const BookingInformation({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final BookingDetailController _controller;
  @override
  Widget build(BuildContext context) {
    var validStatus = ['created', 'confirmed'];
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              // margin: EdgeInsets.fromLTRB),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey.shade300, width: 2),
              //     borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Row(children: [
                  const Expanded(
                      child: const Text("Booking Date",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black))),
                  Expanded(
                      child: Text(
                          CommonHelper.convetToDate(
                              _controller.bookingDetail.value.creationDate),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)))
                ]),
                const SizedBox(height: 5),
                if (_controller.bookingDetail.value.bookingNo != null) ...[
                  Row(children: [
                    const Expanded(
                        child: const Text("Booking No",
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black))),
                    Expanded(
                        child: Text(
                            _controller.bookingDetail.value.bookingNo
                                .toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)))
                  ]),
                  const SizedBox(height: 5),
                ],
                Row(children: [
                  const Expanded(
                      child: const Text("Status",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black))),
                  Expanded(
                      child: Text(
                          toBeginningOfSentenceCase(_controller
                                  .bookingDetail.value.status
                                  .toString())
                              .toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  const Expanded(
                      child: const Text("Total",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black))),
                  Expanded(
                      child: Text(
                          _controller.bookingDetail.value.price!.currencySymbol
                                  .toString() +
                              _controller.bookingDetail.value.price!.totalPrice!
                                  .toStringAsFixed(2),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)))
                ]),
              ])),
          if (validStatus.contains(_controller.bookingDetail.value.status)) ...[
            const Divider(),
            Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                child: GestureDetector(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: const Text("Cancel Booking")),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 14,
                        )
                      ]),
                  onTap: () {
                    Get.dialog(BookingCancel(controller: _controller));
                  },
                ))
          ],
        ]));
  }
}
