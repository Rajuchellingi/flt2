// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class IconInfoDesign1 extends StatelessWidget {
  const IconInfoDesign1({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            design['source']['title'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
      padding: const EdgeInsets.all(5),
      child: Container(
        width: (SizeConfig.screenWidth / 2.8) - 5,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: const Color.fromARGB(255, 198, 197, 197),
        //     width: 1,
        //   ),
        // ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: isCountGreaterThanThree
              ? _HorizontalLayout(
                  content: content,
                  controller: controller,
                  componentId: componentId,
                )
              : _VerticalLayout(
                  content: content,
                  controller: controller,
                  componentId: componentId,
                ),
        ),
      ),
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({
    Key? key,
    required this.content,
    required this.controller,
    required this.componentId,
  }) : super(key: key);

  final Map<String, dynamic> content;
  final dynamic controller;
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final imageUrl = controller.changeImageUrl(content['image'], componentId);
    final title = content['title'];
    final description = content['description'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: _CachedImage(
            imageUrl: imageUrl,
            size: SizeConfig.screenWidth / 8,
          ),
        ),
        if (title?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (description?.isNotEmpty ?? false) ...[
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout({
    Key? key,
    required this.content,
    required this.controller,
    required this.componentId,
  }) : super(key: key);

  final Map<String, dynamic> content;
  final dynamic controller;
  final String componentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CachedImage(
          imageUrl: controller.changeImageUrl(content['image'], componentId),
          size: SizeConfig.screenWidth / 2.5,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            content['title'] ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            content['description'] ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
      fit: BoxFit.cover,
      height: size,
      width: size,
      memCacheWidth: (size * MediaQuery.of(context).devicePixelRatio).toInt(),
      memCacheHeight: (size * MediaQuery.of(context).devicePixelRatio).toInt(),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/error_image.png',
        height: size,
        width: size,
      ),
    );
  }
}
