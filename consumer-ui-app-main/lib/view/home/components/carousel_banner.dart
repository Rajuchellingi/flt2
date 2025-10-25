// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/view/home/components/carousel_banner_design1.dart';
import 'package:black_locust/view/home/components/carousel_banner_design2.dart';
import 'package:black_locust/view/home/components/carousel_banner_design3.dart';
import 'package:black_locust/view/home/components/carousel_banner_design4.dart';
import 'package:black_locust/view/home/components/carousel_banner_design5.dart';
import 'package:black_locust/view/home/components/carousel_banner_design6.dart';
import 'package:black_locust/view/home/components/carousel_banner_design7.dart';
import 'package:black_locust/view/home/components/carousel_banner_design8.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

/// A widget that displays a carousel banner with different design variants.
///
/// This widget is responsible for rendering either CarouselBannerDesign1 or
/// CarouselBannerDesign2 based on the instanceId from the theme controller.
class CarouselBanner extends StatelessWidget {
  /// Creates a carousel banner widget.
  ///
  /// The [controller] parameter is required and must not be null.
  /// The [design] parameter is required and must not be null.
  CarouselBanner({
    Key? key,
    required dynamic controller,
    required this.design,
  })  : _controller = controller,
        super(key: key);

  /// The design configuration for the banner
  final Map<String, dynamic> design;

  /// The home controller instance
  final dynamic _controller;

  /// The theme controller instance
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    // Memoize the instanceId calculation
    final String instanceId = design['instanceId'] == 'design1'
        ? _themeController.instanceId(design['componentId'])
        : design['instanceId'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (instanceId == 'design1')
          CarouselBannerDesign1(controller: _controller, design: design)
        else if (instanceId == 'design2')
          CarouselBannerDesign2(controller: _controller, design: design)
        else if (instanceId == 'design3')
          CarouselBannerDesign3(controller: _controller, design: design)
        else if (instanceId == 'design4')
          CarouselBannerDesign4(controller: _controller, design: design)
        else if (instanceId == 'design5')
          CarouselBannerDesign5(controller: _controller, design: design)
        else if (instanceId == 'design6')
          CarouselBannerDesign6(controller: _controller, design: design)
        else if (instanceId == 'design7')
          CarouselBannerDesign7(controller: _controller, design: design)
        else if (instanceId == 'design8')
          CarouselBannerDesign8(controller: _controller, design: design)
        else
          CarouselBannerDesign1(controller: _controller, design: design)
      ],
    );
  }
}
