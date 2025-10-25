// ignore_for_file: unused_field, deprecated_member_use

import 'package:black_locust/common_component/error_image.dart';
import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/view/home/components/banner_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomBannerDesign1 extends StatelessWidget {
  const CustomBannerDesign1(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;

  @override
  Widget build(BuildContext context) {
    // var columnCount = design['source']['columnCount'] ?? 2;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
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
                            mainAxisCellCount: mainAxisCellCount(
                                row['rowContent'],
                                element['rowspan'],
                                element['colspan']),
                            // mainAxisExtent:
                            //     getBannerSize(row['rowContent'], element['rowspan']),
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                width: getBannerWidthSize(
                                    row['rowContent'], element['colspan']),
                                height: getBannerSize(
                                    row['rowContent'], element['rowspan']),
                                child: GestureDetector(
                                    onTap: () {
                                      _controller
                                          .navigateByUrlType(element['link']);
                                    },
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                              width: getBannerWidthSize(
                                                  row['rowContent'],
                                                  element['colspan']),
                                              height: getBannerSize(
                                                  row['rowContent'],
                                                  element['rowspan']),

                                              // padding: const EdgeInsets.all(4),
                                              child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    Color.fromARGB(255, 2, 2, 2)
                                                        .withOpacity(
                                                            0.4), // Adjust the color and opacity as needed
                                                    BlendMode.srcATop,
                                                  ),
                                                  child: element['type'] ==
                                                          'video'
                                                      ? FittedBox(
                                                          alignment:
                                                              Alignment.center,
                                                          fit: BoxFit.cover,
                                                          child: Container(
                                                              width: getBannerWidthSize(
                                                                  row[
                                                                      'rowContent'],
                                                                  element[
                                                                      'colspan']),
                                                              height: getBannerSize(
                                                                  row[
                                                                      'rowContent'],
                                                                  element[
                                                                      'rowspan']),
                                                              child:
                                                                  BannerVideoPlayer(
                                                                videoLink:
                                                                    element[
                                                                        'video'],
                                                                autoPlay:
                                                                    'disabled',
                                                                audio: 'mute',
                                                                isAspectRatio:
                                                                    false,
                                                              )))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            _controller
                                                                .navigateByUrlType(
                                                                    element[
                                                                        'link']);
                                                          },
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: _controller
                                                                .changeImageUrl(
                                                                    element['image'] ??
                                                                        '',
                                                                    design[
                                                                        'componentId']),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                ErrorImage(),
                                                            // height: 100,
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment
                                                                .topCenter,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              child: Center(
                                                                child:
                                                                    ImagePlaceholder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ))),
                                          if (element['title'] != null &&
                                              element['title'].isNotEmpty)
                                            Container(
                                              width: getBannerWidthSize(
                                                  row['rowContent'],
                                                  element['colspan']),
                                              // height: getBannerSize(
                                              //     row['rowContent'],
                                              //     element['rowspan']),
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                element['title'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ]))),
                          ),
                        ]
                      ]
                    ]
                  ]
                ]),
            // for (var row in design['source']['lists']) ...[
            //   if (row['visibility']['hide'] == false) ...[
            //     Container(
            //         child: Row(children: [
            //       for (var element in row['rowContent']) ...[
            //         if (element['visibility']['hide'] == false) ...[
            //           Container(
            //               width: (SizeConfig.screenWidth - 10) /
            //                   rowCount(row['rowContent']),
            //               child: GestureDetector(
            //                   onTap: () {
            //                     _controller.navigateByUrlType(element['link']);
            //                   },
            //                   child:
            //                       Stack(alignment: Alignment.center, children: [
            //                     Container(
            //                         padding: const EdgeInsets.all(4),
            //                         child: GestureDetector(
            //                           onTap: () {
            //                             _controller
            //                                 .navigateByUrlType(element['link']);
            //                           },
            //                           child: ColorFiltered(
            //                             colorFilter: ColorFilter.mode(
            //                               Color.fromARGB(255, 2, 2, 2).withOpacity(
            //                                   0.4), // Adjust the color and opacity as needed
            //                               BlendMode.srcATop,
            //                             ),
            //                             child: CachedNetworkImage(
            //                               imageUrl: element['image'],
            //                               errorWidget: (context, url, error) =>
            //                                   Icon(Icons.error),
            //                               // height: 100,
            //                               fit: BoxFit.fitWidth,
            //                               alignment: Alignment.topCenter,
            //                               placeholder: (context, url) =>
            //                                   Container(
            //                                 child: Center(
            //                                   child: CircularProgressIndicator(
            //                                     color: kPrimaryColor,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         )),
            //                     Container(
            //                       width: getBannerWidth(columnCount),
            //                       padding: const EdgeInsets.all(8),
            //                       child: Text(
            //                         element['title'],
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   ]))),
            //         ]
            //       ]
            //     ]))
            //   ]
            // ],
            // for (var i = 0; i < rowCount(); i++)
            //   Container(
            //     padding: EdgeInsets.symmetric(horizontal: 10),
            //     child: Wrap(children: [
            //       for (var j = 0; j < currentRowColumnCount(i); j++) ...[
            //         GestureDetector(
            //             onTap: () {
            //               var banner = currentBanner(i, j);
            //               _controller.navigateByUrlType(banner['link']);
            //             },
            //             child: Stack(alignment: Alignment.center, children: [
            //               Container(
            //                   width: getBannerWidth(columnCount),
            //                   child: Container(
            //                       padding: const EdgeInsets.all(4),
            //                       child: GestureDetector(
            //                         onTap: () {
            //                           var banner = currentBanner(i, j);
            //                           _controller.navigateByUrlType(banner['link']);
            //                         },
            //                         child: ColorFiltered(
            //                           colorFilter: ColorFilter.mode(
            //                             Color.fromARGB(255, 2, 2, 2).withOpacity(
            //                                 0.4), // Adjust the color and opacity as needed
            //                             BlendMode.srcATop,
            //                           ),
            //                           child: CachedNetworkImage(
            //                             imageUrl: currentBannerImage(i, j),
            //                             errorWidget: (context, url, error) =>
            //                                 Icon(Icons.error),
            //                             // height: 100,
            //                             fit: BoxFit.fitWidth,
            //                             alignment: Alignment.topCenter,
            //                             placeholder: (context, url) => Container(
            //                               child: Center(
            //                                 child: CircularProgressIndicator(
            //                                   color: kPrimaryColor,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ))),
            //               Container(
            //                 width: getBannerWidth(columnCount),
            //                 padding: const EdgeInsets.all(8),
            //                 child: Text(
            //                   currentBannerTitle(i, j),
            //                   textAlign: TextAlign.center,
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ]))
            //       ]
            //     ]),
            //   ),
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

  getBannerWidth(bannerCount) {
    var width = bannerCount <= 3 ? bannerCount : 2;
    return (SizeConfig.screenWidth / width) - 10;
  }
}
