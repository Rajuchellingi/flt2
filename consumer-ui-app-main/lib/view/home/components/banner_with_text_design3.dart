import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BannerWithTextDesign3 extends StatelessWidget {
  const BannerWithTextDesign3({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
      return _BannerItem(
        content: content,
        controller: _controller,
        componentId: design['componentId'],
      );
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
        if (content['title'] != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              content['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        /// Center Image with rounded corners
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: controller.changeImageUrl(content['image'], componentId),
            width: 180,
            height: 180,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Image(
              image: AssetImage('assets/images/error_image.png'),
            ),
          ),
        ),

        const SizedBox(height: 16),

        if (content['description'] != null)
          _BannerDescription(
            description: content['description'],
            fontSize: 16,
            fontWeight: FontWeight.w400,
            // color: Colors.black87,
          ),

        const SizedBox(height: 12),

        if (content['description2'] != null)
          _BannerDescription(
            description: content['description2'],
            fontSize: 14,
            fontWeight: FontWeight.w400,
            // color: Colors.black54,
          ),
      ],
    );
  }
}

class _BannerDescription extends StatelessWidget {
  const _BannerDescription({
    Key? key,
    required this.description,
    required this.fontSize,
    required this.fontWeight,
    // required this.color,
  }) : super(key: key);

  final String description;
  final double fontSize;
  final FontWeight fontWeight;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Html(
        data: description,
        style: {
          "body": Style(
            textAlign: TextAlign.center,
            // color: color,
            fontSize: FontSize(fontSize),
            fontWeight: fontWeight,
            lineHeight: const LineHeight(1.5),
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          "p": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
        },
      ),
    );
  }
}
