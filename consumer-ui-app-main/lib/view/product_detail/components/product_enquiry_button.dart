// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class ProductEnquiryDesign1 extends StatelessWidget {
  const ProductEnquiryDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final _controller;
  final design;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(42),
              child: ElevatedButton.icon(
                onPressed: () {
                  _controller.openCheckoutPage(_controller);
                },
                icon: const Icon(
                  Icons.help_outline,
                  color: Colors.black,
                  size: 18,
                ),
                label: Text(
                  (design['source'] != null &&
                          design['source']['buttonName'] != null)
                      ? design['source']['buttonName']
                      : "Enquire Now",
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor.withOpacity(0.5),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
