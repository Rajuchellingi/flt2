import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/otp_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerifciationBody extends StatelessWidget {
  final TextEditingController mobileOtpController = TextEditingController();
  final TextEditingController emailOtpController = TextEditingController();
  final otpController = Get.find<OtpVerificationController>();

  @override
  Widget build(BuildContext context) {
    final userData = otpController.userData;
    final bool smsOtp = userData['smsOtp'] ?? false;
    final bool emailOtp = userData['emailOtp'] ?? false;

    return Obx(
      () => SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (smsOtp)
              if (otpController.mobileNumberVerified.value == true)
                Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(children: [
                      Expanded(
                          flex: 2,
                          child: CircleAvatar(
                              backgroundColor: Colors.green[200],
                              child: const Icon(Icons.verified))),
                      Expanded(
                          flex: 8,
                          child: Text(
                            "Mobile Number Verified Successfully",
                            style: TextStyle(color: Colors.green),
                          ))
                    ]))
              else ...[
                const Text('Enter Mobile Number OTP',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 20.0),
                TextField(
                  controller: mobileOtpController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 10.0),
                    labelText: 'Mobile OTP',
                    labelStyle: const TextStyle(fontSize: 10.5),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        otpController.resendOTP('sms');
                      },
                    )),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {
                      otpController.handleVerify(
                          mobileOtpController.text, '', 'sms');
                      // mobileOtpController.clear();
                    },
                    child: const Text('Verify Mobile OTP',
                        style: const TextStyle(
                            fontSize: 12, color: kSecondaryColor)),
                  ),
                  // SizedBox(width: 8.0),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     otpController.resendOTP('sms');
                  //   },
                  //   child: Text('Resend OTP', style: TextStyle(fontSize: 12)),
                  // ),
                  // ],
                ),
                const SizedBox(height: 32.0),
              ],
            if (emailOtp)
              if (otpController.emailVerified.value == true)
                Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(children: [
                      Expanded(
                          flex: 2,
                          child: CircleAvatar(
                              backgroundColor: Colors.green[200],
                              child: const Icon(Icons.verified))),
                      Expanded(
                          flex: 8,
                          child: const Text(
                            "Email Id Verified Successfully",
                            style: const TextStyle(color: Colors.green),
                          ))
                    ]))
              else ...[
                const Text('Enter Email OTP',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 20.0),
                TextField(
                  controller: emailOtpController,
                  decoration: InputDecoration(
                    labelText: 'Email OTP',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 10.0),
                    labelStyle: const TextStyle(fontSize: 10.5),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        otpController.resendOTP('email');
                      },
                    )),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {
                      otpController.handleVerify(
                          '', emailOtpController.text, 'email');
                      // emailOtpController.clear();
                    },
                    child: const Text('Verify Email OTP',
                        style: const TextStyle(
                            fontSize: 12, color: kSecondaryColor)),
                  ),
                  // SizedBox(width: 8.0),
                  // OutlinedButton(
                  //   onPressed: () {
                  //     otpController.resendOTP('email');
                  //   },
                  //   child: Text('Resend OTP', style: TextStyle(fontSize: 12)),
                  // ),
                  // ],
                ),
              ],
            if (smsOtp && emailOtp) ...[
              const SizedBox(height: 32.0),
              Center(
                child: DefaultButton(
                  press: () {
                    otpController.userCreatedSubmit();
                  },
                  text: "Submit",
                  // onPressed: () {
                  // },
                  // child: Text('Submit'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
