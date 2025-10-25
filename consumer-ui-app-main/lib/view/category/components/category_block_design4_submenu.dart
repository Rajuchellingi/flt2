import 'package:black_locust/controller/category_controller.dart';
import 'package:flutter/material.dart';

class CategoryBlockDesign4Submenu extends StatefulWidget {
  final String headerText;
  final Widget content;
  final bool initiallyExpanded;
  final bool hasSubmenu;
  final link;
  final CategoryController _controller;

  const CategoryBlockDesign4Submenu({
    Key? key,
    required this.headerText,
    required this.content,
    required this.link,
    required controller,
    required this.hasSubmenu,
    this.initiallyExpanded = false,
  })  : _controller = controller,
        super(key: key);

  @override
  State<CategoryBlockDesign4Submenu> createState() =>
      _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CategoryBlockDesign4Submenu>
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
    return Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey, width: 1.5),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        child: Column(
      children: [
        InkWell(
          onTap: () {
            widget.hasSubmenu
                ? _toggleExpansion()
                : widget._controller.navigateByUrlType(widget.link);
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Text(widget.headerText, style: const TextStyle(fontSize: 15)),
              const Spacer(),
              IconButton(
                icon: widget.hasSubmenu
                    ? Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                      )
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        weight: 10,
                        // color: Colors.black,
                      ),
                onPressed: () {
                  widget.hasSubmenu
                      ? _toggleExpansion()
                      : widget._controller.navigateByUrlType(widget.link);
                },
              ),
            ],
          ),
        ),
        SizeTransition(
          // axisAlignment: 20,
          sizeFactor: _expandAnimation!,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: widget.content,
          ),
        ),
      ],
    ));
  }
}
