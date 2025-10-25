import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImageBannerDesign1 extends StatelessWidget {
  ProductImageBannerDesign1({Key? key, required this.design}) : super(key: key);

  final design;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              design['source']['image'],
              fit: BoxFit.cover,
            )));
  }
}
