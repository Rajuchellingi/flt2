// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlWebviewController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var htmlData;
  var template = {}.obs;
  var pageTitle = ''.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    webViewController = new WebViewController();
    var args = Get.arguments;
    htmlData = args['htmlData'];
    pageTitle.value = args['pageTitle'] ?? '';
    getTemplate();
    if (htmlData != null) {
      openHtmlWebView();
    } else {
      openWebView(args['url']);
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'pages');
    isTemplateLoading.value = false;
  }

  Future openWebView(url) async {
    isLoading.value = true;
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100)
              isLoading.value = false;
            else
              isLoading.value = true;
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains('api.whatsapp.com') ||
                request.url.contains('facebook.com')) {
              await _launchURL(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future openHtmlWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadHtmlString(htmlData);
  }

  Future<bool> handleBack(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false; // don't pop the page
    } else {
      return true; // pop the page
    }
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}
