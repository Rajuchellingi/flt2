// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class BannerWithBackgroundDesign1 extends StatelessWidget {
  const BannerWithBackgroundDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    var banners = design['source']['lists']
        .where((content) => content['visibility']['hide'] == false)
        .toList();
    if (banners.isEmpty == true) return SizedBox.shrink();
    return Column(children: [
      for (var item in banners) ...[
        Container(
          color:
              Color(int.parse(item['backgroundColor'].replaceAll('#', '0xff'))),
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (item['image'] != null) ...[
                    Image.network(
                      item['image'],
                      width: SizeConfig.screenWidth * 0.6,
                    ),
                    const SizedBox(height: 20)
                  ],

                  // Title
                  if (item['title'] != null) ...[
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (item['description'] != null) ...[
                    // Subtitle
                    Text(
                      item['description'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // Button
                  if (item['buttonName'] != null) ...[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor, // orange
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        _controller.navigateByUrlType(item['link']);
                      },
                      child: Text(
                        item['buttonName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        )
      ]
    ]);
  }
}
