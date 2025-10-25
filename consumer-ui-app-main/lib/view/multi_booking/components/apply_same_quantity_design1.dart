// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplySameQuantityDesign1 extends StatelessWidget {
  final MultiBookingController _controller;

  ApplySameQuantityDesign1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final productSettingController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Set Quantity Selected Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_basket,
                        color: kSecondaryColor, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '${_controller.products.value.length} Products Selected',
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Quantity will be applied equally to all selected products',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              const Text(
                'Enter Quantity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 10.0),
                ),
                onChanged: (e) {
                  _controller.onChangeQuantity(e);
                },
              ),
              const SizedBox(height: 18),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFF9F9F9),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Items Selected: ',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '${_controller.products.value.length}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Quantity:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '${_controller.totalQuantity} pieces',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Estimated Total Amount:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '₹${_controller.totalAmount.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(7)),
                      child: Text('Cancel',
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)))),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    _controller.onSubmit();
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(7)),
                      child: Text('Submit Booking form',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)))),
            ],
          ),
        )));
  }

  getSetQuantity(setQuantity) {
    var quantity = '';
    if (setQuantity != null && setQuantity.isNotEmpty)
      for (var element in setQuantity) {
        quantity += '${element.attributeFieldValue} = ${element.moq}; ';
      }
    return quantity;
  }
}
