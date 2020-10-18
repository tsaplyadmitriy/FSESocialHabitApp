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
        Text(
          login ? "Don't have an account? " : "Already have an account? ",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        GestureDetector(
          onTap: press,
          child: Text(login ? "Sign Up" : "Sign in",
              style: Theme.of(context).textTheme.bodyText2),
        )
      ],
    );
  }
}
