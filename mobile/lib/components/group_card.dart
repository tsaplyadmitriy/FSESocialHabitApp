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
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: InkWell(
        onTap: function,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            TagsHorizontalScroll(list: [group.category]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              GroupCardNameAndAvatars(size: size, group: group),
              GroupCardImage(size: size),
            ]),

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
        ),
      ),
    );
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
          radius: size.width * 0.08),
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
            // SizedBox(
            //   height: size.height * 0.005,
            // ),
            Container(
                alignment: Alignment.centerLeft,
                //margin: EdgeInsets.only(left:5),
                child: Text(
                  group.groupName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Row(children: [
              AvatarRound(size: size),
              AvatarRound(size: size),
              AvatarRound(size: size),
              AvatarRound(size: size),
              AvatarRound(size: size),
              AvatarRound(size: size),
              AvatarRound(size: size),
            ])
            // Text(
            //     "Free places: " +
            //         (group.maxParticipants - group.participants)
            //             .toString() +
            //         " / " +
            //         group.maxParticipants.toString(),
            //     style:
            //         TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
            // SizedBox(
            //   height: size.height * 0.005,
            // ),
          ]),
    );
  }
}

class AvatarRound extends StatelessWidget {
  const AvatarRound({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
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
