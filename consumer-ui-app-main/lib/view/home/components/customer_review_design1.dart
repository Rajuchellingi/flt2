// ignore_for_file: deprecated_member_use, unused_field

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomerReviewDesign1 extends StatelessWidget {
  const CustomerReviewDesign1({
    Key? key,
    required this.design,
    required dynamic controller,
  })  : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final Map<String, dynamic> design;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
                child: Text(
              design['source']['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            if (design['source']['rating'] != null &&
                design['source']['rating'].isNotEmpty) ...[
              Row(children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(
                  design['source']['rating'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ])
            ],
          ]),
          SizedBox(height: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var content in design['source']['lists'] ?? []) ...[
                    if (content['visibility']['hide'] == false) ...[
                      Container(
                          width: SizeConfig.screenWidth / 1.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xFFE5E7EB))),
                          margin: EdgeInsets.only(right: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (content['image'] != null &&
                                                content['image'].isNotEmpty)
                                            ? Colors.white
                                            : kPrimaryColor,
                                      ),
                                      child: ClipOval(
                                        child: (content['image'] != null &&
                                                content['image'].isNotEmpty)
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    _controller.changeImageUrl(
                                                        content['image'],
                                                        design['componentId']),
                                                fit: BoxFit.contain,
                                                width: 35,
                                                height: 35,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )
                                            : Icon(Icons.person_2,
                                                color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          content['title'],
                                          style: TextStyle(
                                              // fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: List.generate(5, (index) {
                                            if (index + 1 <=
                                                num.parse(
                                                    content['rating'] ?? '0')) {
                                              return Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 16);
                                            } else if (index <
                                                num.parse(
                                                    content['rating'] ?? '0')) {
                                              return Icon(Icons.star_half,
                                                  color: Colors.amber,
                                                  size: 16);
                                            } else {
                                              return Icon(Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16);
                                            }
                                          }),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  content['description'] ?? '',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ))
                    ]
                  ]
                ],
              ))
        ],
      ),
    );
  }
}
