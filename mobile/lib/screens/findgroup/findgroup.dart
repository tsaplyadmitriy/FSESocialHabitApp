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
                    imagePath: darkModeOn
                        ? "assets/images/find_group1.png"
                        : "assets/images/find_group1_dark.png",
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
