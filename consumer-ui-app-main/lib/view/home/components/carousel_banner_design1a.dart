// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBannerDesign1a extends StatelessWidget {
  const CarouselBannerDesign1a({
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
    final source = design['source'] as Map<String, dynamic>;
    final lists = source['lists'] as List<dynamic>;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (SizeConfig.screenWidth - 30) / (displayLimit + 0.8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          _buildHeader(source),
          const SizedBox(height: 5),
          _buildCarousel(context, lists, itemWidth, screenWidth),
          // const SizedBox(height: 2),
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.lightGreen[50],
              child: Text(
                source['buttonName'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context, List<dynamic> lists,
      double itemWidth, double screenWidth) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final content in lists)
                if (content['visibility']['hide'] == false)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildCarouselItem(context, content, itemWidth),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, Map<String, dynamic> content, double itemWidth) {
    final brightness = Theme.of(context).brightness;

    return GestureDetector(
      onTap: () => _controller.navigateByUrlType(content['link']),
      child: Column(
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
                color:
                    brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
