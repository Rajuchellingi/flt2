// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'banner_video_player.dart';

class FixedBannerDesign1 extends StatefulWidget {
  const FixedBannerDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  State<FixedBannerDesign1> createState() => _FixedBannerDesign1State();
}

class _FixedBannerDesign1State extends State<FixedBannerDesign1> {
  late final List<dynamic> _visibleContent;
  late final String _componentId;

  @override
  void initState() {
    super.initState();
    _componentId = widget.design['componentId'];
    _visibleContent = (widget.design['source']['lists'] as List)
        .where((content) => content['visibility']['hide'] == false)
        .toList();
  }

  String _getImageUrl(String imageUrl) {
    return widget._controller.changeImageUrl(imageUrl, _componentId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _visibleContent.map((content) {
        if (content['type'] == 'video') {
          return BannerVideoPlayer(
            videoLink: content['video'],
            autoPlay: content['autoplay'] == true ? 'enabled' : 'disabled',
            audio: content['mute'] == true ? 'mute' : 'unmute',
          );
        }

        final imageUrl = _getImageUrl(content['image']);
        return Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 4),
          child: GestureDetector(
            onTap: () => widget._controller.navigateByUrlType(content['link']),
            child: CachedNetworkImage(
              cacheKey: imageUrl,
              imageUrl: imageUrl,
              errorWidget: (_, __, ___) => ErrorImage(),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
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
        );
      }).toList(),
    );
  }
}
