// ignore_for_file: must_be_immutable, unused_field

import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class TestimonialDesign1 extends StatelessWidget {
  const TestimonialDesign1({
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
          const SizedBox(height: 20),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: [
                  for (var item in banners) ...[
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.7,
                      child: buildTestimonial(
                        imageUrl: item['image'] ?? '',
                        name: item['title'] ?? '',
                        role: item['designation'] ?? '',
                        quote: item['description'] ?? '',
                      ),
                    )
                  ],
                ],
              ))),
        ],
      ),
    );
  }

  Widget buildTestimonial({
    required String imageUrl,
    required String name,
    required String role,
    required String quote,
  }) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      borderOnForeground: true,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            if (imageUrl.isNotEmpty) ...[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(height: 16),
            ],
            if (name.isNotEmpty) ...[
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
            ],
            if (role.isNotEmpty) ...[
              Text(
                role,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15)
            ],
            if (quote.isNotEmpty) ...[
              Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
