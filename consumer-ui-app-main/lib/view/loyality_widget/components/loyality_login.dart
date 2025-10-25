// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyalityLogin extends StatelessWidget {
  final _controller = Get.find<LoyalityController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var loyality = _controller.loyality.value;
      return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (loyality.bannerImageUrl != null &&
                  loyality.bannerImageUrl!.isNotEmpty)
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: CachedNetworkImage(
                        imageUrl: loyality.bannerImageUrl.toString())),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Card(
                      color: Colors.white,
                      borderOnForeground: true,
                      surfaceTintColor: Colors.white,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(children: [
                            if (loyality.titleWithoutLogin != null &&
                                loyality.titleWithoutLogin!.isNotEmpty) ...[
                              Text(
                                loyality.titleWithoutLogin.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(height: 8)
                            ],
                            if (loyality.descriptionWithoutLogin != null &&
                                loyality
                                    .descriptionWithoutLogin!.isNotEmpty) ...[
                              Text(
                                loyality.descriptionWithoutLogin.toString(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16)
                            ],
                            if (loyality.callToActionSignUpText != null &&
                                loyality
                                    .callToActionSignUpText!.isNotEmpty) ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Color(int.parse(_controller
                                        .loyality.value.primaryColor!
                                        .replaceAll('#', '0xff')))),
                                onPressed: () {
                                  _controller.changeRoute('/register');
                                },
                                child: Text(
                                    loyality.callToActionSignUpText.toString(),
                                    style: TextStyle(
                                        color: Color(int.parse(_controller
                                            .loyality.value.textColor!
                                            .replaceAll('#', '0xff'))))),
                              ),
                              const SizedBox(height: 8)
                            ],
                            if (loyality.calltoActionSignInText != null &&
                                loyality
                                    .calltoActionSignInText!.isNotEmpty) ...[
                              Row(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Already have an account?"),
                                    GestureDetector(
                                        onTap: () {
                                          _controller
                                              .changeRoute('/loyalityReward');
                                          // _controller.changeRoute('/login');
                                        },
                                        child: Text(
                                            loyality.calltoActionSignInText
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline)))
                                  ])
                            ],
                          ])))),
              const SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    if (loyality.waysToEarnTitle != null &&
                        loyality.waysToEarnTitle!.isNotEmpty) ...[
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 205, 205, 205),
                                width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              loyality.waysToEarnTitle.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                            ),
                            onTap: () {
                              _controller.changeWidgetPage('ways-to-earn');
                            },
                          )),
                      const SizedBox(height: 10)
                    ],
                    if (loyality.waysToRedeemTitle != null &&
                        loyality.waysToRedeemTitle!.isNotEmpty) ...[
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 205, 205, 205),
                                width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              loyality.waysToRedeemTitle.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                            ),
                            onTap: () {
                              _controller.changeWidgetPage('ways-to-redeem');
                            },
                          )),
                      const SizedBox(height: 10)
                    ],
                    Card(
                        color: Colors.white,
                        borderOnForeground: true,
                        surfaceTintColor: Colors.white,
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(children: [
                              Icon(CupertinoIcons.gift, size: 35),
                              const SizedBox(height: 10),
                              if (loyality.logoutTitle != null &&
                                  loyality.logoutTitle!.isNotEmpty) ...[
                                Text(
                                  loyality.logoutTitle.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5)
                              ],
                              if (loyality.logoutDescription != null &&
                                  loyality.logoutDescription!.isNotEmpty) ...[
                                Text(
                                  loyality.logoutDescription.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16)
                              ],
                            ]))),
                    const SizedBox(
                      height: 20,
                    )
                  ]))
            ],
          )));
    });
  }
}
