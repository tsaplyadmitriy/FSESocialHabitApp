import 'package:flutter/material.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/constants.dart';

class TagsHorizontalScroll extends StatelessWidget {
  const TagsHorizontalScroll({
    Key key,
    @required this.list,
    this.tag,
  }) : super(key: key);

  final List<String> list;
  final bool tag;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: list.map((String string) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 5,
          ),
          child: Chip(
              elevation: 3,
              backgroundColor: tag
                  ? (darkModeOn ? Constants.dPillTag : Constants.kPillTag)
                  : (darkModeOn
                      ? Constants.dPillCategory
                      : Constants.kPillCategory),
              label: Text(string,
                  style: TextStyle(
                    color: Colors.black,
                  ))),
        );
      }).toList()),
    );
  }
}
