// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/custom_text_field.dart';
import 'package:black_locust/common_component/default_button.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/constant.dart';
import '../const/size_config.dart';
import '../common_component/circle_icon_button.dart';
import '../common_component/custom_drop_down_field.dart';

class DailogHelper {
  static void showErrorDailog(
      {String title = 'Error', String description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                style: TextStyle(fontSize: getProportionateScreenWidth(14)),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                  },
                  child: Text("Ok"))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showVerifiedDailog(
      {String title = 'Info',
      String description = '',
      String btnText = 'Ok',
      GestureTapCallback? onPressed}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              ),
              kDefaultHeight(kDefaultPadding / 2),
              Icon(
                Icons.verified,
                color: Colors.green,
                size: 60,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                ),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(onPressed: onPressed, child: Text(btnText))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showInfoDailog(
      {String title = 'Info',
      String description = '',
      bool showClose = false,
      String btnText = 'Ok',
      GestureTapCallback? onPressed}) {
    final brightness = Theme.of(Get.context!).brightness;

    Get.dialog(
      Dialog(
        backgroundColor:
            brightness == Brightness.dark ? Colors.black : Colors.white,
        surfaceTintColor:
            brightness == Brightness.dark ? Colors.black : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showClose)
                Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close, size: 20),
                    )),
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: getProportionateScreenWidth(14),
                ),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor)),
                  child: Text(btnText,
                      style: TextStyle(
                        color: kSecondaryColor,
                      )))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showMultiInfoDailog(
      {String title = 'Info',
      List<String>? description,
      GestureTapCallback? onPressed}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              ),
              Column(
                  children: List.generate(description!.length,
                      (index) => Text(description[index]))),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(onPressed: onPressed, child: Text("Ok"))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showContactDailog(
      {String title = 'Info',
      String email = '',
      String phone = '',
      GestureTapCallback? onPressed}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              ),
              kDefaultHeight(kDefaultPadding / 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.email_outlined,
                        onPressed: () {},
                        height: 30,
                        color: kPrimaryColor,
                        width: 30,
                      ),
                      kDefaultWidth(kDefaultPadding / 2),
                      Text(email)
                    ],
                  ),
                  kDefaultHeight(kDefaultPadding / 2),
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.phone,
                        onPressed: () {},
                        color: kPrimaryColor,
                        height: 30,
                        width: 30,
                      ),
                      kDefaultWidth(kDefaultPadding / 2),
                      Text(phone)
                    ],
                  ),
                ],
              ),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              Center(
                  child:
                      ElevatedButton(onPressed: onPressed, child: Text("Ok")))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showConfirmDailog(
      String title, String middleText, GestureTapCallback? onCofirm) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        middleText: middleText,
        textConfirm: 'Ok',
        confirmTextColor: Colors.white,
        cancelTextColor: kPrimaryColor,
        buttonColor: kPrimaryColor,
        textCancel: 'Cancel',
        titleStyle: TextStyle(fontSize: 16),
        middleTextStyle: TextStyle(fontSize: 14),
        onConfirm: onCofirm);
  }

  static void showBootomSheet(
      String title, dynamic list, GestureTapCallback? onTap(value)) {
    Get.bottomSheet(
      Container(
        height: 400,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.w500),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: onTap('value'),
                    title: Text(list[index]['item']),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  static void showProductDeliveryBootomSheet(
      String title, dynamic list, double height) {
    Get.bottomSheet(
      Container(
        height: height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.w500),
            ),
            Divider(),
            Column(
              children: List.generate(
                list.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\u2022 ", style: TextStyle(fontSize: 14)),
                        Flexible(
                          child: Text(
                            list[index],
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  static void orderCancelBootomSheet(
      String title, dynamic cancelReasonlist, dynamic _controller) {
    Get.bottomSheet(
      Obx(
        () => SingleChildScrollView(
          child: Container(
            height: _controller.enableContentText.value
                ? SizeConfig.screenHeight * 0.42
                : SizeConfig.screenHeight * 0.34,
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    child: Text(
                      title,
                      style: headingStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  kDefaultHeight(kDefaultPadding),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    child: CustomDropdownField(
                        dropdownList: cancelReasonlist,
                        lableText: 'Cancel Reason',
                        selectedType: _controller.selectedCancelReason.value,
                        controller: _controller),
                  ),
                  kDefaultHeight(kDefaultPadding * 2),
                  Obx(() => _controller.enableContentText.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 2),
                          child: CustomTextFiled(
                            textEditingController:
                                _controller.orderCancelReasonController,
                            hintText: "",
                            labelText: "Enter Content",
                            errorMsg: 'Enter Content',
                            inputType: InputType.multiLine,
                            isPhoneCode: false,
                            isReadOnly: false,
                            isLightTheam: true,
                            controller: _controller,
                          ),
                        )
                      : Container()),
                  kDefaultHeight(kDefaultPadding * 2),
                  DefaultButton(
                    press: () {
                      _controller.orderCancelSubmit();
                    },
                    isDisable: _controller.disableCancelSubmitBtn.value,
                    isBorder: false,
                    text: 'Submit',
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  static void checkoutPaymentBottomSheet(String title,
      dynamic paymentOptionlist, dynamic _controller, BuildContext context) {
    int value = 0;
    Get.bottomSheet(
      Obx(
        () => SingleChildScrollView(
          child: Container(
              height: 400,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: paymentOptionlist.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: index,
                      groupValue: value,
                      onChanged: (ind) {},
                      title: Text("Number $index"),
                    );
                  })),
        ),
      ),
    );
  }
}
