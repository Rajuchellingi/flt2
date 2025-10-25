// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailSizeChartDesign1 extends StatefulWidget {
  const ProductDetailSizeChartDesign1({required this.product});
  final product;

  @override
  _SizeChartPageState createState() => _SizeChartPageState();
}

class _SizeChartPageState extends State<ProductDetailSizeChartDesign1> {
  final SizeChartController _controller = Get.find<SizeChartController>();

  bool _isBottomSheetOpen = false;

  void _showSizeChartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
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
            borderRadius: BorderRadius.only(
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
                          child: const CircularProgressIndicator(
                              color: kPrimaryColor),
                        )
                      : WebViewWidget(
                          controller: _controller.webViewController,
                        ),
                ),
              )
            ],
          ),
        );
        // },
        // );
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
    final brightness = Theme.of(context).brightness;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: InkWell(
          child: Row(spacing: 5, children: [
            SvgPicture.asset(
              "assets/icons/measure.svg",
              height: 19,
              width: 19,
              color:
                  brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
            Text(
              'Size Chart',
              style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryColor,
                  decoration: TextDecoration.underline),
            ),
          ]),
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
