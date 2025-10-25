// ignore_for_file: unused_field

import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../const/size_config.dart';

class IconInfoDesign2 extends StatelessWidget {
  const IconInfoDesign2(
      {Key? key,
      required this.design,
      required this.themeController,
      required controller})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final ThemeController themeController;
  final design;

  @override
  Widget build(BuildContext context) {
    var lists = design['source']['lists'];
    var style = design['style'];
    return Container(
        width: SizeConfig.screenWidth,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: themeController.defaultStyle(
            'backgroundColor', style['backgroundColor']),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (var i = 0; i < lists.length; i++) ...[
                    if (lists[i]['visibility']['hide'] == false) ...[
                      Container(
                          width: (SizeConfig.screenWidth / 2) - 21,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: _controller.changeImageUrl(
                                        lists[i]['image'],
                                        design['componentId']),
                                    fit: BoxFit.cover,
                                    height: 50,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/error_image.png'),
                                  ),
                                  if (lists[i]['title'] != null) ...[
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        lists[i]['title'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: themeController.defaultStyle(
                                                'color', style['color']),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                  if (lists[i]['description'] != null) ...[
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        lists[i]['description'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: themeController.defaultStyle(
                                                'color', style['color']),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ],
                              ))),
                      if (i % 2 == 0 && i + 1 < lists.length)
                        Container(
                          height: 100,
                          width: 1,
                          color: themeController.defaultStyle(
                              'color', style['color']),
                        ),
                    ]
                  ]
                ]),
            const SizedBox(height: 10),
          ],
        ));
  }
}
