import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryBlockDesign4Menu extends StatefulWidget {
  final String headerText;
  final Widget content;
  final CategoryController _controller;
  final bool initiallyExpanded;
  final bool hasSubmenu;
  final link;
  final image;

  const CategoryBlockDesign4Menu({
    Key? key,
    required this.headerText,
    required this.content,
    required this.hasSubmenu,
    required this.link,
    this.image,
    required controller,
    this.initiallyExpanded = false,
  })  : _controller = controller,
        super(key: key);

  @override
  State<CategoryBlockDesign4Menu> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CategoryBlockDesign4Menu>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _isExpanded = widget.initiallyExpanded;
    _expandAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController!.forward();
      } else {
        _animationController!.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  widget.hasSubmenu
                      ? _toggleExpansion()
                      : widget._controller.navigateByUrlType(widget.link);
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  color: brightness == Brightness.dark
                      ? Colors.black
                      : kBackground,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.image != null && widget.image.isNotEmpty) ...[
                        Container(
                            width: SizeConfig.screenWidth / 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                  imageUrl: widget.image,
                                  errorWidget: (context, url, error) =>
                                      ErrorImage(),
                                  // height: 100,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                  placeholder: (context, url) => Container(
                                        height: 80,
                                        child: Center(
                                          child: ImagePlaceholder(),
                                        ),
                                      )),
                            )),
                        const SizedBox(width: 20)
                      ],
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.headerText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // color: Colors.black,
                                    fontSize: 18)),
                            if (widget.hasSubmenu)
                              const Icon(
                                Icons.expand_more,
                                size: 20,
                              )
                          ])
                      // IconButton(
                      //   icon: widget.hasSubmenu
                      //       ? Icon(
                      //           _isExpanded ? Icons.expand_less : Icons.expand_more,
                      //         )
                      //       : Icon(
                      //           Icons.arrow_forward_ios,
                      //           size: 15,
                      //           weight: 10,
                      //           color: Colors.black,
                      //         ),
                      //   onPressed: () {
                      //     widget.hasSubmenu
                      //         ? _toggleExpansion()
                      //         : _controller.navigateByUrlType(widget.menu.link);
                      //   },
                      // ),
                    ],
                  ),
                )),
            SizeTransition(
              // axisAlignment: 20,
              sizeFactor: _expandAnimation!,
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: widget.content,
              ),
            ),
          ],
        ));
  }
}
