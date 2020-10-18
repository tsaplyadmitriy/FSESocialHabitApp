import 'package:flutter/material.dart';
import 'package:social_habit_app/screens/bottomnav/bottomnav.dart';
import 'package:social_habit_app/screens/login/login_screen.dart';
import 'package:social_habit_app/screens/signup/signup_screen.dart';
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
      routes: {
        "/login_done": (_) => new BottomNavigator(),
        "/leave_welcome": (_) => new SignUpScreen(),
        "/log_in": (_) => new LoginScreen(),
        "/sign_up": (_) => new SignUpScreen(),
      },
      theme: ThemeData(
        fontFamily: 'ProductSans',

        primaryColor: Constants.kPrimaryColor,
        // scaffoldBackgroundColor: constants.backgroundColor,
      ),
    );
  }
}
