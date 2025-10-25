// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/otp_verification_controller.dart';
import 'package:black_locust/view/otp_verification/components/otp_verification_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  // static String routeName = "/sign_up";
  final _controller = Get.find<OtpVerificationController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("OTP Verification",
            style: const TextStyle(fontSize: 16, color: Colors.white)),
        bottom: PreferredSize(
            child: Obx(() => _controller.isLoading.value
                ? LinearProgressIndicator(
                    backgroundColor: (brightness == Brightness.dark &&
                            kPrimaryColor == Colors.black)
                        ? Colors.white
                        : Color.fromRGBO(kPrimaryColor.red, kPrimaryColor.green,
                            kPrimaryColor.blue, 0.2),
                    color: kPrimaryColor,
                  )
                : const SizedBox.shrink()),
            preferredSize: const Size.fromHeight(3.0)),
      ),
      body: OtpVerifciationBody(),
    );
  }
}
