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
          "Group" + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ["smoking", "addiction"],
          ["IT", "swimming"],
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
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin:
                        EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child: InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext buildContext) =>
                                  GroupCardDialog(group));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 10, top: 7, right: 10, left: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      children: group.tags.map((String string) {
                                    return Container(
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            gradient: constants.gradient(),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Card(
                                            margin: EdgeInsets.only(
                                                bottom: 3,
                                                top: 3,
                                                right: 8,
                                                left: 8),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      //margin: EdgeInsets.only(left:5),
                                      child: Text(
                                    group.groupName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  Text(
                                      "Free places: " +
                                          (group.maxParticipants -
                                                  group.participants)
                                              .toString() +
                                          " / " +
                                          group.maxParticipants.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children:
                                        group.preferences.map((String pref) {
                                      return Text(
                                        "#" + pref + " ",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      );
                                    }).toList(),
                                  )
                                ])))));
          }).toList()),
        ));
  }
}
