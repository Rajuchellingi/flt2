// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/model/product_detail_model.dart';
import 'package:black_locust/view/product_detail/components/product_meta_video.dart';
import 'package:flutter/material.dart';

class ProductMetaFieldDesign1 extends StatelessWidget {
  const ProductMetaFieldDesign1(
      {Key? key,
      required controller,
      required this.design,
      required this.metaField})
      : super(key: key);

  final design;
  final MetafieldVM? metaField;

  @override
  Widget build(BuildContext context) {
    if (metaField != null) {
      if (metaField!.references != null) {
        if (metaField!.references!.edges != null &&
            metaField!.references!.edges.length > 0) {
          return Column(children: [
            for (var element in metaField!.references!.edges) ...[
              if (element.mediaContentType == 'IMAGE') ...[
                Container(
                    child: Image.network(
                  element.image!.url.toString(),
                  fit: BoxFit.cover,
                ))
              ] else if (element.mediaContentType == 'VIDEO') ...[
                Container(
                    child:
                        ProductMetaVideo(videoLink: element.sources!.first.url))
              ]
            ]
          ]);
        }
      } else if (metaField!.reference != null) {
        if (metaField!.reference!.mediaContentType == 'IMAGE') {
          return Container(
              child: Image.network(
            metaField!.reference!.image!.url.toString(),
            fit: BoxFit.cover,
          ));
        } else if (metaField!.reference!.mediaContentType == 'VIDEO') {
          return Container(
              child: ProductMetaVideo(
                  videoLink: metaField!.reference!.sources!.first.url));
        }
      }
    }
    return Container();
  }
}
