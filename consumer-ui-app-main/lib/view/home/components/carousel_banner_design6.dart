// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBannerDesign6 extends StatelessWidget {
  const CarouselBannerDesign6({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final displayLimit = design['source']['displayLimit'] ?? 1.6;
    final source = design['source'] as Map<String, dynamic>;
    final lists = source['lists'] as List<dynamic>;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (SizeConfig.screenWidth - 40) / displayLimit;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          if (design['source']['title'] != null &&
              design['source']['title'].isNotEmpty) ...[
            Text(
              source['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
          ],
          // Carousel
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final content in lists)
                  if (content['visibility']['hide'] == false)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: _buildCollectionCard(content, itemWidth),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          if (source['buttonName'] != null)
            GestureDetector(
              onTap: () => _controller.navigateByUrlType(source['link']),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  source['buttonName'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard(Map<String, dynamic> content, double itemWidth) {
    return GestureDetector(
      onTap: () => _controller.navigateByUrlType(content['link']),
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colors.grey.shade800, // dark card background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badge overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: content['image'] != null
                      ? CachedNetworkImage(
                          imageUrl: _controller.changeImageUrl(
                            content['image'],
                            design['componentId'],
                          ),
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                        )
                      : Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey.shade600,
                        ),
                ),

                // Badge (like "Only 5 Left")
                if (content['badge'] != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        content['badge'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Card Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (content['title'] != null)
                    Text(
                      content['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),

                  const SizedBox(height: 5),

                  if (content['description'] != null)
                    Text(
                      content['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  if (content['subTitle'] != null)
                    Text(
                      content['subTitle'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),

                  const SizedBox(height: 10),

                  // Reserve Button (Orange text inside card)
                  if (content['buttonName'] != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () =>
                            _controller.navigateByUrlType(content['link']),
                        child: Text(
                          content['buttonName'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
