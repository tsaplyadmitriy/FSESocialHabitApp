import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int exactLines;
  final ValueChanged<String> onChanged;
  final bool resizable;
  final double width;
  final double maxHeight;
  final int maxCharacters;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.resizable = false,
    this.exactLines = 1,
    this.width = 0.8,
    this.maxHeight = 0.1,
    this.maxCharacters = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen
    return Container(
      width: size.width * width,
      child: TextFieldContainer(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * maxHeight,
          ),
          child: TextField(
            textInputAction: TextInputAction.next,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxCharacters),
            ],
            maxLines: resizable ? null : exactLines,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.headline4,
              icon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
