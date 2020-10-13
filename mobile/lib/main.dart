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
      home: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), child: WelcomeScreen()),

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
