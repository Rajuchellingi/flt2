// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class ExplainerBannerDesign1 extends StatelessWidget {
  const ExplainerBannerDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    var banners = design['source']['lists']
        .where((content) => content['visibility']['hide'] == false)
        .toList();
    if (banners.isEmpty == true) return SizedBox.shrink();
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            design['source']['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          for (var i = 0; i < banners.length; i++) ...[
            buildStep(
                banners[i]['position'].toString(),
                banners[i]['title'] ?? '',
                banners[i]['description'] ?? '',
                (i + 1) == banners.length),
          ]
        ],
      ),
    );
  }

  Widget buildStep(String number, String title, String subtitle, bool isLast) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: kPrimaryColor.withAlpha(50),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 16),
        if (isLast == false) ...[
          const Icon(Icons.arrow_downward, color: kPrimaryColor, size: 22),
          const SizedBox(height: 16),
        ]
      ],
    );
  }
}
