// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBannerDesign7 extends StatelessWidget {
  const CarouselBannerDesign7({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final displayLimit = design['source']['displayLimit'] ?? 4;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 30) / (displayLimit + 0.2);
    final brightness = Theme.of(context).brightness;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (design['source']['title'] != null &&
              design['source']['title'].isNotEmpty) ...[
            Text(
              design['source']['title'] ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
            const SizedBox(height: 10)
          ],
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                for (var content in design['source']['lists']) ...[
                  if (content['visibility']['hide'] == false) ...[
                    Container(
                        width: itemWidth,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 204, 204, 204))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: GestureDetector(
                            onTap: () =>
                                _controller.navigateByUrlType(content['link']),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (content['image'] != null &&
                                    content['image'].isNotEmpty) ...[
                                  CachedNetworkImageWidget(
                                      image: content['image']),
                                ],
                                if (content['title'] != null &&
                                    content['title'].trim().isNotEmpty) ...[
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    child: Text(
                                      content['title'] ?? '',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                        ))
                  ] else ...[
                    const SizedBox.shrink()
                  ]
                ]
              ]))
        ],
      ),
    );
  }
}
