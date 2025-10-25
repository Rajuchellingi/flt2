// ignore_for_file: must_be_immutable

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardBannerDesign1 extends StatelessWidget {
  CardBannerDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final source = design['source'] as Map<String, dynamic>;
    final title = source['title'] as String;
    final lists = source['lists'] as List<dynamic>;
    final screenWidth = SizeConfig.screenWidth;
    final cardWidth = screenWidth / 1.2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  for (final content in lists)
                    if (content['visibility']['hide'] == false)
                      _buildCard(content, cardWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> content, double width) {
    final imageUrl = _controller.changeImageUrl(
      content['image'],
      design['componentId'],
    );
    final title = content['title'] as String?;

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => _controller.navigateByUrlType(content['link']),
        child: Card(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  memCacheWidth: (width * 3).round(),
                  fit: BoxFit.cover,
                  cacheKey: imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
