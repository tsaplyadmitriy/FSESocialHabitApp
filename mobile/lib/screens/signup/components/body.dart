import 'package:flutter/material.dart';
import 'package:social_habit_app/screens/signup/components/background.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: child,
    );
  }
}
