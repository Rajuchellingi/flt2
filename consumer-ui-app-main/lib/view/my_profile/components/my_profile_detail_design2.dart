import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/login/components/design3/input_design3.dart';
import 'package:black_locust/view/my_profile/components/my_profile_update_popup.dart';
import 'package:flutter/material.dart';
import '../../../controller/profile_controller.dart';
import 'package:get/get.dart';

class MyProfileDetailDesign2 extends StatelessWidget {
  MyProfileDetailDesign2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ProfileController _controller;
  final updateController = Get.find<UpdateProfileController>();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Obx(() => _controller.isLoading.value
        ? const Center(
            child: const CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Personal Information",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor)),
                      GestureDetector(
                          onTap: () {
                            updateController.assignRegistrationForm(
                                _controller.userProfile.value, 'personal-info');
                            // updateController.setInitialValues(
                            //     _controller.userProfile.value, 'personal-info');
                            Get.bottomSheet(
                              Container(child: MyProfileUpdatePopup()),
                              enterBottomSheetDuration:
                                  const Duration(milliseconds: 200),
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ).then((value) {
                              _controller.getProfile(_controller.userId);
                            });
                          },
                          child: Text("Change",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor)))
                    ]),
                SizedBox(height: 20),
                for (var element in _controller.registerForm) ...[
                  InputDesign3(
                    textEditingController: getTextController(element),
                    labelText: element['label'].toString(),
                    inputType: InputType.text,
                    isReadOnly: true,
                    controller: _controller,
                  ),
                  const SizedBox(height: 20),
                ],
                // if (_controller.phoneNumber != null) ...[
                //   SizedBox(height: 25),
                //   InputDesign3(
                //     textEditingController:
                //         TextEditingController(text: _controller.phoneNumber),
                //     hintText: "Mobile Number",
                //     labelText: "Mobile Number",
                //     inputType: InputType.text,
                //     isReadOnly: true,
                //     controller: _controller,
                //   )
                // ],
                // if (_controller.userProfile.value.emailId != null) ...[
                //   SizedBox(height: 25),
                //   InputDesign3(
                //     textEditingController: TextEditingController(
                //         text: _controller.userProfile.value.emailId),
                //     hintText: "Email Id",
                //     labelText: "Email Id",
                //     inputType: InputType.text,
                //     isReadOnly: true,
                //     controller: _controller,
                //   )
                // ],
                if (_controller.isPrizma.value == false) ...[
                  const SizedBox(height: 40),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryTextColor)),
                        GestureDetector(
                            onTap: () {
                              updateController.setInitialValues(
                                  _controller.userProfile.value, 'password');
                              Get.bottomSheet(
                                Container(child: MyProfileUpdatePopup()),
                                enterBottomSheetDuration:
                                    const Duration(milliseconds: 200),
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                            child: Text("Change",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: brightness == Brightness.dark
                                        ? Colors.white
                                        : kPrimaryTextColor)))
                      ]),
                  const SizedBox(height: 20),
                  InputDesign3(
                    textEditingController:
                        TextEditingController(text: "**********"),
                    hintText: "Password",
                    labelText: "Password",
                    inputType: InputType.password,
                    isReadOnly: true,
                    controller: _controller,
                  )
                ]
              ],
            ),
          ));
  }

  getTextController(element) {
    print('element $element  ${_controller.textController}');
    var textEditingController = _controller.textController
        .firstWhere((textField) => textField[element['name']] != null);
    return textEditingController[element['name']];
  }

  Padding buildContent(String lable, String value) {
    final brightness = MediaQuery.of(Get.context!).platformBrightness;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lable,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              kDefaultHeight(kDefaultPadding / 3),
              Text(value,
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor)),
            ],
          )
        ],
      ),
    );
  }
}
