import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_habit_app/components/existing_account_check.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/rounded_password_field.dart';
import 'package:social_habit_app/screens/bottomnav/bottomnav.dart';
import 'package:social_habit_app/screens/login/components/background.dart';
import 'package:social_habit_app/screens/signup/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            hintText: "Password",
          ),
          RoundedButton(
            text: "LOGIN",
            textColor: Colors.white,
            press: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BottomNavigator()));
            },
          ),
          ExistingAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }),
              );
            },
          ),
        ],
      ),
    ));
  }
}
