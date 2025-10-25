// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/loyality_widget/components/loyality_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityWidgetIcon extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isLoading.value == true ||
          _controller.loyality.value.primaryColor == null ||
          _controller.loyality.value.showMobile == false)
        return SizedBox.shrink();

      return Stack(
        children: [
          Positioned(
            bottom: getOffset('bottom'),
            top: getOffset('top'),
            right: getOffset('right'),
            left: getOffset('left'),
            child: FloatingActionButton(
              key: const Key('reward_button'),
              onPressed: () {
                _controller.openOrCloseWidget();
              },
              backgroundColor: Color(int.parse(_controller
                  .loyality.value.primaryColor!
                  .replaceAll('#', '0xff'))),
              child: _controller.isDialogOpen.value
                  ? Icon(
                      Icons.close,
                      size: 30,
                      color: Color(int.parse(_controller
                          .loyality.value.textColor!
                          .replaceAll('#', '0xff'))),
                    )
                  : (_controller.loyality.value.customImageUrl != null &&
                          _controller.loyality.value.customImageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl: _controller.loyality.value.customImageUrl!)
                      : Icon(
                          Icons.card_giftcard_outlined,
                          size: 30,
                          color: Color(int.parse(_controller
                              .loyality.value.textColor!
                              .replaceAll('#', '0xff'))),
                        )),
              shape: const CircleBorder(),
            ),
          ),
          if (_controller.isDialogOpen.value)
            Positioned(
                // Adjust these offsets to position the dialog next to the button
                bottom: getOffset('bottom') != null
                    ? getOffset('bottom')! + 70
                    : null,
                top: getOffset('top') != null ? getOffset('top')! + 70 : null,
                right: getOffset('right'),
                left: getOffset('left'),
                child: Material(
                    color: Colors.transparent,
                    child: Container(
                        width: SizeConfig.screenWidth - 40,
                        height: SizeConfig.screenHeight * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: LoyalityRoute()))),
        ],
      );
    });
  }

  getOffset(position) {
    var widgetPosition = _controller.loyality.value.mobileWidgetPosition;
    var offSet = _controller.loyality.value.mobileOffset;
    double defaultvalue = 20.0;
    if (widgetPosition == 'top-left') {
      if (position == 'top')
        return getProportionateScreenHeight(offSet!.toDouble());
      else if (position == 'left')
        return defaultvalue;
      else if (position == 'right')
        return null;
      else if (position == 'bottom') return null;
    } else if (widgetPosition == 'top-right') {
      if (position == 'top')
        return getProportionateScreenHeight(offSet!.toDouble());
      else if (position == 'right')
        return defaultvalue;
      else if (position == 'left')
        return null;
      else if (position == 'bottom') return null;
    } else if (widgetPosition == 'bottom-right') {
      if (position == 'bottom')
        return getProportionateScreenHeight(offSet!.toDouble());
      else if (position == 'right')
        return defaultvalue;
      else if (position == 'left')
        return null;
      else if (position == 'top') return null;
    } else if (widgetPosition == 'bottom-left') {
      if (position == 'bottom')
        return getProportionateScreenHeight(offSet!.toDouble());
      else if (position == 'left')
        return defaultvalue;
      else if (position == 'right')
        return null;
      else if (position == 'top') return null;
    }
  }
}
