// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/welcome_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WelcomeScreenDesign2 extends StatelessWidget {
  const WelcomeScreenDesign2(
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
              // padding: const EdgeInsets.all(20),
              color: themeController.defaultStyle(
                  'backgroundColor', block['style']['backgroundColor']),
              child: Stack(children: [
                Column(children: [
                  if (source['logo'] != null && source['logo'].isNotEmpty) ...[
                    Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageUrl: source['logo'])),
                  ],
                  if (source['image'] != null &&
                      source['image'].isNotEmpty) ...[
                    Container(
                        alignment: Alignment.center,
                        child:
                            CachedNetworkImageWidget(image: source['image'])),
                  ],
                  if (source['title'] != null &&
                      source['title'].isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(source['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeController.defaultStyle(
                                    'color', block['style']['color']),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)))
                  ],
                  if (source['description'] != null &&
                      source['description'].isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(source['description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14)))
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
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(5)),
                        );
                      }
                    }),
                  ),
                  if (source['buttonName'] != null &&
                      source['buttonName'].isNotEmpty) ...[
                    const SizedBox(height: 20),
                    if (source['buttonType'] == 'elevated-button') ...[
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: kPrimaryColor),
                              onPressed: () {
                                _controller.openNextScreen(i);
                              },
                              child: Text(
                                source['buttonName'],
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.bold),
                              )))
                    ] else ...[
                      GestureDetector(
                          onTap: () {
                            _controller.openNextScreen(i);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: Text(source['buttonName'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))))
                    ],
                    if ((source['loginText'] != null &&
                            source['loginText'].isNotEmpty) ||
                        (source['loginButton'] != null &&
                            source['loginButton'].isNotEmpty)) ...[
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if ((source['loginText'] != null &&
                                source['loginText'].isNotEmpty)) ...[
                              Text(source['loginText']),
                              const SizedBox(width: 5)
                            ],
                            if ((source['loginButton'] != null &&
                                source['loginButton'].isNotEmpty)) ...[
                              GestureDetector(
                                onTap: () {
                                  _controller.openLoginPage();
                                },
                                child: Text(source['loginButton'],
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        decoration: TextDecoration.underline)),
                              ),
                            ]
                          ]),
                      const SizedBox(height: 10),
                    ],
                  ],
                ]),
                if (source['show-skip'] == true) ...[
                  Positioned(
                      right: 15,
                      top: 10,
                      child: GestureDetector(
                          onTap: () {
                            _controller.goToHomePage();
                          },
                          child: const Text("Skip",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16))))
                ],
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
