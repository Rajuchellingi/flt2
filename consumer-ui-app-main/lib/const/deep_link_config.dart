// ignore_for_file: unused_local_variable, deprecated_member_use, unnecessary_null_comparison

import 'package:black_locust/model/common_model.dart';
import 'package:get/get.dart';
import 'package:app_links/app_links.dart';

class DeepLinkConfig {
  late final AppLinks _appLinks;

  void init() {
    _appLinks = AppLinks();
    listenDeepLink();
  }

  void listenDeepLink() async {
    // Check if app was launched via deep link
    Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) checkLinkAndNavigate(initialLink);

    // Listen for deep link changes while app is running
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        checkLinkAndNavigate(uri);
      }
    }, onError: (err) {
      // Handle errors if needed
    });
  }

  void checkLinkAndNavigate(Uri uri) {
    if (uri.pathSegments.contains('products')) {
      var argument = CommonModel(sId: uri.pathSegments.last);
      Get.toNamed('/productDetail', arguments: argument);
    }
  }
}
