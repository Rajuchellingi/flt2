// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselBannerDesign1 extends StatelessWidget {
  const CarouselBannerDesign1({
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
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
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
                      : kPrimaryTextColor),
            ),
            const SizedBox(height: 10)
          ],
          SizedBox(
            height: itemWidth + 30, // Account for text height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (design['source']['lists'] as List?)?.length ?? 0,
              itemBuilder: (context, index) {
                final content = design['source']['lists'][index];
                if (content['visibility']['hide'] == true) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => _controller.navigateByUrlType(content['link']),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: itemWidth,
                          width: itemWidth,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: content['image'] != null
                                ? DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      _controller.changeImageUrl(
                                        content['image'],
                                        design['componentId'],
                                      ),
                                    ),
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: itemWidth,
                          child: Text(
                            content['title'] ?? '',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
