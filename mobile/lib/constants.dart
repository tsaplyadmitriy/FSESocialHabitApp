import 'package:flutter/material.dart';


class constants {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static Color backgroundColor = Color.fromARGB(100, 235, 235, 235);
  static  LinearGradient gradient() {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [kPrimaryColor,kPrimaryLightColor],
        stops: [0.25, 1, 1]);
  }
}