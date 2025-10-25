// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/model/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  OrderRepo? orderRepo;
  var cartId = GetStorage().read("cartId");
  CartRepo? cartRepo;
  TriggerRepo? triggerRepo;
  final _countController = Get.find<CartCountController>();

  var productCart = [].obs;
  var userId;
  var userProfile;
  var checkoutUrl;
  var orderId;
  @override
  void onInit() {
    webViewController = new WebViewController();
    orderRepo = OrderRepo();
    cartRepo = CartRepo();
    triggerRepo = TriggerRepo();
    userId = GetStorage().read('utoken');
    var args = Get.arguments;
    checkoutUrl = args['url'];
    print("checkout url $checkoutUrl");
    if (checkoutUrl != null) openWebView();
    super.onInit();
  }

  Future openWebView() async {
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
            print('requesturl${request.url}');
            if (request.url.contains('password') ||
                request.url.contains('cart') ||
                request.url.contains('checkouts')) {
              return NavigationDecision.navigate;
            } else {
              // clearCart();
              Uri uri = Uri.parse(request.url);
              if (uri.path.isEmpty || uri.path == "/") {
                Get.offAndToNamed('/home');
              }
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(checkoutUrl));
  }

  Future clearCart() async {
    showLoading("Loading...");
    var userId = GetStorage().read('utoken');
    var cartId = GetStorage().read("cartId");
    var result = await cartRepo!.getCartProductByUser(cartId);
    if (result != null) {
      var response = cartProductFromJson(result);
      var cartIds = response.map((da) => da.sId).toList();
      await cartRepo!
          .removeCartById(cartId: cartId, type: 'product', productId: cartIds);
      await triggerRepo!.cancelTriggerNotification('abandoned-cart');
      _countController.getCartCount();
    }
    hideLoading();
    Get.offAllNamed('/home');
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
    isLoading.close();
    productCart.close();
    super.onClose();
  }
}
