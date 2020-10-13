import 'package:flutter/material.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/constants.dart';

class TagsHorizontalScroll extends StatelessWidget {
  const TagsHorizontalScroll({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<String> list;

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Theme.of(context).primaryColorLight,
              label: Text(string,
                  style: TextStyle(
                    color: Colors.black,
                  ))),
        );
      }).toList()),
    );
  }
}
