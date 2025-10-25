// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './constant.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: Color(0xFF000000),
      fontFamily: kFont, //italion colony
      // fontFamily: 'Tenor Sans,sans-serif', // 9shines label
      // fontFamily: 'Avenir,sans-serif',
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      //inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      primaryColorLight: kPrimaryLightColor,
      popupMenuTheme: PopupMenuThemeData(surfaceTintColor: Colors.black));
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.white),
    gapPadding: 8,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.only(
        top: 35,
        left: 25,
        right: 25,
        bottom: 0), //EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.grey),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.black, //Color(0XFF1C1C4C),
    elevation: 0,
    // brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Avenir,sans-serif'),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
