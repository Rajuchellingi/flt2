import 'package:flutter/material.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/apply_coupen_controller.dart';

class ApplyCoupenInput extends StatelessWidget {
  final ApplyCoupenController _controller;

  const ApplyCoupenInput({Key? key, required ApplyCoupenController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller.couponTextController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter a coupon code',
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              cursorColor: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              _controller.applyCoupon();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Apply',
              style: const TextStyle(color: kSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
