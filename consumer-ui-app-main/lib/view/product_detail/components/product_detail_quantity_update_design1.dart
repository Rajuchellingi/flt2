import 'package:black_locust/controller/theme_controller.dart';
import 'package:get/get.dart';

import '../../../const/size_config.dart';
import 'package:flutter/material.dart';

class ProductDetailQuantityUpdateDesign1 extends StatelessWidget {
  ProductDetailQuantityUpdateDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return Obx(() => Column(children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              const Text(
                "Quantity : ",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: const Icon(
                    Icons.remove,
                    size: 18,
                  ),
                  onPressed: () {
                    _controller.quantityMinus();
                  }),
              Container(
                height: getProportionateScreenWidth(30),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                    color: brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[300]!)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    _controller.quantity.value.toString(),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                  ),
                  onPressed: () {
                    _controller.quantityAdd();
                  })
            ],
          ),
          const Divider(),
        ]));
  }
}
