import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';

class ExistingAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const ExistingAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(login ? "Don't have an account? " : "Already have an account? ",
            style: TextStyle(
              color: Constants.kPrimaryColor,
            )),
        GestureDetector(
          onTap: press,
          child: Text(login ? "Sign Up" : "Sign in",
              style: TextStyle(
                color: Constants.kPrimaryColor,
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    );
  }
}
