import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_habit_app/components/existing_account_check.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/rounded_password_field.dart';
import 'package:social_habit_app/screens/login/login_screen.dart';
import 'package:social_habit_app/screens/signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen
    return Scaffold(
      body: Body(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Telegram",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                hintText: "Password",
              ),
              RoundedButton(
                text: "SIGN UP",
                press: () {},
              ),
              SizedBox(height: size.height * 0.03),
              ExistingAccountCheck(
                login: false,
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
            ],
          ),
        ),
      ),
    );
  }
}
