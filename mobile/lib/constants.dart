import 'package:flutter/material.dart';


class constants {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static Color backgroundColor = Color.fromARGB(100, 242, 242, 242);
  static LinearGradient gradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color.fromARGB(255, 111, 53, 165), Color.fromARGB(255,161, 114, 204), Color.fromARGB(255, 241, 230, 255)],
        stops: [0.25, 1, 1]);
  }
}