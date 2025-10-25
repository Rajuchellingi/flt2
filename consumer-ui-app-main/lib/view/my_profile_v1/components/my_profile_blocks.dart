// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/view/my_profile_v1/components/MyProfileV1_design1.dart';
import 'package:black_locust/view/my_profile_v1/components/MyProfileV1_design2.dart.dart';
import 'package:black_locust/view/my_profile_v1/components/my_profile_v1_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileBlocks extends StatelessWidget {
  // final _controller = Get.find<LoginV1Controller>();
  final _controller = Get.find<ProfileV1Controller>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var template = _controller.template.value;
    final blocks = template['layout']?['blocks'] ?? [];
    // print("header-===-===============0--------->>>> ${blocks.toString()}");

    return Obx(() => Column(children: [
          if (_controller.isLoading.value)
            LinearProgressIndicator(
              backgroundColor: (brightness == Brightness.dark &&
                      kPrimaryColor == Colors.black)
                  ? Colors.white
                  : Color.fromRGBO(kPrimaryColor.red, kPrimaryColor.green,
                      kPrimaryColor.blue, 0.2),
              color: kPrimaryColor,
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color:
                  brightness == Brightness.dark ? Colors.black : Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Combined Image + Title + Description (design3 case)
                    for (var block in blocks)
                      if (block['componentId'] == 'form-component' &&
                          block['instanceId'] == 'design3') ...[
                        if (block['source'] != null) ...[
                          for (var imgBlock in blocks)
                            if (imgBlock['componentId'] == 'image-component' &&
                                imgBlock['source']?['image'] != null &&
                                imgBlock['source']['image']
                                    .toString()
                                    .isNotEmpty)
                              Stack(
                                children: [
                                  Image.network(
                                    imgBlock['source']['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),

                                  // Overlay text in exact center
                                  Positioned.fill(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (block['source']['title'] != null)
                                            Text(
                                              block['source']['title'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          if (block['source']['description'] !=
                                              null) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              block['source']['description'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        ],
                      ],

                    /// Forms
                    for (var block in blocks)
                      // if (block['componentId'] == 'form-component') ...[
                      if (block['instanceId'] == 'design1') ...[
                        // MyProfileV1Body(controller: _controller),
                        MyProfileV1Design2(controller: _controller),
                      ] else if (block['instanceId'] == 'design2') ...[
                        // MyProfileV1Body(controller: _controller),
                        MyProfileV1BodyV1Design2(controller: _controller),
                      ]
                      // else if (block['instanceId'] == 'design2') ...[
                      //   MyProfileV1Design2(controller: _controller),
                      // ]
                      else ...[
                        // Text("Unknown form design: ${block['instanceId']}"),
                        MyProfileV1Body(controller: _controller),
                      ]
                    // ],
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
