// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardBannerDesign3 extends StatelessWidget {
  CardBannerDesign3({
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (title != null && title.isNotEmpty) ...[
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
            const SizedBox(height: 10)
          ],
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                spacing: 15,
                children: [
                  for (final content in lists)
                    if (content['visibility']['hide'] == false)
                      _buildCard(content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> content) {
    final imageUrl = _controller.changeImageUrl(
      content['image'],
      design['componentId'],
    );
    final title = content['title'] as String?;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 222, 222, 222),
          borderRadius: BorderRadius.circular(30)),
      child: GestureDetector(
        onTap: () => _controller.navigateByUrlType(content['link']),
        child: Column(
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  cacheKey: imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
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
    );
  }
}
