import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
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
          "Group " + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue interdum dolor, et ultricies urna ullamcorper eget. Morbi tempor, odio sit amet suscipit posuere, mi lacus condimentum nisl, vitae sagittis velit arcu eu nunc. Curabitur fringilla tortor ac eros iaculis placerat. Maecenas ultricies accumsan turpis, et cursus neque ullamcorper nec. Proin ut fringilla magna, eget sodales lacus. Donec massa erat, interdum vel ultrices ut, ullamcorper eget velit. Pellentesque tincidunt quam ut lorem laoreet, ac cursus mauris dignissim. Proin sit amet dignissim eros. Vestibulum ut ex sit amet arcu finibus posuere. Duis vestibulum dignissim mauris, convallis faucibus metus feugiat et. Sed venenatis mauris id nibh mattis imperdiet. Curabitur posuere imperdiet tempus. Donec pretium ipsum nisi.",
          [
            "smoking",
            "alcohol",
            "junk food",
          ],
          ["IT", "JS", "SU"],
          3,
          7));
    }
    return Container(
        color: Constants.backgroundColor,
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
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TagsHorizontalScroll(group: group),
            Row(children: [
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          "assets/images/inno_campus.png",
          width: size.width * 0.2,
          alignment: Alignment.centerRight,
        ),
      ),
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
          "assets/images/avatar.png",
          width: size.width * 0.07,
          //alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}
