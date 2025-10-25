import 'package:black_locust/controller/order_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderDetailBody extends StatelessWidget {
  const OrderDetailBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final OrderDetailController _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(
              controller: _controller.webViewController,
            ),
    );
  }
}
