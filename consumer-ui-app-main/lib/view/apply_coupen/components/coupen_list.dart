// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';
import 'package:flutter/material.dart';

class CoupenList extends StatelessWidget {
  const CoupenList({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final ApplyCoupenController _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: const Text("Available Coupons",
                  style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          const Divider(),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      // padding: EdgeInsets.all(15),
                      child: Column(children: [
            for (var coupen in _controller.coupenCodes.value) ...[
              Container(
                  width: SizeConfig.screenWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coupen.couponCode,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          if (coupen.heading != null) ...[
                            const SizedBox(height: 5),
                            Text(coupen.heading,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                          if (coupen.description != null) ...[
                            const SizedBox(height: 5),
                            Text(coupen.description,
                                style: TextStyle(fontSize: 13)),
                          ],
                          if (coupen.termsAndCondition != null) ...[
                            const SizedBox(height: 5),
                            Text(coupen.termsAndCondition,
                                style: TextStyle(fontSize: 12)),
                          ]
                        ],
                      )),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          _controller.applyDiscountCoupen(coupen);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Apply',
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                    ],
                  ))
            ]
          ]))))
        ]));
  }
}
