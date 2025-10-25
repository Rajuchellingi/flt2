// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BannerWithTextDesign1 extends StatelessWidget {
  const BannerWithTextDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildBannerItems(context),
    );
  }

  List<Widget> _buildBannerItems(BuildContext context) {
    final List<dynamic> lists = design['source']['lists'] as List<dynamic>;
    return lists.where((content) {
      final Map<String, dynamic> visibility =
          content['visibility'] as Map<String, dynamic>;
      return visibility['hide'] == false;
    }).map((content) {
      if (content['type'] == 'image') {
        return Expanded(
          child: _BannerItem(
            content: content,
            controller: _controller,
            componentId: design['componentId'],
          ),
        );
      }
      return const SizedBox.shrink();
    }).toList();
  }
}

class _BannerItem extends StatelessWidget {
  const _BannerItem({
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
      children: [
        _BannerImage(
          content: content,
          controller: controller,
          componentId: componentId,
        ),
        if (content['description'] != null)
          _BannerDescription(description: content['description']),
      ],
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, bottom: 4),
        child: GestureDetector(
          onTap: () => controller.navigateByUrlType(content['link']),
          child: CachedNetworkImage(
            imageUrl: controller.changeImageUrl(content['image'], componentId),
            height: 170,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
            memCacheWidth: (MediaQuery.of(context).size.width * 2).toInt(),
            memCacheHeight: 340,
            errorWidget: (context, url, error) => const Image(
              image: AssetImage('assets/images/error_image.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerDescription extends StatelessWidget {
  const _BannerDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Html(
            data: description,
            style: {
              "body": Style(
                margin: Margins.symmetric(horizontal: 5),
                padding: HtmlPaddings.zero,
              ),
              "p": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              "hr": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
            },
          ),
        ),
      ),
    );
  }
}
