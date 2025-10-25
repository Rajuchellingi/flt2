import 'package:black_locust/controller/site_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationObserver extends NavigatorObserver {
  final siteSettingController = Get.find<SiteSettingController>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    siteSettingController.trackPageView(route.settings.name!);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    siteSettingController.trackPageView(newRoute!.settings.name!);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }
}
