import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SizeChartDetailPaageController extends GetxController
    with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
  }

  Future<void> showSizeChartOpen(product, shopValue, codeValue) async {
    // var collectionId = product.collections[0].id.split('/').last;
    print("product size chart page----->>>>>>> ${product.toJson()}");
    // var tags = product.tags.join(',');
    // var productType = product.productType;
    // var shop = GetStorage().read("shop");
    var productId = product.sId;
    var code = codeValue;
    var shop = shopValue;
    print('productId: $productId, code: $code, shop: $shop');
    // var detailPageUrl =
    //     "https://d3jfapbxgzc4a3.cloudfront.net/size-chart?$productId&$code&$shop";
    var detailPageUrl =
        "https://d3jfapbxgzc4a3.cloudfront.net/size-chart?productId=$productId&code=$code&shop=$shop";

    openWebView(detailPageUrl);
  }

  Future<void> openWebView(String url) async {
    print("url--------------->>>>> ${url}");
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
          },
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
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
      ..loadRequest(Uri.parse(url));
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar("", msg,
        snackPosition: position,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }
}
