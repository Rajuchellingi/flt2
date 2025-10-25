// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/image_placeholder.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTypeBody extends StatelessWidget {
  const UserTypeBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final RegistrationV1Controller _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(children: [
          const Text("User Type",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          for (var element in _controller.allForms.value)
            Stack(children: [
              GestureDetector(
                  onTap: () {
                    _controller.isError.value = false;
                    _controller.userType.value = element.userTypeId;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: _controller.userType.value == element.userTypeId
                            ? kPrimaryColor.withOpacity(0.3)
                            : null,
                        border: Border.all(
                            color:
                                _controller.userType.value == element.userTypeId
                                    ? kPrimaryColor
                                    : Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        if (element.userTypeBanner != null &&
                            element.userTypeBanner.imageName != null)
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: SizeConfig.screenWidth / 2.5,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "$rietailImageUrl${element.userTypeBanner.imageId}/${element.userTypeBanner.imageName}",
                                  placeholder: (context, url) =>
                                      ImagePlaceholder())),
                        Expanded(
                            child: Column(children: [
                          if (element.name != null)
                            Container(
                                child: Text(element.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600))),
                          if (element.description != null &&
                              element.description.isNotEmpty) ...[
                            const SizedBox(height: 5),
                            Container(
                                child: Text(element.description,
                                    textAlign: TextAlign.center))
                          ]
                        ]))
                      ],
                    ),
                  )),
              if (_controller.userType.value == element.userTypeId)
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 8,
                    child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(Icons.check_circle,
                                color: kPrimaryColor, size: 30))))
            ])
        ])));

    // return Center(
    //     child: Container(
    //         color: Colors.white,
    //         margin: const EdgeInsets.only(bottom: 30, top: 50),
    //         padding: const EdgeInsets.all(20),
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               const Text("User Type",
    //                   style: const TextStyle(
    //                       fontSize: 18, fontWeight: FontWeight.bold)),
    //               const SizedBox(height: 10),
    //               const Text(
    //                   "Please select your user type to proceed with the registration process.",
    //                   textAlign: TextAlign.center),
    //               const SizedBox(height: 20),
    //               SizedBox(
    //                 width: double.infinity, // Make it full width
    //                 child: DropdownButtonFormField<dynamic>(
    //                   decoration: InputDecoration(
    //                     errorText: _controller.isError.value == true
    //                         ? "Please select user type"
    //                         : null,
    //                     focusedBorder: const OutlineInputBorder(
    //                         borderSide: const BorderSide(color: Colors.black)),
    //                     border: const OutlineInputBorder(
    //                         borderSide: const BorderSide(color: Colors.black)),
    //                     contentPadding: const EdgeInsets.symmetric(
    //                         horizontal: 12, vertical: 8),
    //                   ),
    //                   value: _controller.userType.value.isNotEmpty
    //                       ? _controller.userType.value
    //                       : null,
    //                   hint: const Text('Select User Type'),
    //                   onChanged: (dynamic newValue) {
    //                     _controller.isError.value = false;
    //                     _controller.userType.value = newValue;
    //                   },
    //                   items: _controller.userTypeOptions.value
    //                       .map<DropdownMenuItem<dynamic>>((dynamic value) {
    //                     return DropdownMenuItem<dynamic>(
    //                       value: value,
    //                       child: Text(getUserType(value)),
    //                     );
    //                   }).toList(),
    //                 ),
    //               ),
    //               const SizedBox(height: 20),
    //               DefaultButton(
    //                 text: "Proceed",
    //                 press: () {
    //                   if (_controller.userType.value.isNotEmpty) {
    //                     _controller.getRegistrationFormByType();
    //                   } else {
    //                     _controller.isError.value = true;
    //                   }
    //                 },
    //               ),
    //             ])));
  }

  String getUserType(type) {
    if (type == 'individual-buyer')
      return "Individual Buyer";
    else if (type == 'distributor')
      return "Distributor";
    else if (type == 'wholesaler')
      return "Wholesaler";
    else if (type == 'retailer')
      return "Retailer";
    else
      return "";
  }
}
