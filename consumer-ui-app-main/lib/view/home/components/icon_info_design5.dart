// ignore_for_file: unused_field

import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class IconInfoDesign5 extends StatelessWidget {
  const IconInfoDesign5({
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
    // print('Rendering IconInfoDesign5 with design: $design');
    var lists = design['source']['lists'];
    var style = design['style'];

    return Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: _controller.changeImageUrl(
                design['source']['image'],
                design['componentId'],
              ),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/error_image.png'),
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // 🔹 Foreground Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (design['source']['title'] != null) ...[
                  Text(
                    design['source']['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // ✅ Grid Layout for Icon + Text
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var i = 0; i < lists.length; i++)
                      if (lists[i]['visibility']['hide'] == false)
                        Container(
                          width: (SizeConfig.screenWidth / 2) - 32,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: _controller.changeImageUrl(
                                  lists[i]['image'],
                                  design['componentId'],
                                ),
                                height: 50,
                                color: Colors.white, // make icons white
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/images/error_image.png'),
                              ),
                              if (lists[i]['title'] != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  lists[i]['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                              if (lists[i]['description'] != null) ...[
                                const SizedBox(height: 5),
                                Text(
                                  lists[i]['description'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
