// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use, unnecessary_type_check

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:black_locust/view/register/components/registration_form_field_v1.dart';
import 'package:black_locust/view/register/components/registration_form_field_v1_design3.dart';
import 'package:black_locust/view/register/components/registration_form_field_v1_design4.dart';
import 'package:black_locust/view/register/components/registration_form_field_v2.dart';
import 'package:black_locust/view/register/components/user_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/size_config.dart';

class RegistrationFormBodyV1 extends StatelessWidget {
  final _controller = Get.find<RegistrationV1Controller>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final template = _controller.template.value;
      final blocks =
          template is Map ? (template['layout']?['blocks'] ?? []) : [];

      return Column(
        children: [
          if (_controller.isProgress.value)
            Container(
              width: SizeConfig.screenWidth,
              child: LinearProgressIndicator(
                backgroundColor: (brightness == Brightness.dark &&
                        kPrimaryColor == Colors.black)
                    ? Colors.white
                    : Color.fromRGBO(
                        kPrimaryColor.red,
                        kPrimaryColor.green,
                        kPrimaryColor.blue,
                        0.2,
                      ),
                color: kPrimaryColor,
              ),
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color:
                  brightness == Brightness.dark ? Colors.black : Colors.white,
              child: SingleChildScrollView(
                child: _controller.isLoading.value
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          if (_controller.isUserType.value) ...[
                            UserTypeBody(controller: _controller)
                          ] else ...[
                            // for (var block in blocks) ...[
                            //   if (block['componentId'] == 'form-component') ...[
                            //     Builder(
                            //       builder: (_) {
                            //         // find first image block if exists
                            //         var imgBlock = blocks.firstWhere(
                            //           (b) =>
                            //               b['componentId'] ==
                            //                   'image-component' &&
                            //               b['source']?['image'] != null &&
                            //               b['source']['image']
                            //                   .toString()
                            //                   .isNotEmpty,
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
                            //                       if (block['source']
                            //                               ?['title'] !=
                            //                           null)
                            //                         Text(
                            //                           block['source']['title'],
                            //                           textAlign:
                            //                               TextAlign.center,
                            //                           style: const TextStyle(
                            //                             color: Colors.black,
                            //                             fontSize: 22,
                            //                             fontWeight:
                            //                                 FontWeight.bold,
                            //                           ),
                            //                         ),
                            //                       if (block['source']
                            //                               ?['description'] !=
                            //                           null) ...[
                            //                         const SizedBox(height: 8),
                            //                         Text(
                            //                           block['source']
                            //                               ['description'],
                            //                           textAlign:
                            //                               TextAlign.center,
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
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
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
                            // Show forms
                            for (var block in blocks)
                              if (block['componentId'] == 'form-component') ...[
                                if (block['instanceId'] == 'design1') ...[
                                  RegistrationFormFieldV2(block: block),
                                ] else if (block['instanceId'] ==
                                    'design2') ...[
                                  RegistrationFormFieldV1(),
                                ] else if (block['instanceId'] ==
                                    'design3') ...[
                                  RegistrationFormFieldV1Design3(),
                                ] else if (block['instanceId'] ==
                                    'design4') ...[
                                  RegistrationFormFieldV1Design4(block: block),
                                ] else ...[
                                  Text(
                                      "Unknown form design: ${block['instanceId']}"),
                                ]
                              ]
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ],
      );
    });
  }

  String getUserType(String type) {
    switch (type) {
      case 'individual-buyer':
        return "Individual Buyer";
      case 'distributor':
        return "Distributor";
      case 'wholesaler':
        return "Wholesaler";
      case 'retailer':
        return "Retailer";
      default:
        return "";
    }
  }
}
