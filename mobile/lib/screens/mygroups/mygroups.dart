import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/my_sliver.dart';
import 'package:social_habit_app/constants.dart';

import 'package:social_habit_app/screens/findgroup/group_card_page.dart';
import 'package:social_habit_app/screens/mygroups/my_group_page.dart';
import 'package:social_habit_app/screens/mygroups/user_list_holder.dart';

class MyGroupsScreen extends StatefulWidget {
  MyGroupsScreen({Key key, this.title}) : super(key: key);

  final List<String> list = List.generate(10, (index) => "Text $index");
  final String title;

  @override
  _MyGroupsScreen createState() => _MyGroupsScreen();
}

List<GroupEntity> testList = [];

class _MyGroupsScreen extends State<MyGroupsScreen> {
  List<GroupEntity> groupList = [];

  refreshGroups() async {
    setState(() {});
    groupList =
        await APIRequests().getUserGroups();
    UserSession().getUserentity.userGroups = groupList;
    if (mounted) {
      setState(() {});
    }
  }

  refreshGroupsFromList(List<GroupEntity> list) {
    setState(() {});
    groupList = list;
    print("groupl" + groupList.toString());
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    print("init");
    refreshGroups();
  }

  @override
  Widget build(BuildContext context) {
    testList.clear();

    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return RefreshIndicator(
        onRefresh: () async {
          await refreshGroups();
        },
        child: Container(
            height: double.infinity,
            margin: EdgeInsets.only(bottom: 0, top: 0, right: 0, left: 0),
            child: groupList.length > 0
                ? CustomScrollView(slivers: [
                    MySliverAppBar(
                      darkModeOn: darkModeOn,
                      text: "My groups",
                      imagePath: "assets/images/group_pic.png",
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(
                            groupList.map((GroupEntity group) {


                      //print("group"+group.toString());
                      return Container(
                          width: double.infinity,
                          //height: 100,
                          child: GroupCard(
                              group: group,
                              function: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      UserListHolder.pending = group.pendingUsers;
                                      UserListHolder.members = group.members;
                                      return MyGroupPage(group: group);
                                    },
                                  ),
                                );
                              }));
                    }).toList()))
                  ])
                : Container(
                    child: Center(
                        child: Text(
                    "No groups here",
                    textAlign: TextAlign.center,
                  )))));
  }
}
