import 'package:flutter/material.dart';

class Constants {
  //light
  static const kAccentColor = Color(0xFF1d2557);
  static const kPrimaryColor = Color(0xFF1d3557);
  static const kPrimaryLightColor = Color(0xFFa8dadc);
  static const kSecondaryColor = Color(0xff457b9d);
  static const kInactiveColor = Color(0xFF6c757d);
  static const kPillCategory = Color(0xff98A6BA);
  static const kPillTag = Color(0xFFA2C3F5);

//dark
  static const dAccentColor = Color(0xFFEB5C68);
  static const dPrimaryColor = Color(0xFF1d3557);
  static const dPrimaryLightColor = Color(0xFF71A2C1);
  static const dSecondaryColor = Color(0xff71A2C1);
  static const dInactiveColor = Color(0xFF6c757d);
  static const dPillCategory = Color(0xff7591BB);
  static const dPillTag = Color(0xFF98BFF5);

  static String loginDone = "/login_done";
  static String leaveWelcome = "/leave_welcome";
  static String logIn = "/log_in";
  static String signUp = "/sign_up";

  static const apiLink = 'https://fsesocialhabitapp.herokuapp.com';

  static Color backgroundColor = Color.fromARGB(100, 242, 242, 242);

  static LinearGradient gradient() {
    return LinearGradient(colors: [
      kSecondaryColor,
      kPrimaryColor,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }
}
