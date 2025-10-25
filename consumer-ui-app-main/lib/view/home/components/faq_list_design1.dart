// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class FAQListDesign1 extends StatelessWidget {
  const FAQListDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    final lists = design['source']['lists'] as List;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            design['source']['title'] as String,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          ...List.generate(
            lists.length,
            (i) {
              var isHide = lists[i]['visibility']['hide'] ?? true;
              if (isHide) {
                return const SizedBox.shrink();
              }
              return FAQExpansionPanel(
                key: ValueKey('faq_$i'),
                headerText: lists[i]['question'] as String,
                content: Text(lists[i]['answer'] as String),
                initiallyExpanded: false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class FAQExpansionPanel extends StatefulWidget {
  final String headerText;
  final Widget content;
  final bool initiallyExpanded;

  const FAQExpansionPanel({
    Key? key,
    required this.headerText,
    required this.content,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<FAQExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<FAQExpansionPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _isExpanded = widget.initiallyExpanded;
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 199, 199, 199),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpansion,
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    widget.headerText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: _toggleExpansion,
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
