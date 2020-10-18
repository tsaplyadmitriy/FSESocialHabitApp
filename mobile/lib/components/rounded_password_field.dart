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
          hintStyle: Theme.of(context).textTheme.headline4,
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
