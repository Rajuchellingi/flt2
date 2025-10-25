// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBannerDesign4 extends StatelessWidget {
  const CarouselBannerDesign4({
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
    final source = design['source'] as Map<String, dynamic>;
    final lists = source['lists'] as List<dynamic>;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (SizeConfig.screenWidth - 30) / (displayLimit + 0.3);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          if (design['source']['title'] != null &&
              design['source']['title'].isNotEmpty) ...[
            _buildHeader(source),
            const SizedBox(height: 5)
          ],
          _buildCarousel(lists, itemWidth, screenWidth),
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> source) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          source['title'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        if (source['buttonName'] != null)
          GestureDetector(
            onTap: () => _controller.navigateByUrlType(source['link']),
            child: Text(
              source['buttonName'] as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCarousel(
      List<dynamic> lists, double itemWidth, double screenWidth) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
      constraints: BoxConstraints(
        maxWidth: screenWidth - 20,
      ),
      child: RawScrollbar(
        thumbVisibility: false,
        thumbColor: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final content in lists)
                if (content['visibility']['hide'] == false)
                  _buildCarouselItem(content, itemWidth)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(Map<String, dynamic> content, double itemWidth) {
    return GestureDetector(
      onTap: () => _controller.navigateByUrlType(content['link']),
      child: Stack(
        children: [
          Container(
            width: itemWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: content['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: _controller.changeImageUrl(
                        content['image'],
                        design['componentId'],
                      ),
                      fit: BoxFit.cover,
                    ))
                : null,
          ),
          if (content['title'] != null)
            Positioned(
              bottom: 10,
              child: Container(
                width: itemWidth,
                child: Text(
                  content['title'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
