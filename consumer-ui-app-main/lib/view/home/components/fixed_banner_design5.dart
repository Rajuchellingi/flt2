// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'banner_video_player.dart';

class FixedBannerDesign5 extends StatelessWidget {
  const FixedBannerDesign5({
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
      children: _buildBannerContent(),
    );
  }

  List<Widget> _buildBannerContent() {
    final List<Widget> widgets = [];
    final lists = design['source']['lists'] as List;

    for (final content in lists) {
      if (content['visibility']['hide'] == false) {
        widgets.add(
          _BannerItem(
            content: content,
            design: design,
            controller: _controller,
          ),
        );
      }
    }
    return widgets;
  }
}

class _BannerItem extends StatelessWidget {
  const _BannerItem({
    Key? key,
    required this.content,
    required this.design,
    required this.controller,
  }) : super(key: key);

  final Map<String, dynamic> content;
  final Map<String, dynamic> design;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return _buildMediaContent();
  }

  Widget _buildMediaContent() {
    if (content['type'] == 'video') {
      return BannerVideoPlayer(
        videoLink: content['video'],
        autoPlay: content['autoplay'] == true ? 'enabled' : 'disabled',
        audio: content['mute'] == true ? 'mute' : 'unmute',
      );
    }

    final imageUrl =
        controller.changeImageUrl(content['image'], design['componentId']);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () => controller.navigateByUrlType(content['link']),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
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
                  )),
        ),
      ),
    );
  }
}
