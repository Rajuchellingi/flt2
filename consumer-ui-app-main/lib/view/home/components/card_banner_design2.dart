// ignore_for_file: unused_field

import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class CardBannerDesign2 extends StatelessWidget {
  const CardBannerDesign2({
    Key? key,
    required this.design,
    required this.themeController,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;
  final ThemeController themeController;
  final design;

  @override
  Widget build(BuildContext context) {
    var lists = design['source']['lists'];
    var style = design['style'];

    return Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: themeController.defaultStyle(
          'backgroundColor', style['backgroundColor']),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          if (design['source']['title'] != null) ...[
            Text(
              design['source']['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],

          // Grid layout
          Column(
            children: [
              for (var row = 0; row < lists.length; row += 2)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var col = 0; col < 2; col++)
                        if (row + col < lists.length &&
                            lists[row + col]['visibility']['hide'] == false)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: _controller.changeImageUrl(
                                        lists[row + col]['image'],
                                        design['componentId']),
                                    height: 40,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/error_image.png'),
                                  ),
                                  const SizedBox(height: 10),
                                  if (lists[row + col]['title'] != null)
                                    Text(
                                      lists[row + col]['title'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  const SizedBox(height: 6),
                                  if (lists[row + col]['description'] != null)
                                    Text(
                                      lists[row + col]['description'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        else
                          Expanded(
                              child: Container()), // Empty for uneven last row
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
