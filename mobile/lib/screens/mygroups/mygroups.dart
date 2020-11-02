import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    testList.clear();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    for (int i = 0; i < 3; i++) {
      testList.add(new Group(
          "Group " + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue interdum dolor, et ultricies urna ullamcorper eget. Morbi tempor, odio sit amet suscipit posuere, mi lacus condimentum nisl, vitae sagittis velit arcu eu nunc. Curabitur fringilla tortor ac eros iaculis placerat. Maecenas ultricies accumsan turpis, et cursus neque ullamcorper nec. Proin ut fringilla magna, eget sodales lacus. Donec massa erat, interdum vel ultrices ut, ullamcorper eget velit. Pellentesque tincidunt quam ut lorem laoreet, ac cursus mauris dignissim. Proin sit amet dignissim eros. Vestibulum ut ex sit amet arcu finibus posuere. Duis vestibulum dignissim mauris, convallis faucibus metus feugiat et. Sed venenatis mauris id nibh mattis imperdiet. Curabitur posuere imperdiet tempus. Donec pretium ipsum nisi.",
          "telega",
          [
            "smoking",
            "alcohol",
            "junk food",
            "test",
            "test2",
            "junk food",
            "test",
            "test2"
          ],
          ["IT", "JS", "SU"],
          3,
          7));
    }
    return Container(

        // margin: EdgeInsets.only(bottom: 0, top: 0, right: 2, left: 2),
        child: CustomScrollView(
      slivers: [
        MySliverAppBar(
          darkModeOn: darkModeOn,
          text: "My groups",
          imagePath: "assets/images/inno_campus.png",
        ),
        SliverList(
          delegate: SliverChildListDelegate(testList.map((Group group) {
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
          }).toList()),
        )
      ],
    ));
  }
}
