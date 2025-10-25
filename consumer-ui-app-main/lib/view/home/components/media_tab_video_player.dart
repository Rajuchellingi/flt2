// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaTabVideoPlayer extends StatefulWidget {
  const MediaTabVideoPlayer({
    Key? key,
    required this.videoLink,
  }) : super(key: key);

  final String videoLink;

  @override
  VideoPlayerBodyState createState() => VideoPlayerBodyState();
}

class VideoPlayerBodyState extends State<MediaTabVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = VideoPlayerController.network(
        widget.videoLink,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _controller.setLooping(true);
            _controller.play();
            _controller.setVolume(0);
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_hasError) {
      return Center(
        child: ImagePlaceholder(),
      );
    }

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _isInitialized) {
          return Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          return Center(
            child: ImagePlaceholder(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
