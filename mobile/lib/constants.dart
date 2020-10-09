import 'package:flutter/material.dart';

class constants {
  static const kPrimaryColor = Color(0xFF5B9A86);
  static const kPrimaryLightColor = Color(0xFFA5CABE);
  static const kSecondaryColor = Color(0xff4a517d);
  static const anotherColor = Color(0xff1A535C);
  static Color backgroundColor = Color.fromARGB(100, 242, 242, 242);
  static LinearGradient gradient() {
    return LinearGradient(colors: [
      anotherColor,
      kSecondaryColor,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }
}
