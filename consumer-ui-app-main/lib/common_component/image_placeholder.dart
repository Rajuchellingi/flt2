import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        CupertinoIcons.photo,
        size: 50,
        color: Colors.grey[300],
      ),
    );
  }
}
