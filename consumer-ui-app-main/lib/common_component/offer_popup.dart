import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPopup extends StatelessWidget {
  final String imageUrl;
  final Map<String, dynamic>? link;
  final themeController = Get.find<ThemeController>();

  OfferPopup({
    Key? key,
    required this.imageUrl,
    this.link,
  }) : super(key: key);

  void _handleImageTap() {
    if (link != null) {
      // Handle both 'link' and 'kind' (typo) keys
      final linkType = link!['kind'];
      final linkValue = link!['value'];

      if (linkType != null && linkValue != null) {
        Get.back(); // Close the dialog first
        themeController.navigateByType(linkType, link: linkValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // Main image container
          GestureDetector(
            onTap: _handleImageTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 400,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
