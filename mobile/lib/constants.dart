import 'package:flutter/material.dart';

class constants {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static const kSecondaryColor = Color(0xff3d315b);
  static const anotherColor = Color(0xff3d315b);
  static Color backgroundColor = Color.fromARGB(100, 242, 242, 242);
  static LinearGradient gradient() {
    return LinearGradient(colors: [
      anotherColor,
      kSecondaryColor,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }
}
