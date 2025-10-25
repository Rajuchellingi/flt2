import 'package:flutter/material.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';

class CartApplyCoupenInputDesign2 extends StatelessWidget {
  final ApplyCoupenController _controller;

  CartApplyCoupenInputDesign2(
      {Key? key, required ApplyCoupenController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: brightness == Brightness.light ? Colors.white : Colors.black,
        borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(12),
            bottomLeft: const Radius.circular(12),
            topRight: const Radius.circular(20),
            bottomRight: const Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: _controller.couponTextController,
              decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimaryColor),
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        bottomLeft: const Radius.circular(20),
                      )),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        bottomLeft: const Radius.circular(20),
                      )),
                  labelText: 'Enter  promo code',
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  constraints: BoxConstraints(),
                  isDense: true,
                  hintMaxLines: 1,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  alignLabelWithHint: false,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              cursorColor: kPrimaryColor,
            ),
          )),
          GestureDetector(
              onTap: () {
                _controller.applyCoupon();
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    ),
                    color: kPrimaryColor,
                  ),
                  child: const Text(
                    "APPLY",
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}
