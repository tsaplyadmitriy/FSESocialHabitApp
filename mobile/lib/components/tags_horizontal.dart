import 'package:flutter/material.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/constants.dart';

class TagsHorizontalScroll extends StatelessWidget {
  const TagsHorizontalScroll({
    Key key,
    @required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: group.tags.map((String string) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            decoration: BoxDecoration(
                gradient: constants.gradient(),
                borderRadius: BorderRadius.circular(8.0)),
            child: Card(
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  // decoration: BoxDecoration(gradient: constants.gradient()),
                  child: Text(
                    string,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                )));
      }).toList()),
    );
  }
}
