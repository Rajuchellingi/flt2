import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  // const CachedNetworkImageWidget({
  //   Key? key,
  //   required this.image,
  //   this.fill,
  //   this.placeholderImage,
  //   this.width,
  // }) : super(key: key);
  const CachedNetworkImageWidget(
      {Key? key,
      this.borderRadius = 0,
      required this.image,
      this.fill,
      this.placeholderImage,
      this.width})
      : super(key: key);

  final String image;
  final dynamic fill;
  final double borderRadius;
  final dynamic placeholderImage;
  final int? width;

  @override
  Widget build(BuildContext context) {
    // Optimize image URL with size parameters for Shopify CDN
    // String optimizedUrl = image;
    // if (width != null && image.contains('cdn.shopify.com')) {
    //   optimizedUrl = '$image${image.contains('?') ? '&' : '?'}width=$width';
    // }

    // return CachedNetworkImage(
    //   cacheKey: optimizedUrl,
    //   imageUrl: optimizedUrl,
    //   memCacheWidth: width, // Decode at target width to save memory
    //   memCacheHeight: width != null ? (width! * 1.5).toInt() : null, // Maintain aspect ratio
    //   maxWidthDiskCache: width ?? 400, // Limit disk cache size
    //   maxHeightDiskCache: width != null ? (width! * 1.5).toInt() : 600,
    //   placeholder: (context, url) {
    //     if (placeholderImage != null) {
    //       return Image.network(
    //         placeholderImage,
    //         fit: fill ?? BoxFit.cover,
    //         alignment: Alignment.topCenter,
    //       );
    //     } else {
    //       return ImagePlaceholder();
    //     }
    //   },
    //   errorWidget: (context, url, error) => ErrorImage(),
    //   fit: fill != null ? fill : BoxFit.cover,
    //   alignment: Alignment.topCenter,
    //   fadeInCurve: Curves.easeIn,
    //   placeholderFadeInDuration: const Duration(milliseconds: 10),
    //   fadeInDuration: const Duration(milliseconds: 100),
    // );
    // return Image(
    //   image: NetworkImage(image),
    //   loadingBuilder: (context, child, loadingProgress) {
    //     if (loadingProgress == null) return child;
    //     return ImagePlaceholder();
    //   },
    // );
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          cacheKey: image,
          imageUrl: image,
          placeholder: (context, url) {
            if (placeholderImage != null) {
              return Image.network(
                placeholderImage, // <-- your low-quality image URL
                fit: fill ?? BoxFit.cover,
                alignment: Alignment.topCenter,
              );
            } else {
              return ImagePlaceholder();
            }
          },
          errorWidget: (context, url, error) => ErrorImage(),
          fit: fill != null ? fill : BoxFit.cover,
          alignment: Alignment.topCenter,
          fadeInCurve: Curves.easeIn,
          placeholderFadeInDuration: const Duration(milliseconds: 10),
          fadeInDuration: const Duration(milliseconds: 100),
        ));
  }
}
