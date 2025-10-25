import 'package:black_locust/common_component/color_text_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingHistoryDetail extends StatelessWidget {
  const BookingHistoryDetail({
    Key? key,
    required controller,
    required this.bookingItem,
  })  : _controller = controller,
        super(key: key);

  final BookingHistoryController _controller;
  final MyBookingDataVM bookingItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.navigateToBookingDetails(bookingItem);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              BookingItemRow(
                  itemLable: 'Booking No :',
                  itemValue: bookingItem.bookingNo != null
                      ? bookingItem.bookingNo
                      : ''),
              kDefaultHeight(kDefaultPadding / 2),
              BookingItemRow(
                  itemLable: 'Booking Date :',
                  itemValue: CommonHelper.convetToDate(
                      bookingItem.creationDate.toString())),
              kDefaultHeight(kDefaultPadding / 2),
              BookingItemRow(
                  itemLable: 'Status :', itemValue: bookingItem.status),
              kDefaultHeight(kDefaultPadding / 2),
              BookingItemRow(
                  itemLable: 'Total :',
                  itemValue: bookingItem.currencySymbol.toString() +
                      bookingItem.totalPrice.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class BookingItemRow extends StatelessWidget {
  const BookingItemRow(
      {Key? key,
      required this.itemLable,
      required this.itemValue,
      String? this.specialLabel})
      : super(key: key);

  final itemLable;
  final itemValue;
  final specialLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemLable,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        if (specialLabel != null)
          ColorTextOrButton(
            colorCode: Color(0XFF00AF5D),
            itemValue: specialLabel,
            onPress: () {},
          ),
        itemLable == 'Status :'
            ? ColorTextOrButton(
                colorCode: Color(0XFF00AF5D),
                itemValue: itemValue,
                onPress: () {},
              )
            : Text(itemValue),
      ],
    );
  }
}
