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
        brightness: Brightness.light,
        primaryColor: Constants.kPrimaryColor,
        accentColor: Constants.kAccentColor,
        primaryColorLight: Constants.kPrimaryLightColor,

        unselectedWidgetColor: Constants.kInactiveColor,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Constants.kPrimaryColor,
            fontSize: 15,
          ),
          headline3: TextStyle(
            color: Constants.kPrimaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Constants.kInactiveColor,
            fontSize: 15,
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),

        // scaffoldBackgroundColor: constants.backgroundColor,
      ),
      darkTheme: ThemeData(
        fontFamily: 'ProductSans',
        brightness: Brightness.dark,
        primaryColor: Constants.dPrimaryColor,
        accentColor: Constants.dAccentColor,
        primaryColorLight: Constants.dPrimaryLightColor,
        unselectedWidgetColor: Constants.dInactiveColor,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Constants.dPrimaryColor,
            fontSize: 15,
          ),
          headline3: TextStyle(
            color: Constants.dPrimaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Constants.dInactiveColor,
            fontSize: 15,
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        // scaffoldBackgroundColor: constants.backgroundColor,
      ),
    );
  }
}
