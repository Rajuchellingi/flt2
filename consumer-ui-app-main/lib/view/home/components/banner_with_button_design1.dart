// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class BannerWithButtonDesign1 extends StatelessWidget {
  const BannerWithButtonDesign1({
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
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item['image'] != null) ...[
                  ClipRRect(
                      child: CachedNetworkImageWidget(image: item['image']),
                      borderRadius: BorderRadius.circular(15))
                ],

                // Title
                if (item['title'] != null) ...[
                  const SizedBox(height: 15),
                  Text(
                    item['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (item['description'] != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    item['description'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
                // Button
                if (item['buttonName'] != null) ...[
                  const SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor, // orange
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
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
                      ))
                ],
                if (item['secondButtonName'] != null) ...[
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: kPrimaryColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          _controller.navigateByUrlType(item['secondLink']);
                        },
                        child: Text(
                          item['secondButtonName'],
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ))
                ],
              ],
            ),
          ),
        ),
      ]
    ]);
  }
}
