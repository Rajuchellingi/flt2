// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/home/components/media_tab_scroller_design1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MediaTabScroller extends StatelessWidget {
  MediaTabScroller({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final dynamic _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final String instanceId = design['instanceId'] == 'design1'
        ? themeController.instanceId(design['componentId'])
        : design['instanceId'];
    var hideHeader = design['source']['hideHeader'] ?? false;
    return VisibilityDetector(
        key: Key(design['componentId']),
        onVisibilityChanged: (value) {
          final visibleFraction = value.visibleFraction;
          if (visibleFraction > 0.85) {
            // _controller.changeScroll(true);
            _controller.updateByReachTop(true);
            if (hideHeader == true) _controller.changeNavbarVisibility(false);
          } else {
            _controller.updateByReachTop(false);
            if (hideHeader == true) _controller.changeNavbarVisibility(true);
          }
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (instanceId == 'design1')
            MediaTabScrollerDesign1(controller: _controller, design: design)
        ]));
  }

  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();

    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }
}
