import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/helper/dailog_helper.dart';
import 'package:black_locust/services/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      DailogHelper.showErrorDailog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DailogHelper.showErrorDailog(description: message);
    } else if (error is ApiNotRespondingException) {
      DailogHelper.showErrorDailog(
          description: 'Opps! It took longer response time');
    }
  }

  void showLoading(String message) {
    var brightness = Get.isDarkMode ? Brightness.dark : Brightness.light;
    Get.dialog(
      Dialog(
        surfaceTintColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: kPrimaryColor,
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Text(
                message,
                style: TextStyle(
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  void bottonSheet() {
    Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(kDefaultPadding),
              horizontal: getProportionateScreenWidth(kDefaultPadding / 2)),
          child: Container(
            height: getProportionateScreenHeight(400),
            child: Text(
              "Crop Recommondation",
              style: headingBlackStyle,
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }
}
