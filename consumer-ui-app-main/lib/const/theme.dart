// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './constant.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: kBackground,
      fontFamily: kFont, //italion colony
      // fontFamily: 'Tenor Sans,sans-serif', // 9shines label
      // fontFamily: 'Avenir,sans-serif',
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      textButtonTheme: textButtonTheme(),
      dialogTheme: dialogTheme(),
      //inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      primaryColorLight: kPrimaryLightColor,
      popupMenuTheme: PopupMenuThemeData(surfaceTintColor: Colors.white));
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kTextColor),
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
    bodyLarge: TextStyle(color: kTextColor),
    bodyMedium: TextStyle(color: kTextColor),
    titleMedium: TextStyle(color: Colors.black54),
  );
}

DialogThemeData dialogTheme() {
  return DialogThemeData(
    backgroundColor: Colors.white, // Dialog background color
    surfaceTintColor: Colors.transparent, // Removes Material 3 tint
  );
}

TextButtonThemeData textButtonTheme() {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: const TextStyle(color: Colors.black),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white, //Color(0XFF1C1C4C),
    elevation: 0,
    // brightness: Brightness.light,
    iconTheme: IconThemeData(color: kTextColor),
    titleTextStyle: TextStyle(
        color: kTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Avenir,sans-serif'),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
