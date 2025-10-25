// ignore_for_file: deprecated_member_use, unused_field

import 'package:black_locust/view/home/components/banner_video_player_design2.dart';
import 'package:flutter/material.dart';

class CarouselVideoBannerDesign1 extends StatelessWidget {
  const CarouselVideoBannerDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final displayLimit = design['source']['displayLimit'] ?? 2;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 30) / (displayLimit + 0.3);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            design['source']['title'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          if (design['source']['description'] != null) ...[
            Text(
              design['source']['description'] ?? '',
              style: const TextStyle(color: Colors.grey),
            )
          ],
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var content in design['source']['lists'] ?? []) ...[
                  if (content['visibility']['hide'] == false) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: itemWidth,
                              child: BannerVideoPlayerDesgign2(
                                videoLink: content['video'],
                                autoPlay: 'disabled',
                                audio: 'mute',
                              )),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: itemWidth,
                            child: Text(
                              content['title'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
