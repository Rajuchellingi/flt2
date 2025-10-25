// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailSizeChartDesign2 extends StatefulWidget {
  const ProductDetailSizeChartDesign2({required this.product});
  final product;

  @override
  _SizeChartPageState createState() => _SizeChartPageState();
}

class _SizeChartPageState extends State<ProductDetailSizeChartDesign2> {
  final SizeChartController _controller = Get.find<SizeChartController>();

  bool _isBottomSheetOpen = false;

  void _showSizeChartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // return DraggableScrollableSheet(
        //   initialChildSize: 0.7,
        //   maxChildSize: 0.9,
        //   minChildSize: 0.5,
        //   builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: SizeConfig.screenHeight * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
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
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
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
                          child: const CircularProgressIndicator(
                              color: kPrimaryColor),
                        )
                      : WebViewWidget(
                          controller: _controller.webViewController,
                        ),
                ),
              ),
            ],
          ),
          // );
          // },
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
      child: InkWell(
          child: const Text(
            'Size Chart',
            style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            if (_isBottomSheetOpen) {
              Navigator.pop(context);
              setState(() {
                _isBottomSheetOpen = false;
              });
            } else {
              _controller.showSizeChartOpen(widget.product);
              _showSizeChartBottomSheet(context);
            }
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
