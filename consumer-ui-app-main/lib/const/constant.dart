import '../const/size_config.dart';
import 'package:flutter/material.dart';

// 9 shines label
// const kPrimaryColor = Color(0xFF2F636B);
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A);
// const kSecondaryColor = Color(0xFFEDEDED);
// const kBackground = Color(0xFFFEED9E);
// const kPrimaryTextColor = Color(0xFF2F636B);

// 9 shines label
const kPrimaryColor = Color(0xFF2F636B);
const kPrimaryLightColor = Color(0xFF010167);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
);
const kTextColor = Color(0xFF0A0A0A);
const kSecondaryColor = Color(0xFFEDEDED);
const kBackground = Colors.white;
const kPrimaryTextColor = Color(0xFF2F636B);
const kFont = 'Tenor Sans,sans-serif';

//Italian Colony
// const kPrimaryColor = Colors.black; //Italian Colony
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0XFF1C1C4C);
// const kSecondaryColor = Colors.white;
// const kBackground = Color(0xFFEDEDED);
// const kFont = 'Crimson Text, Serif';
// const kPrimaryTextColor = Colors.black;

//Engyne
// const kPrimaryColor = Color(0xFFD4A73C); //engyne
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A); //theme 2
// const kSecondaryColor = Color(0xFF111111); //engnyne
// const kBackground = Color(0xFFEDEDED); //engyne
// const kPrimaryTextColor = Colors.black;

// Rietail
// const kPrimaryColor = Color(0xFF2F636B);
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A);
// const kSecondaryColor = Color(0xFFEDEDED);
// const kBackground = Color(0xFFEDEDED);
// const kPrimaryTextColor = Color(0xFF2F636B);

// Blank Store
// const kPrimaryColor = Color(0xFFFF6A3D);
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A);
// const kSecondaryColor = Color(0xFFEDEDED);
// const kBackground = Colors.white;
// const kPrimaryTextColor = Color(0xFFFF6A3D);

// Dilip
// const kPrimaryColor = Color(0xFFF59E0B);
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A);
// const kSecondaryColor = Color(0xFFEDEDED);
// const kBackground = Color(0xFFEDEDED);
// const kPrimaryTextColor = Color(0xFF2F636B);

//S&P
// const kPrimaryColor = Color(0xFF28AA52);
// const kPrimaryLightColor = Color(0xFF0D71AD);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kTextColor = Color(0xFF0A0A0A);
// const kSecondaryColor = Colors.white;
// const kBackground = Colors.white;
// const kPrimaryTextColor = Colors.black;

// const kPrimaryColor = Color(0XFF1C1C4C);
// const kPrimaryColor = Color(0xFFEE1551);
// const kPrimaryColor = Color(0xFFB09A79);
// const kPrimaryColor = Color(0xFF2F636B); //9 shine label
// const kPrimaryColor = Color(0xFF510499); //theme 4
// const kPrimaryColor = Color(0xFFDB3022);
// const kPrimaryLightColor = Color(0xFF010167);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF1C1C4C), Color(0xFF010167)],
// );
// const kSecondaryColor = Colors.white; //theme 1
// const kTextColor = Color(0XFF474951); //theme 1
// const kBackground = Color(0xFFF7F6F1); //theme 1
// const kTextColor = Color(0XFF1C1C4C); //Italian Colony
// const kTextColor = Color(0xFF0A0A0A); //theme 2
// const kTextColor = Colors.white;
// const kSecondaryColor = Colors.white; //Italian Colony
// const kSecondaryColor = Color(0xFF111111); //engnyne
// const kSecondaryColor = Color(0xFFEDEDED); //9 shine label
// const kBackground = Color(0xFFEDEDED); //Italian Colony
// const kBackground = Color(0xFFEDEDED); //engyne
// const kBackground = Colors.white; //theme 4
// const kBackground = Color(0xFFFEED9E); //9 shine label
// const kPrimaryTextColor = Color(0xFF2F636B); //9 shine label
// const kPrimaryTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);
const kDefaultPadding = 20.0;

SizedBox kDefaultHeight(double size) {
  return SizedBox(height: getProportionateScreenHeight(size));
}

SizedBox kDefaultWidth(double size) {
  return SizedBox(width: getProportionateScreenWidth(size));
}

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  color: kPrimaryTextColor,
  height: 1.5,
);

final headingBlackStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp mobileValidatorRegExp = RegExp(r'^[0-9]{10}$');
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please enter your name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String regexpNumberError = "Enter your 10-digit valid phone number";
const String kAddressNullError = "Please enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
