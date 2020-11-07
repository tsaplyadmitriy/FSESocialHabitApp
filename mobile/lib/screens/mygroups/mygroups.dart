import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/screens/findgroup/group_card_page.dart';
import 'package:social_habit_app/screens/mygroups/my_group_page.dart';

class MyGroupsScreen extends StatefulWidget {
  MyGroupsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyGroupsScreen createState() => _MyGroupsScreen();
}

List<Group> testList = [];

class _MyGroupsScreen extends State<MyGroupsScreen> {
  RefreshController controller = RefreshController();

  List<GroupEntity> groupList = [];

  refreshGroups() async{
    setState(() {});
    groupList = await APIRequests().getGroupList(UserSession().getUserentity.token);
    print("groupl"+groupList.toString());
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {

    super.initState();
    refreshGroups();
  }

  @override
  Widget build(BuildContext context) {
    testList.clear();
    for (int i = 0; i < 6; i++) {
      testList.add(new Group(
          "Group " + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue interdum dolor, et ultricies urna ullamcorper eget. Morbi tempor, odio sit amet suscipit posuere, mi lacus condimentum nisl, vitae sagittis velit arcu eu nunc. Curabitur fringilla tortor ac eros iaculis placerat. Maecenas ultricies accumsan turpis, et cursus neque ullamcorper nec. Proin ut fringilla magna, eget sodales lacus. Donec massa erat, interdum vel ultrices ut, ullamcorper eget velit. Pellentesque tincidunt quam ut lorem laoreet, ac cursus mauris dignissim. Proin sit amet dignissim eros. Vestibulum ut ex sit amet arcu finibus posuere. Duis vestibulum dignissim mauris, convallis faucibus metus feugiat et. Sed venenatis mauris id nibh mattis imperdiet. Curabitur posuere imperdiet tempus. Donec pretium ipsum nisi.",
          "telega",
          "smoking",
          ["IT", "JS", "SU"],
          [],
          3,
          7));
    }
    return SmartRefresher(

        enablePullUp: true,
        controller: controller,
        enablePullDown: true,
        onRefresh: () async {
          print("ref");
          await refreshGroups();
          if (mounted) {
            controller.refreshCompleted();
          }
        },
        onLoading: () async {
          setState(() {

          });
          controller.loadComplete();
        },
        child: Container(
        height: double.infinity,
         margin: EdgeInsets.only(bottom: 0, top: 5, right: 0, left: 0),
        child: SingleChildScrollView(


      child:groupList.length>0 ?   Column(


          children: groupList.map((GroupEntity groupEnt) {
            Group group = new Group(groupEnt.groupName, groupEnt.groupDescription, groupEnt.groupTgLink,
                groupEnt.groupCategory, List<String>.from(groupEnt.groupTags), List<String>.from(groupEnt.members),
                5, groupEnt.membersLimit);
            print("group"+group.toString());
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
                        return MyGroupPage(group: group);
                      },
                    ),
                  );
                }));
      }).toList()):
          Container(child:Center(child: Text("Loading...",textAlign: TextAlign.center,)))
          ,
    )));
  }
}
