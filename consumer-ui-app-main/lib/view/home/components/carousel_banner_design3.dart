// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselBannerDesign3 extends StatelessWidget {
  const CarouselBannerDesign3({
    Key? key,
    required this.design,
    required this.controller,
  }) : super(key: key);

  final dynamic controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final displayLimit = design['source']['displayLimit'] ?? 2;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 30) / (displayLimit + 0.8);
    final items = design['source']['lists']
        .where((item) => item['visibility']['hide'] == false)
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (design['source']['title'] != null &&
              design['source']['title'].isNotEmpty) ...[
            Text(
              design['source']['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10)
          ],
          SizedBox(
            height: itemWidth * 0.6,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    controller.navigateByUrlType(item['link']);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: controller.changeImageUrl(
                                  item['image'], design['componentId']),
                              fit: BoxFit.contain,
                              width: 35,
                              height: 35,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['title'] ?? '',
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
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
