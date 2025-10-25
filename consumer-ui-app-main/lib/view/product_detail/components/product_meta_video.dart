import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProductMetaVideo extends StatefulWidget {
  const ProductMetaVideo({
    Key? key,
    required this.videoLink,
  }) : super(key: key);

  final String videoLink; // Explicitly define the type

  @override
  VideoPlayerBodyState createState() => VideoPlayerBodyState();
}

class VideoPlayerBodyState extends State<ProductMetaVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoLink);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setLooping(true);
        _controller.play();
        _controller.setVolume(0); // Mute the video
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return VisibilityDetector(
                key: Key(widget.videoLink),
                onVisibilityChanged: (value) {
                  final visibleFraction = value.visibleFraction;
                  if (visibleFraction > 0.75) {
                    _controller.play();
                  } else {
                    _controller.pause();
                  }
                },
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Center(
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    )));
          } else {
            return Container();
          }
        });
  }

  @override
  void dispose() {
    // Dispose the controller when done
    _controller.dispose();
    super.dispose();
  }
}
