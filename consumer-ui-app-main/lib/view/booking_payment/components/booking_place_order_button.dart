import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_payment_controller.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class BookingPlaceOrderButton extends StatelessWidget {
  const BookingPlaceOrderButton({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final BookingPaymentController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 2))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    child: Text(
                        '${_controller.bookingDetail.value.price!.currencySymbol.toString() + _controller.bookingDetail.value.price!.totalPrice!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))),
            Expanded(
                child: SizedBox(
              height: getProportionateScreenHeight(45),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: const Icon(Icons.credit_card,
                      size: 18, color: kSecondaryColor),
                  label: const Text(
                    'Make Payment',
                    style:
                        const TextStyle(color: kSecondaryColor, fontSize: 14),
                  ),
                  onPressed: () {
                    _controller.placeOrder();
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
