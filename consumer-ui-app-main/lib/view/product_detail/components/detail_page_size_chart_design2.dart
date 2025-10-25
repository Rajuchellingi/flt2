// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:black_locust/controller/sizeChart_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPageSizeChartDesign2 extends StatefulWidget {
  const DetailPageSizeChartDesign2({
    required this.product,
    required this.shop,
    required this.code,
  });

  final dynamic product;
  final String shop;
  final String code;

  @override
  _SizeChartPageState createState() => _SizeChartPageState();
}

class _SizeChartPageState extends State<DetailPageSizeChartDesign2> {
  final SizeChartDetailPaageController _controller =
      Get.find<SizeChartDetailPaageController>();

  @override
  void initState() {
    super.initState();
    _controller.showSizeChartOpen(widget.product, widget.shop, widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size Chart',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // WebView Content
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: const CircularProgressIndicator());
              } else if (_controller.webViewController != null) {
                return WebViewWidget(controller: _controller.webViewController);
              } else {
                return const Center(
                    child: const Text("Failed to load Size Chart"));
              }
            }),
          ),
        ],
      ),
    );
  }
}
