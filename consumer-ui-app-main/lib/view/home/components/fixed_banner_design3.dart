// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../const/constant.dart';
import 'banner_video_player.dart';

class FixedBannerDesign3 extends StatelessWidget {
  const FixedBannerDesign3({
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
    return Stack(
      children: [
        _buildMediaContent(),
        _buildOverlayContent(),
      ],
    );
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
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, bottom: 4),
        child: GestureDetector(
          onTap: () => controller.navigateByUrlType(content['link']),
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
      ),
    );
  }

  Widget _buildOverlayContent() {
    return Positioned(
      bottom: 35,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (design['source']['title']?.isNotEmpty == true)
            SizedBox(
              width: 200,
              child: Text(
                design['source']['title'],
                softWrap: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (design['source']['buttonName']?.isNotEmpty == true)
            GestureDetector(
              onTap: () => controller.navigateByUrlType(content['link']),
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                width: 150,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  design['source']['buttonName'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
