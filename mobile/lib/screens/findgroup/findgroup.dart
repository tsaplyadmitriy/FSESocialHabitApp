import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/my_sliver.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/findgroup/group_card_page.dart';
import 'package:social_habit_app/group.dart';

class FindGroupScreen extends StatefulWidget {
  FindGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  static FindGroupStateScreen findGroupState = null;
  @override
  FindGroupStateScreen createState() {
    return FindGroupStateScreen();
  }
}

List<Group> testList = [];
List<GroupEntity> groupList = [];
bool doWeNeedToRefresh = false;

class FindGroupStateScreen extends State<FindGroupScreen> {
  @override
  void initState() {
    print("INIT");
    super.initState();
    if (doWeNeedToRefresh == false) {
      refreshGroups();
    } else {
      doWeNeedToRefresh = false;
    }
  }

  refreshGroups() async {
    setState(() {});
    groupList =
        await APIRequests().getGroupList(UserSession().getUserentity.token);
    print("groupl" + groupList.toString());
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    setState(() {});
    testList.clear();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    for (int i = 0; i < 10; i++) {
      testList.add(new Group(
          "Group # " + i.toString(),
          "Description of this particular group, in this textfield some large text should be produced, but i don't know what to write, so I will just write some words that have no sense on general and in particular.",
          "telega",
          "smoking",
          ["IT", "hashtag", "not_a_hashtag"],
          [],
          3,
          7));
    }

    return Container(

        //color: Constants.backgroundColor,

        // margin: EdgeInsets.only(bottom: 0, top: 0, right: 2, left: 2),

        child: groupList.length > 0
            ? RefreshIndicator(
                onRefresh: () async {
                  await refreshGroups();
                },
                child: CustomScrollView(slivers: [
                  MySliverAppBar(
                    darkModeOn: darkModeOn,
                    text: "Find groups",
                    imagePath: "assets/images/group_pic.png",
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          groupList.map((GroupEntity groupEnt) {
                    Group group = new Group(
                        groupEnt.groupName,
                        groupEnt.groupDescription,
                        groupEnt.groupTgLink,
                        groupEnt.groupCategory,
                        List<String>.from(groupEnt.groupTags),
                        List<String>.from(groupEnt.members),
                        5,
                        groupEnt.membersLimit);
                    return Container(
                        padding: EdgeInsets.only(top: 5),
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
                  }).toList()))
                ]))
            : Container(
                child: Center(
                    child: Text(
                "Loading...",
                textAlign: TextAlign.center,
              ))));
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
      elevation: 3,
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
            TagsHorizontalScroll(list: [group.category]),
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
  AvatarRound({
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
