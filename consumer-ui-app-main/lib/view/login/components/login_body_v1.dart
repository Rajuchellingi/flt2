// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:black_locust/view/login/components/login_form_design3.dart';
import 'package:black_locust/view/login/components/login_form_design4.dart';
import 'package:black_locust/view/login/components/login_form_v1.dart';
import 'package:black_locust/view/login/components/login_form_v2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginBodyV1 extends StatelessWidget {
  final _controller = Get.find<LoginV1Controller>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var template = _controller.template.value;
    final blocks = template['layout']?['blocks'] ?? [];

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Combined Image + Title + Description (design3 case)
                    // for (var block in blocks) ...[
                    //   if (block['componentId'] == 'form-component') ...[
                    //     Builder(
                    //       builder: (_) {
                    //         // find first image block if exists
                    //         var imgBlock = blocks.firstWhere(
                    //           (b) =>
                    //               b['componentId'] == 'image-component' &&
                    //               b['source']?['image'] != null &&
                    //               b['source']['image'].toString().isNotEmpty,
                    //           orElse: () => null,
                    //         );

                    //         if (imgBlock != null) {
                    //           // Image + text overlay
                    //           return Stack(
                    //             children: [
                    //               Image.network(
                    //                 imgBlock['source']['image'],
                    //                 width: double.infinity,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //               Positioned.fill(
                    //                 child: Center(
                    //                   child: Column(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       if (block['source']?['title'] != null)
                    //                         Text(
                    //                           block['source']['title'],
                    //                           textAlign: TextAlign.center,
                    //                           style: const TextStyle(
                    //                             color: Colors.black,
                    //                             fontSize: 22,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       if (block['source']?['description'] !=
                    //                           null) ...[
                    //                         const SizedBox(height: 8),
                    //                         Text(
                    //                           block['source']['description'],
                    //                           textAlign: TextAlign.center,
                    //                           style: const TextStyle(
                    //                             color: Colors.white70,
                    //                             fontSize: 16,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         } else {
                    //           return Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               if (block['source']?['title'] != null)
                    //                 Text(
                    //                   block['source']['title'],
                    //                   textAlign: TextAlign.center,
                    //                   style: const TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 25,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               if (block['source']?['description'] !=
                    //                   null) ...[
                    //                 const SizedBox(height: 8),
                    //                 Text(
                    //                   block['source']['description'],
                    //                   textAlign: TextAlign.center,
                    //                   style: const TextStyle(
                    //                     color: Colors.black54,
                    //                     fontSize: 16,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ],
                    //           );
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ],

                    /// Forms
                    for (var block in blocks)
                      if (block['componentId'] == 'form-component') ...[
                        if (block['instanceId'] == 'design1') ...[
                          LoginFormV2(block: block),
                        ] else if (block['instanceId'] == 'design2') ...[
                          LoginFormV1(),
                        ] else if (block['instanceId'] == 'design3') ...[
                          LoginFormV2Design3(block: block),
                        ] else if (block['instanceId'] == 'design4') ...[
                          LoginFormV2Design4(block: block),
                        ] else ...[
                          Text("Unknown form design: ${block['instanceId']}"),
                        ]
                      ],
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
