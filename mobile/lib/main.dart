import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Habit App',
      //home: BottomNavigator(),
      home: WelcomeScreen(),
      theme: ThemeData(
        primaryColor:  constants.kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

