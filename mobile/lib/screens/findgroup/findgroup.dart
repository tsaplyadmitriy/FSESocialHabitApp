import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/my_sliver.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/findgroup/group_card_page.dart';


class FindGroupScreen extends StatefulWidget {
  static bool doWeNeedToRefresh = true;
  FindGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  static FindGroupStateScreen findGroupState = null;
  @override
  FindGroupStateScreen createState() {
    return FindGroupStateScreen();
  }
}

List<GroupEntity> testList = [];
List<GroupEntity> groupList = [];


class FindGroupStateScreen extends State<FindGroupScreen> {
  @override
  void initState() {
    print("INIT");
    super.initState();
    print(FindGroupScreen.doWeNeedToRefresh);
    if (FindGroupScreen.doWeNeedToRefresh == true) {
      print("ch");
      refreshGroups();
    } else {
      FindGroupScreen.doWeNeedToRefresh = false;
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
                          groupList.map((GroupEntity group) {

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
