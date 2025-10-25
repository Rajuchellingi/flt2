// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'banner_video_player.dart';

class FixedBannerDesign2 extends StatefulWidget {
  const FixedBannerDesign2({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  State<FixedBannerDesign2> createState() => _FixedBannerDesign2State();
}

class _FixedBannerDesign2State extends State<FixedBannerDesign2> {
  late final List<Map<String, dynamic>> _visibleContents;

  @override
  void initState() {
    super.initState();
    _visibleContents = widget.design['source']['lists']
        .where((content) => content['visibility']['hide'] == false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _visibleContents.map((content) {
        if (content['type'] == 'video') {
          return BannerVideoPlayer(
            videoLink: content['video'],
            autoPlay: content['autoplay'] == true ? 'enabled' : 'disabled',
            audio: content['mute'] == true ? 'mute' : 'unmute',
          );
        }

        final String imageUrl = widget._controller.changeImageUrl(
          content['image'],
          widget.design['componentId'],
        );

        return Container(
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () =>
                  widget._controller.navigateByUrlType(content['link']),
              child: CachedNetworkImage(
                cacheKey: imageUrl,
                imageUrl: imageUrl,
                errorWidget: (_, __, ___) => ErrorImage(),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                memCacheWidth: (SizeConfig.screenWidth * 2).toInt(),
                memCacheHeight: (SizeConfig.screenWidth).toInt(),
                placeholder: (_, __) => Container(
                  constraints: BoxConstraints(
                    minHeight: SizeConfig.screenWidth / 2,
                  ),
                  child: Center(
                    child: ImagePlaceholder(),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
