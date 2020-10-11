import 'package:flutter/material.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: Constants.kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Constants.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
