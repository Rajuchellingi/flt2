// ignore_for_file: unused_field

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'banner_video_player.dart';

class CustomBannerDesign3 extends StatelessWidget {
  const CustomBannerDesign3(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final HomeController _controller;
  final design;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 5),
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
                        : Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// GRID
            StaggeredGrid.count(
              crossAxisCount: crossAxisCount(design['source']['lists']),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                for (var row in design['source']['lists']) ...[
                  if (row['visibility']['hide'] == false) ...[
                    for (var element in row['rowContent']) ...[
                      if (element['visibility']['hide'] == false) ...[
                        StaggeredGridTile.count(
                          crossAxisCellCount: crossAxisCellCount(
                              row['rowContent'], element['colspan']),
                          mainAxisCellCount: mainAxisCellCount(
                              row['rowContent'],
                              element['rowspan'],
                              element['colspan']),
                          child: GestureDetector(
                            onTap: () {
                              _controller.navigateByUrlType(element['link']);
                            },
                            child: Card(
                              surfaceTintColor: Colors.white,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// Image / Logo
                                    Expanded(
                                      child: element['type'] == 'video'
                                          ? BannerVideoPlayer(
                                              videoLink: element['video'],
                                              autoPlay: 'disabled',
                                              audio: 'mute',
                                              isAspectRatio: false,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  _controller.changeImageUrl(
                                                      element['image'] ?? '',
                                                      design['componentId']),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ErrorImage(),
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          ImagePlaceholder()),
                                              fit: BoxFit.contain,
                                            ),
                                    ),

                                    const SizedBox(height: 2),
                                    Text(
                                      element['title'] ?? "",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    Text(
                                      element['subtitle'] ?? "",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange[100],
                                          foregroundColor: Colors.deepOrange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                        onPressed: () {
                                          _controller
                                              .downloadCatelog(element['link']);
                                        },
                                        child: Text(
                                          element['buttonName'] ??
                                              "Download Catalog",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ]
                  ]
                ]
              ],
            ),

            const SizedBox(height: 10),
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
