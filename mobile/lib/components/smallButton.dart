import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double widthModifier;
  const SmallButton({
    Key key,
    this.text,
    this.press,
    this.color = Constants.kPrimaryColor,
    this.textColor = Colors.white,
    this.widthModifier = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: textColor,
        shape: StadiumBorder(),
        minimumSize: Size(size.width * widthModifier, 50),
      ),
      child: Text(text),
      onPressed: press,
    );
  }
}
