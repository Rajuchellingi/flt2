import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_detail_controller.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class BookingDetailBottomButton extends StatelessWidget {
  const BookingDetailBottomButton({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final BookingDetailController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
              height: getProportionateScreenHeight(42),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.payment,
                      size: 18, color: kSecondaryColor),
                  label: const Text(
                    'Make Payment',
                    style:
                        const TextStyle(color: kSecondaryColor, fontSize: 16),
                  ),
                  onPressed: () => {_controller.makePayment()}),
            )),
          ],
        ),
      ),
    );
  }
}
