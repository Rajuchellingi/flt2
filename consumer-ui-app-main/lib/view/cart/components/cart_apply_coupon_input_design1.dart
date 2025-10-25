import 'package:flutter/material.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';

class CartApplyCoupenInputDesign1 extends StatelessWidget {
  final ApplyCoupenController _controller;

  CartApplyCoupenInputDesign1(
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
              child: Stack(children: [
            Container(
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: _controller.couponTextController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white),
                        borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            bottomLeft: const Radius.circular(12),
                            topRight: const Radius.circular(20),
                            bottomRight: const Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: brightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                            width: 1.0),
                        borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            bottomLeft: const Radius.circular(12),
                            topRight: const Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    labelText: 'Enter your promo code',
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(),
                    isDense: true,
                    hintMaxLines: 1,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    alignLabelWithHint: false,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                cursorColor: kPrimaryColor,
              ),
            ),
            Positioned(
                right: 0,
                bottom: 1,
                child: GestureDetector(
                    onTap: () {
                      _controller.applyCoupon();
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.black),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ))))
          ])),
        ],
      ),
    );
  }
}
