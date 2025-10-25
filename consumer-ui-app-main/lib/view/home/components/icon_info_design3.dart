// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class IconInfoDesign3 extends StatelessWidget {
  const IconInfoDesign3({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final bool isCountGreaterThanThree = design['source']['lists'].length > 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        // Title (Why Choose Us)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            design['source']['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              // color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),

        // List of items
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final content in design['source']['lists'])
                if (content['visibility']['hide'] == false)
                  _IconInfoCard(
                    key: ValueKey(content['id'] ?? content['title']),
                    content: content,
                    controller: _controller,
                    componentId: design['componentId'],
                    isCountGreaterThanThree: isCountGreaterThanThree,
                  ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _IconInfoCard extends StatelessWidget {
  const _IconInfoCard({
    Key? key,
    required this.content,
    required this.controller,
    required this.componentId,
    required this.isCountGreaterThanThree,
  }) : super(key: key);

  final Map<String, dynamic> content;
  final dynamic controller;
  final String componentId;
  final bool isCountGreaterThanThree;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: SizeConfig.screenWidth / 3.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle Icon
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xffFFF5DB),
              child: _CachedImage(
                imageUrl:
                    controller.changeImageUrl(content['image'], componentId),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              content['title'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                // color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // Description
            Text(
              content['description'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                // color: Colors.black54,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _CachedImage extends StatelessWidget {
  const _CachedImage({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      height: size,
      width: size,
      memCacheWidth: (size * MediaQuery.of(context).devicePixelRatio).toInt(),
      memCacheHeight: (size * MediaQuery.of(context).devicePixelRatio).toInt(),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error_outline,
        size: size,
        color: Colors.grey,
      ),
    );
  }
}
