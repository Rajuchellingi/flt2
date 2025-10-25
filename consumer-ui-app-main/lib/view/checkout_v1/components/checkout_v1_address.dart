// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/checkout_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutV1Address extends StatelessWidget {
  CheckoutV1Address({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CheckoutV1Controller _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return SingleChildScrollView(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All addresses (${_controller.address.value.length})",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  _controller.openAddAddress();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 18),
                      const SizedBox(width: 5),
                      const Text(
                        "Add address",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          for (var element in _controller.address.value)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        _controller.changeShippingAddress(element.sId);
                      },
                      child: Row(
                        children: [
                          Transform.translate(
                              offset:
                                  Offset(-5, 0), // Adjust the offset as needed
                              child: Radio<String?>(
                                value: _controller.selectedAddress.value.sId,
                                groupValue: element.sId, // Selected address
                                activeColor: kPrimaryColor,
                                onChanged: (String? value) {
                                  _controller
                                      .changeShippingAddress(element.sId);
                                },
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (element.billingAddress == true)
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: const Text(
                                        'Billing address',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      )),
                                Text(
                                  element.contactName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(child: Text(element.address)),
                                if (element.landmark != null &&
                                    element.landmark.isNotEmpty)
                                  Container(child: Text(element.landmark)),
                                Container(child: Text(element.city)),
                                Container(
                                    child: Text(
                                        '${element.state}, ${element.pinCode}, ${element.country}')),
                                Container(
                                    child: Text(
                                        'Phone number: ${element.mobileNumber}')),
                              ],
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  if (_controller.selectedAddress.value.sId == element.sId) ...[
                    const SizedBox(height: 7),
                    ElevatedButton(
                      onPressed: () {
                        _controller.openSummaryPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        'Deliver to this address',
                        style: const TextStyle(color: kSecondaryColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _controller.openEditAddress(element);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(
                        'Edit address',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                  if (element.billingAddress != true) ...[
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _controller.changeBillingAddress(element.sId);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text(
                        'Set as billing address',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          if (footer != null &&
              footer.isNotEmpty &&
              themeController.bottomBarType.value == 'design1' &&
              footer['componentId'] == 'footer-navigation')
            const SizedBox(height: 80),
        ],
      ));
    });
  }
}
