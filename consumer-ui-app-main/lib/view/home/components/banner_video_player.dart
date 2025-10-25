// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BannerVideoPlayer extends StatefulWidget {
  const BannerVideoPlayer({
    Key? key,
    required this.videoLink,
    required this.autoPlay,
    this.isAspectRatio = true,
    required this.audio,
  }) : super(key: key);

  final String videoLink;
  final String autoPlay;
  final String audio;
  final bool isAspectRatio;

  @override
  VideoPlayerBodyState createState() => VideoPlayerBodyState();
}

class VideoPlayerBodyState extends State<BannerVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isMute = true;
  bool _isPlaying = false;
  bool _showPause = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoLink),
      );

      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        if (_isDisposed) return;

        _controller.setLooping(true);
        if (widget.autoPlay == 'enabled') {
          _controller.play();
          if (widget.audio == 'mute') {
            _controller.setVolume(0);
          }
        }
      });
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }
  }

  void _playVideo() {
    if (!_isDisposed) {
      _controller.play();
      setState(() => _isPlaying = true);
    }
  }

  void _pauseVideo() {
    if (!_isDisposed) {
      _controller.pause();
      setState(() => _isPlaying = false);
    }
  }

  void _togglePause() {
    if (!_isDisposed) {
      setState(() => _showPause = !_showPause);
    }
  }

  void _toggleMute() {
    if (!_isDisposed) {
      final newVolume = _controller.value.volume == 0 ? 1.0 : 0.0;
      _controller.setVolume(newVolume);
      setState(() => _isMute = newVolume == 0);
    }
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (_isDisposed) return;

    final visibleFraction = info.visibleFraction;
    if (visibleFraction > 0.75) {
      if (widget.autoPlay == 'enabled' && !_isPlaying) {
        _playVideo();
      }
    } else if (_isPlaying) {
      _pauseVideo();
    }
  }

  Widget _buildVideoPlayer() {
    return VisibilityDetector(
      key: Key(widget.videoLink),
      onVisibilityChanged: _handleVisibilityChanged,
      child: VideoPlayer(_controller),
    );
  }

  Widget _buildControls() {
    if (widget.autoPlay == 'disabled') {
      if (!_isPlaying) {
        return _buildPlayButton();
      } else if (_showPause) {
        return _buildPauseButton();
      }
    } else {
      return _buildMuteButton();
    }
    return const SizedBox.shrink();
  }

  Widget _buildPlayButton() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: _playVideo,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: const Icon(
            CupertinoIcons.play_rectangle,
            color: Color(0xFF646369),
            size: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildPauseButton() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: _pauseVideo,
        child: const Icon(
          CupertinoIcons.pause_rectangle,
          color: Color(0xFF646369),
          size: 100,
        ),
      ),
    );
  }

  Widget _buildMuteButton() {
    return Positioned(
      right: 0,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(
            _isMute ? Icons.volume_off : Icons.volume_up_rounded,
            color: Colors.white,
          ),
          onPressed: _toggleMute,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: _togglePause,
                  child: widget.isAspectRatio
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: _buildVideoPlayer(),
                        )
                      : _buildVideoPlayer(),
                ),
                _buildControls(),
              ],
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading video'),
            );
          }

          return SizedBox(
            height: 100,
            child: Center(
              child: ImagePlaceholder(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }
}
