import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/my_sliver.dart';
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

    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

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
         margin: EdgeInsets.only(bottom: 0, top: 0, right: 0, left: 0),

            child: groupList.length>0 ?  CustomScrollView(
          slivers: [
          MySliverAppBar(
          darkModeOn : darkModeOn,
          text: "My groups",
          imagePath: "assets/images/inno_campus.png",
        ),
            SliverList(
                delegate: SliverChildListDelegate(





           groupList.map((GroupEntity groupEnt) {
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
      }).toList())

    )]):Container(child:Center(child: Text("Loading...",textAlign: TextAlign.center,)))

        ));


  }
}
