import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonHelper {
  static String formateDate(date) {
    final DateTime now = date;
    final DateFormat formatter = DateFormat('dd MMM, yyyy');
    final String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    return formatted;
  }

  static String currencySymbol() {
    return '\u{20B9}';
  }

  static String convetToDate(date) {
    int timestamp = int.parse(date);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatLongDate(String isoDate) {
    DateTime date = DateTime.parse(isoDate);
    return DateFormat("MMMM d, yyyy").format(date);
  }

  static String converToDateByType(date) {
    if (date != null) {
      var timestamp = int.tryParse(date);
      if (timestamp != null) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
        return formattedDate;
      } else {
        DateTime dateTime = DateTime.parse(date);
        return DateFormat("dd-MM-yyyy").format(dateTime);
      }
    } else {
      return '';
    }
  }

  static showSnackBarAddToBag(msg) {
    Get.closeAllSnackbars();
    Get.snackbar("", msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        // duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        // padding: EdgeInsets.all(kDefaultPadding / 2),
        // margin: EdgeInsets.all(0)
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
