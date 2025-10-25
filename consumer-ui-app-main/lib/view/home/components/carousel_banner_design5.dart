// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBannerDesign5 extends StatelessWidget {
  const CarouselBannerDesign5({
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: content['image'] != null
                  ? CachedNetworkImage(
                      imageUrl: _controller.changeImageUrl(
                        content['image'],
                        design['componentId'],
                      ),
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    )
                  : Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  if (content['title'] != null)
                    Text(
                      content['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                  const SizedBox(height: 5),

                  if (content['description'] != null)
                    Text(
                      content['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(width: 10),
                  // Subtitle/Description
                  if (content['subTitle'] != null)
                    Text(
                      content['subTitle'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(width: 10),
                  if (content['buttonName'] != null)
                    GestureDetector(
                      onTap: () =>
                          _controller.navigateByUrlType(content['link']),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            content['buttonName'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(
                              width: 4), // spacing between text & icon
                          const Icon(
                            Icons.arrow_right_alt,
                            size: 12,
                            color: Colors.black,
                          ),
                        ],
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
