// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class OrderDetailController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var allowReturn = false.obs;
  var returnUrl;
  final themeController = Get.find<ThemeController>();
  final pluginController = Get.find<PluginsController>();
  var orderDetail = MyOrderDetailVM(
      sId: null,
      billingAddress: null,
      shippingAddress: null,
      user: null,
      price: null,
      status: null,
      statusUrl: null,
      orderNo: null,
      orderNumber: null,
      creationDate: null,
      products: []).obs;

  @override
  void onInit() {
    webViewController = new WebViewController();
    orderDetail.value = Get.arguments;
    // detailPageUrl = args['url'];
    getTemplate();
    if (orderDetail.value.status == 'FULFILLED') checkAllowReturn();
    // if (detailPageUrl != null) openWebView();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhere((value) => value['id'] == 'order-detail', orElse: () => {});
    if (template.value != null &&
        template.value['layout'] != null &&
        template.value['layout']['blocks'] != null) {
      var blocks = template.value['layout']['blocks'];
      var detailComponent = blocks.firstWhere(
          (value) => value['componentId'] == 'order-detail-component',
          orElse: () => {});
      if (detailComponent != null &&
          detailComponent['instanceId'] == 'design1') {
        if (orderDetail.value.statusUrl != null)
          openWebView(orderDetail.value.statusUrl);
      }
    }
    isTemplateLoading.value = false;
  }

  Future<void> checkReturnUrlIsValid(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 403) {
        allowReturn.value = true;
      } else {
        allowReturn.value = false;
      }
    } catch (e) {
      print("Error: Unable to reach the link. $e");
    }
  }

  Future checkAllowReturn() async {
    var primeReturn = pluginController.getPluginValue('prime-return');
    if (primeReturn != null) {
      isLoading.value = true;
      var shopDomain = GetStorage().read('shop');
      var channelId = primeReturn.code;
      returnUrl =
          '$returnPrimeUrl?order_number=${orderDetail.value.orderNumber}&email=${orderDetail.value.user!.emailId!}&store=$shopDomain&channel_id=$channelId';
      await checkReturnUrlIsValid(returnUrl);
      isLoading.value = false;
    }
  }

  Future openWebView(detailPageUrl) async {
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
          onNavigationRequest: (NavigationRequest request) {
            if (!request.url.contains('orders')) {
              Get.offAllNamed('/home');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(detailPageUrl));
  }

  Future openReturnPage() async {
    await Get.toNamed('/return', arguments: {'url': returnUrl});
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
        // padding: EdgeInsets.all(kDefaultPadding / 2),
        // margin: EdgeInsets.all(0)
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
