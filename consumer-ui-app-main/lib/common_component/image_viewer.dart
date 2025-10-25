import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({
    Key? key,
    required this.imageIndex,
    required this.gallery,
  }) : super(key: key);

  final int imageIndex;
  final gallery;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  late TransformationController _transformationController;
  TapDownDetails? _tapDownDetails;
  int _currentIndex = 0;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.imageIndex;
    _pageController = PageController(initialPage: widget.imageIndex);
    _transformationController = TransformationController();
    _transformationController.addListener(_onZoomChange);
  }

  void _onZoomChange() {
    setState(() {
      _isZoomed = !_transformationController.value.isIdentity();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          '${_currentIndex + 1} of ${widget.gallery.length}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          physics: _isZoomed
              ? const NeverScrollableScrollPhysics()
              : const PageScrollPhysics(),
          itemCount: widget.gallery.length,
          onPageChanged: (index) {
            if (!_isZoomed) {
              setState(() {
                _currentIndex = index;
                _transformationController.value = Matrix4.identity();
              });
            }
          },
          itemBuilder: (context, index) {
            return _buildZoomableImage(widget.gallery[index].imageName);
          },
        ),
      ),
    );
  }

  Widget _buildZoomableImage(String imageUrl) {
    return GestureDetector(
      onDoubleTapDown: (details) => _tapDownDetails = details,
      onDoubleTap: () {
        final position = _tapDownDetails?.localPosition ?? Offset.zero;
        final double scale = 3.0;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);

        final zoomed = Matrix4.identity()
          ..translate(x, y)
          ..scale(scale);

        _transformationController.value =
            _transformationController.value.isIdentity()
                ? zoomed
                : Matrix4.identity();
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: true,
        scaleEnabled: true,
        clipBehavior: Clip.none,
        minScale: 1.0,
        maxScale: 10.0,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) => Center(child: ImagePlaceholder()),
          errorWidget: (context, url, error) => ErrorImage(),
        ),
      ),
    );
  }
}
