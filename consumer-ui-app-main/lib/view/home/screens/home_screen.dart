// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design1a.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/home/components/home_blocks.dart';
import 'package:black_locust/view/home/components/home_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Get.find<HomeController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      if (themeController.isWelcomeImageLoading.value == true) {
        return Scaffold(
          backgroundColor: Color(0XFF4296c4),
          body: Container(
              child: Image.asset(welcomeImage,
                  // fit: BoxFit.cover,
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight)),
        );
      }
      if (_controller.isTemplateLoading.value) {
        return Scaffold(
          backgroundColor:
              brightness == Brightness.dark ? Colors.black : Colors.white,
          body: LoadingIcon(
            logoPath: themeController.logo.value,
          ),
        );
      }

      final layout = _controller.template.value['layout'];
      final header = layout?['header'];
      final bottomHeader = layout?['bottom-header'];
      final footer = layout?['footer'];

      // Optimize footer checks by computing them once
      final footerDesign = _getFooterDesign(footer);
      final actionButton = themeController.floatingActionButton(footer);
      final isTransparentHeader = header != null &&
          header.isNotEmpty &&
          header['source']['transparent'] == true;

      return SafeArea(
        top: false,
        child: Scaffold(
          key: const Key('home_screen'),
          extendBodyBehindAppBar: isTransparentHeader,
          appBar: _buildAppBar(_controller, header, bottomHeader),
          body: Stack(
            children: [
              _buildMainContent(_controller, brightness),
              if (_controller.isReward.value) _buildRewardButton(_controller),
            ],
          ),
          floatingActionButtonLocation: footerDesign == 'design3'
              ? FloatingActionButtonLocation.centerDocked
              : null,
          floatingActionButton:
              (footerDesign == 'design3' && actionButton != null)
                  ? CustomFAB(
                      key: const Key('custom_fab'),
                      template: _controller.template.value,
                      actionButton: actionButton)
                  : null,
          bottomNavigationBar: _buildFooter(footerDesign, _controller),
          drawerEnableOpenDragGesture: false,
          extendBody: footerDesign == 'design1',
        ),
      );
    });
  }

  PreferredSizeWidget? _buildAppBar(
      HomeController controller, dynamic header, bottomHeader) {
    if (!controller.isNavbar.value || header == null || header.isEmpty) {
      return null;
    }
    final isBottomHeader = bottomHeader != null && bottomHeader.isNotEmpty;
    return AppBar(
      key: const Key('home_app_bar'),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      toolbarHeight: header['style']['root']['height'] != null
          ? header['style']['root']['height'].toDouble()
          : 60,
      title: HomeHeader(controller: controller),
      backgroundColor: Colors.transparent,
      bottom: (controller.isLoading.value == false && isBottomHeader)
          ? PreferredSize(
              child: Container(
                color: themeController.headerStyle(
                  'backgroundColor',
                  bottomHeader?['style']['root']['backgroundColor'],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CommonHeader(header: bottomHeader),
              ),
              preferredSize: Size.fromHeight(
                  bottomHeader!['style']['root']['height'] != null
                      ? bottomHeader['style']['root']['height'].toDouble()
                      : 50),
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: SizedBox.shrink(),
            ),
      forceMaterialTransparency: true,
    );
  }

  Widget _buildMainContent(HomeController controller, Brightness brightness) {
    return Container(
      child: controller.isLoading.value
          ? LoadingIcon(
              logoPath: themeController.logo.value,
            )
          : SizedBox.expand(
              child: HomeBlocks(controller: controller),
            ),
    );
  }

  Widget _buildRewardButton(HomeController controller) {
    return Positioned(
      bottom: 5,
      left: 10,
      child: FloatingActionButton(
        key: const Key('reward_button'),
        onPressed: controller.openNectorReward,
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.card_giftcard_outlined,
          size: 30,
          color: kSecondaryColor,
        ),
        shape: const CircleBorder(),
      ),
    );
  }

  Widget? _buildFooter(String? footerDesign, HomeController controller) {
    if (footerDesign == null) return null;

    final template = controller.template.value;
    switch (footerDesign) {
      case 'design2':
        return FooterDesign2(template: template);
      case 'design4':
        return FooterDesign4(template: template);
      case 'design3':
        return FooterDesign3(template: template);
      case 'design5':
        return FooterDesign5(template: template);
      case 'design1':
        return FooterDesign1(template: template);
      case 'design1a':
        return FooterDesign1a(template: template);
      default:
        return null;
    }
  }

  String? _getFooterDesign(dynamic footer) {
    if (footer == null) return null;

    final instanceId = footer['instanceId'];
    final isVisible = footer['visibility']['hide'] == false;

    return isVisible ? instanceId : null;
  }
}
