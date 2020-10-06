import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/login/login_screen.dart';
import 'package:social_habit_app/screens/signup/signup_screen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to Social Habit App! 🔥",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }),
                );
              },
              textColor: Colors.black,
              color: kPrimaryLightColor,
            ),
          ],
        ),
      ),
    );
  }
}
