// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'banner_video_player.dart';

class CustomBannerDesign2 extends StatelessWidget {
  const CustomBannerDesign2(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        // padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: Text(
              design['source']['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
            ))),
        const SizedBox(height: 10),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount(design['source']['lists']),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          children: [
            for (var row in design['source']['lists']) ...[
              if (row['visibility']['hide'] == false) ...[
                for (var element in row['rowContent']) ...[
                  if (element['visibility']['hide'] == false) ...[
                    StaggeredGridTile.count(
                      crossAxisCellCount: crossAxisCellCount(
                          row['rowContent'], element['colspan']),
                      mainAxisCellCount: mainAxisCellCount(row['rowContent'],
                          element['rowspan'], element['colspan']),
                      // mainAxisExtent:
                      //     getBannerSize(row['rowContent'], element['rowspan']),
                      child: Container(
                          width: getBannerWidthSize(
                              row['rowContent'], element['colspan']),
                          height: getBannerSize(
                              row['rowContent'], element['rowspan']),
                          child: GestureDetector(
                              onTap: () {
                                _controller.navigateByUrlType(element['link']);
                              },
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Container(
                                    width: getBannerWidthSize(
                                        row['rowContent'], element['colspan']),
                                    height: getBannerSize(
                                        row['rowContent'], element['rowspan']),

                                    // padding: const EdgeInsets.all(4),
                                    child: element['type'] == 'video'
                                        ? FittedBox(
                                            fit: BoxFit.cover,
                                            child: Container(
                                                width: getBannerWidthSize(
                                                    row['rowContent'],
                                                    element['colspan']),
                                                height: getBannerSize(
                                                    row['rowContent'],
                                                    element['rowspan']),
                                                child: BannerVideoPlayer(
                                                  videoLink: element['video'],
                                                  autoPlay: 'disabled',
                                                  audio: 'mute',
                                                  isAspectRatio: false,
                                                )))
                                        : GestureDetector(
                                            onTap: () {
                                              _controller.navigateByUrlType(
                                                  element['link']);
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  _controller.changeImageUrl(
                                                      element['image'] ?? '',
                                                      design['componentId']),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ErrorImage(),
                                              // height: 100,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              placeholder: (context, url) =>
                                                  Container(
                                                child: Center(
                                                  child: ImagePlaceholder(),
                                                ),
                                              ),
                                            ),
                                          )),
                                Positioned(
                                    bottom: 5,
                                    left: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: kPrimaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      width: getBannerWidthSize(
                                              row['rowContent'],
                                              element['colspan']) -
                                          20,
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        element['title'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          height: 1.2,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                              ]))),
                    ),
                  ]
                ]
              ]
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  int crossAxisCount(lists) {
    int count = 1;
    if (lists != null && lists.length > 0) {
      for (var row in lists) {
        if (row['visibility']['hide'] == false) {
          var rowCountValue = rowCount(row['rowContent']);
          if (rowCountValue > count) count = rowCountValue;
        }
      }
    }
    return count;
  }

  int rowCount(rowContent) {
    if (rowContent != null && rowContent.length > 0) {
      var visibleRowContent = rowContent
          .where((element) => element['visibility']['hide'] == false)
          .toList();
      return visibleRowContent.length;
    } else {
      return 1;
    }
  }

  int crossAxisCellCount(rowContent, colspan) {
    int colspanValue = colspan ?? 1;
    // var count = rowCount(rowContent);
    // print('colspan $colspanValue $count');
    // if (count == 1)
    //   return colspanValue > 1 ? 2 : 1;
    // else
    return colspanValue;
  }

  int mainAxisCellCount(rowContent, rowspan, colspan) {
    int rowspanValue = rowspan ?? 1;
    int colspanValue = colspan ?? 1;
    var count = rowCount(rowContent);
    if (count == 1 && colspanValue > 1 && rowspanValue <= 1)
      return colspanValue * rowspanValue;
    return rowspanValue;
  }

  int totalCount() {
    var count = 0;
    for (var row in design['source']['lists']) {
      if (row['visibility']['hide'] == false) {
        count += rowCount(row['rowContent']);
      }
    }
    return count;
  }

  getBannerSize(content, value) {
    var span = value ?? 1;
    var count = rowCount(content);
    var size = (SizeConfig.screenWidth / count).toDouble();
    return span != 1 ? size * span : size;
  }

  getBannerWidthSize(content, value) {
    var span = value ?? 1;
    var count = rowCount(content);
    var size = (SizeConfig.screenWidth / count).toDouble();
    return span != 1 ? size * span : size;
  }
}
