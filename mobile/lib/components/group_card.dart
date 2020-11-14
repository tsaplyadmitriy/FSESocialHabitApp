import 'package:flutter/material.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/group.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  final Function function;
  const GroupCard({
    Key key,
    this.group,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of s    return Card(

    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 17),
        child: InkWell(
          onTap: function,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TagsHorizontalScroll(
                    list: [group.category],
                    tag: false,
                  ),
                  GroupCardNameAndAvatars(size: size, group: group),

                  /*  Row(
                  children: group.preferences.map((String pref) {
                    return Text(
                      "#" + pref + " ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    );
                  }).toList(),
            ) */
                ]),
                GroupCardImage(size: size),
              ],
            ),
          ),
        ));
  }
}

class GroupCardImage extends StatelessWidget {
  const GroupCardImage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: size.width * 0.2,
      child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/inno_campus.png"),
          radius: size.width * 0.1),
    );
  }
}

class GroupCardNameAndAvatars extends StatelessWidget {
  const GroupCardNameAndAvatars({
    Key key,
    @required this.size,
    @required this.group,
  }) : super(key: key);

  final Size size;
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  group.groupName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Row(children: [
              UserAvatar(size: size),
              UserAvatar(size: size),
              UserAvatar(size: size),
              UserAvatar(size: size),
              UserAvatar(size: size),
              UserAvatar(size: size),
              UserAvatar(size: size),
            ])
          ]),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300.0),
        child: Image.asset(
          "assets/images/female_avatar.png",
          width: size.width * 0.07,
          //alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}
