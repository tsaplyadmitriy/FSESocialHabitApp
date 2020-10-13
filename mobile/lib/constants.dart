import 'package:flutter/material.dart';

class Constants {
  static const kAccentColor = Color(0xFFe63946);
  static const kPrimaryColor = Color(0xFF1d3557);
  static const kPrimaryLightColor = Color(0xFFa8dadc);
  static const kSecondaryColor = Color(0xff457b9d);

  static Color backgroundColor = Color.fromARGB(100, 242, 242, 242);
  static LinearGradient gradient() {
    return LinearGradient(colors: [
      kSecondaryColor,
      kPrimaryColor,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }
}
