import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/findgroup/group_card_page.dart';
import 'package:social_habit_app/group.dart';

class FindGroupScreen extends StatefulWidget {
  FindGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FindGroupScreen createState() => _FindGroupScreen();
}

List<Group> testList = [];

class _FindGroupScreen extends State<FindGroupScreen> {
  @override
  Widget build(BuildContext context) {
    testList.clear();
    for (int i = 0; i < 10; i++) {
      testList.add(new Group(
          "Meme " + i.toString(),
          "Сижу значит в джунглях Вьетнама, и вдруг деревья начинают по вьетконговски разговаривать Сижу значит в джунглях Вьетнама, и вдруг деревья начинают по вьетконговски разговаривать Сижу значит в джунглях Вьетнама, и вдруг деревья начинают по вьетконговски разговаривать Сижу значит в джунглях Вьетнама, и вдруг деревья начинают по вьетконговски разговаривать Сижу значит в джунглях Вьетнама, и вдруг деревья начинают по вьетконговски разговаривать ",
          [
            "porn",
            "masturbation",
            "anime",
            "heroin",
            "videogames",
            "movie",
            "series"
          ],
          ["IT", "JS", "SU"],
          3,
          7));
    }
    return Container(
        color: constants.backgroundColor,
        // margin: EdgeInsets.only(bottom: 0, top: 0, right: 2, left: 2),
        child: SingleChildScrollView(
          child: Column(
              children: testList.map((Group group) {
            return Container(
                width: double.infinity,
                //height: 100,
                child: GroupCard(
                    group: group,
                    function: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext buildContext) =>
                              GroupCardDialog(group));
                    }));
          }).toList()),
        ));
  }
}

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
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: InkWell(
        onTap: function,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TagsHorizontalScroll(group: group),
            Row(children: [
              Container(
                width: size.width * 0.65,
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  // SizedBox(
                  //   height: size.height * 0.005,
                  // ),
                  Container(
                      alignment: Alignment.centerLeft,
                      //margin: EdgeInsets.only(left:5),
                      child: Text(
                        group.groupName,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
              ),
              Container(
                alignment: Alignment.centerRight,
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/grey.png",
                    width: size.width * 0.2,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
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

class AvatarRound extends StatelessWidget {
  const AvatarRound({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        "assets/images/avatar.jpg",
        width: size.width * 0.07,
        //alignment: Alignment.centerRight,
      ),
    );
  }
}
