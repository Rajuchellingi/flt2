// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/welcome_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WelcomeScreenDesign1 extends StatelessWidget {
  const WelcomeScreenDesign1(
      {Key? key, required controller, required this.themeController})
      : _controller = controller,
        super(key: key);

  final WelcomeScreenController _controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final template = _controller.template.value;
    return SingleChildScrollView(
        child: Column(children: [
      for (var i = 0; i < template['layout']['blocks'].length; i++) ...[
        Obx(() {
          var block = template['layout']['blocks'][i];
          var source = block['source'];
          if (i == _controller.currentIndex.value) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: themeController.defaultStyle(
                  'backgroundColor', block['style']['backgroundColor']),
              child: Column(children: [
                if (source['logo'] != null && source['logo'].isNotEmpty) ...[
                  Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageUrl: source['logo'])),
                ],
                if (source['show-skip'] == true) ...[
                  Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            _controller.goToHomePage();
                          },
                          child: const Text("Skip",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16))))
                ],
                if (source['image'] != null && source['image'].isNotEmpty) ...[
                  const SizedBox(height: 15),
                  Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImageWidget(
                              image: source['image']))),
                ],
                if (source['title'] != null && source['title'].isNotEmpty) ...[
                  const SizedBox(height: 30),
                  Text(source['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeController.defaultStyle(
                              'color', block['style']['color']),
                          fontWeight: FontWeight.bold,
                          fontSize: 25))
                ],
                if (source['description'] != null &&
                    source['description'].isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(source['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 16))
                ],
                if (source['buttonName'] != null &&
                    source['buttonName'].isNotEmpty) ...[
                  const SizedBox(height: 30),
                  GestureDetector(
                      onTap: () {
                        _controller.openNextScreen(i);
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(source['buttonName'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold))))
                ],
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(template['layout']['blocks'].length,
                      (index) {
                    if (index == _controller.currentIndex.value) {
                      return Container(
                        width: 20,
                        height: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                      );
                    } else {
                      return Container(
                        height: 5,
                        width: 10,
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                      );
                    }
                  }),
                ),
              ]),
            );
          } else {
            return SizedBox.shrink();
          }
        })
      ]
    ]));
  }
}
