// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/theme_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class ProductDetailQuantityUpdateDesign2 extends StatelessWidget {
  ProductDetailQuantityUpdateDesign2(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              const Text(
                "Quantity  ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF3F4F6))),
                  icon: const Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _controller.quantityMinus();
                  }),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _controller.quantity.value.toString(),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF3F4F6))),
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _controller.quantityAdd();
                  })
            ],
          ),
          const SizedBox(height: 5),
        ]));
  }
}
