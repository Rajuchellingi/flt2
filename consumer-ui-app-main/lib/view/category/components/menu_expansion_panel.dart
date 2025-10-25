import 'package:black_locust/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuExpansionPanel extends StatefulWidget {
  final String headerText;
  final Widget content;
  final bool initiallyExpanded;
  final bool hasSubmenu;
  final menu;

  const MenuExpansionPanel({
    Key? key,
    required this.headerText,
    required this.content,
    required this.hasSubmenu,
    required this.menu,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<MenuExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<MenuExpansionPanel>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  bool _isExpanded = false;
  final _controller = Get.find<CategoryController>();

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
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                widget.hasSubmenu
                    ? _toggleExpansion()
                    : _controller.checkUrlAndNavigate(widget.menu.link);
              },
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(widget.headerText,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15)),
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
                            color: Colors.black,
                          ),
                    onPressed: () {
                      widget.hasSubmenu
                          ? _toggleExpansion()
                          : _controller.checkUrlAndNavigate(widget.menu.link);
                    },
                  ),
                ],
              ),
            ),
            SizeTransition(
              // axisAlignment: 20,
              sizeFactor: _expandAnimation!,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: widget.content,
              ),
            ),
          ],
        ));
  }
}
