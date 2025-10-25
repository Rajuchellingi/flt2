// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
// import 'package:black_locust/controller/verifcation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPageController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var dataName = ''.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var errorMessage = ''.obs;

  var productCart = [].obs;
  var userId;
  var userProfile;
  var checkoutUrl;
  var orderId;

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
    getTemplate();
  }

  void _initializeWebView() {
    try {
      final shop = GetStorage().read('shop');
      final data = Get.arguments;
      final link = data['link'].contains('https')
          ? data['link']
          : 'https://$shop/pages/${data["link"]}';
      dataName.value = data['title'];

      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              isLoading.value = progress < 100;
            },
            onPageStarted: (String url) {
              isLoading.value = true;
            },
            onPageFinished: (String url) {
              isLoading.value = false;
            },
            onWebResourceError: (WebResourceError error) {
              errorMessage.value = 'Error loading page: ${error.description}';
              isLoading.value = false;
            },
            onNavigationRequest: (NavigationRequest request) {
              // if (request.url.contains('pages') ||
              //     request.url.contains('password')) {
              //   return NavigationDecision.navigate;
              // }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(link));
    } catch (e) {
      errorMessage.value = 'Failed to initialize WebView: $e';
    }
  }

  getTemplate() async {
    try {
      isTemplateLoading.value = true;
      List<dynamic> allTemplates = themeController.allTemplate.value;
      template.value =
          allTemplates.firstWhereOrNull((value) => value['id'] == 'pages');
    } catch (e) {
      errorMessage.value = 'Failed to load template: $e';
    } finally {
      isTemplateLoading.value = false;
    }
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar("", msg,
        snackPosition: position,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        // duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        padding: EdgeInsets.all(kDefaultPadding / 2),
        margin: EdgeInsets.all(0));
  }

  @override
  void onClose() {
    webViewController.clearCache();
    webViewController.clearLocalStorage();
    super.onClose();
  }

  Future<bool> canGoBack() async {
    try {
      return await webViewController.canGoBack();
    } catch (e) {
      return false;
    }
  }

  Future<void> goBack() async {
    try {
      if (await canGoBack()) {
        await webViewController.goBack();
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
    }
  }
}
