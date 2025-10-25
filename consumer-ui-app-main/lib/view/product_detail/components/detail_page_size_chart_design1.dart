// ignore_for_file: deprecated_member_use

import 'package:black_locust/controller/sizeChart_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPageSizeChartDesign1 extends StatefulWidget {
  const DetailPageSizeChartDesign1(
      {required this.product, required this.shop, required this.code});
  final product;
  final shop;
  final code;

  @override
  _SizeChartPageState createState() => _SizeChartPageState();
}

class _SizeChartPageState extends State<DetailPageSizeChartDesign1> {
  final SizeChartDetailPaageController _controller =
      Get.find<SizeChartDetailPaageController>();

  bool _isBottomSheetOpen = false;

  void _showSizeChartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Size Chart',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _controller.isLoading.value
                          ? const Center(
                              child: const CircularProgressIndicator(),
                            )
                          : WebViewWidget(
                              controller: _controller.webViewController,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        _isBottomSheetOpen = false;
      });
    });
    setState(() {
      _isBottomSheetOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
          child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        label: const Text(
          'View Size Chart',
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (_isBottomSheetOpen) {
            Navigator.pop(context);
            setState(() {
              _isBottomSheetOpen = false;
            });
          } else {
            _controller.showSizeChartOpen(
                widget.product, widget.shop, widget.code);
            _showSizeChartBottomSheet(context);
          }
        },
        icon: Icon(
          _isBottomSheetOpen
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
      )),
    );
  }
}
