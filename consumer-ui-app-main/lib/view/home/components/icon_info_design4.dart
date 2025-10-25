// ignore_for_file: unused_field

import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class IconInfoDesign4 extends StatelessWidget {
  const IconInfoDesign4({
    Key? key,
    required this.design,
    required this.themeController,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final ThemeController themeController;
  final design;

  @override
  Widget build(BuildContext context) {
    var lists = design['source']['lists'];
    var style = design['style'];

    return Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: themeController.defaultStyle(
          'backgroundColor', style['backgroundColor']),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          if (design['title'] != null) ...[
            Text(
              design['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],

          // Grid layout
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var i = 0; i < lists.length; i++)
                if (lists[i]['visibility']['hide'] == false)
                  Container(
                    width: (SizeConfig.screenWidth / 2) - 24,
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
                        // Icon
                        CachedNetworkImage(
                          imageUrl: _controller.changeImageUrl(
                              lists[i]['image'], design['componentId']),
                          height: 40,
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/error_image.png'),
                        ),
                        const SizedBox(height: 10),

                        // Title
                        if (lists[i]['title'] != null)
                          Text(
                            lists[i]['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),

                        const SizedBox(height: 6),

                        // Description
                        if (lists[i]['description'] != null)
                          Text(
                            lists[i]['description'],
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
            ],
          ),
        ],
      ),
    );
  }
}
