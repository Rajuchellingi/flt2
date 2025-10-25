import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplySameQuantitySheet extends StatelessWidget {
  final int selectedProducts;
  final VoidCallback? onCancel;
  final MultiBookingController _controller;

  const ApplySameQuantitySheet({
    Key? key,
    required this.selectedProducts,
    this.onCancel,
    required controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Quantity for All Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.inventory_2, color: Colors.red, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '$selectedProducts Products Selected',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Enter Number of Packs (Applies to All Products)',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Enter Number of Packs',
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
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total Quantity: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '${_controller.totalQuantity}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Total Amount: ',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text:
                              '₹${_controller.totalAmount.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // OutlinedButton(
                  //   onPressed: onCancel ?? () => Navigator.pop(context),
                  //   child: const Text('Cancel'),
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _controller.onAddToCartSameQuantity();
                    },
                    child: const Text(
                      'Add To Cart ',
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _controller.onSubmit();
                    },
                    child: const Text(
                      'Submit Booking form',
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
