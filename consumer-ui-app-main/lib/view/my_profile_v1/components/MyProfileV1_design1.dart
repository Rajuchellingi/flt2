// ignore_for_file: deprecated_member_use

import 'package:black_locust/view/my_profile_v1/components/updatePassword_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileV1Design2 extends StatelessWidget {
  final controller;

  const MyProfileV1Design2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: Colors.grey[100],
      child: SafeArea(
        child: SingleChildScrollView(
          // ✅ fixes infinite height error
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greeting
                Text(
                  "Hi, ${controller.firstNameController.text}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Welcome To Your Account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                /// Contact Details Section
                const Text(
                  "Contact Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                _buildDetailRow(
                    "First Name", controller.firstNameController.text),
                _buildDetailRow(
                    "Mobile Number", controller.mobileController.text),
                _buildDetailRow("Email Id", controller.emailController.text),

                const SizedBox(height: 16),

                /// Password Section
                _buildPasswordRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPasswordRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Text("Change Password",
        //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                padding: const EdgeInsets.all(16),
                child: MyUpdatePasswordPopup(),
              ),
              isScrollControlled: true,
              enterBottomSheetDuration: const Duration(milliseconds: 200),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          },
          child: const Text("Change Password",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
