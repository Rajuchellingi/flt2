// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  final String logoPath;
  final double size;
  final Color rippleColor;

  const LoadingIcon({
    Key? key,
    required this.logoPath,
    this.size = 100,
    this.rippleColor = kPrimaryColor,
  }) : super(key: key);

  @override
  State<LoadingIcon> createState() => _RippleLogoLoaderState();
}

class _RippleLogoLoaderState extends State<LoadingIcon>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxRadius = widget.size;

    return Center(
        child: SizedBox(
      height: maxRadius,
      width: maxRadius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _rippleAnimation,
            builder: (_, __) {
              final radius = _rippleAnimation.value * maxRadius / 2;
              return Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.rippleColor
                      .withOpacity(1 - _rippleAnimation.value),
                ),
              );
            },
          ),
          if (widget.logoPath != null && widget.logoPath.isNotEmpty)
            CachedNetworkImage(
              imageUrl: widget.logoPath,
              cacheKey: widget.logoPath,
              width: widget.size * 0.7,
              height: widget.size * 0.7,
            ),
        ],
      ),
    ));
  }
}
