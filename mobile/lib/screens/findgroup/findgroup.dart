import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/my_sliver.dart';
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    for (int i = 0; i < 10; i++) {
      testList.add(new Group(
          "Group " + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue interdum dolor, et ultricies urna ullamcorper eget. Morbi tempor, odio sit amet suscipit posuere, mi lacus condimentum nisl, vitae sagittis velit arcu eu nunc. Curabitur fringilla tortor ac eros iaculis placerat. Maecenas ultricies accumsan turpis, et cursus neque ullamcorper nec. Proin ut fringilla magna, eget sodales lacus. Donec massa erat, interdum vel ultrices ut, ullamcorper eget velit. Pellentesque tincidunt quam ut lorem laoreet, ac cursus mauris dignissim. Proin sit amet dignissim eros. Vestibulum ut ex sit amet arcu finibus posuere. Duis vestibulum dignissim mauris, convallis faucibus metus feugiat et. Sed venenatis mauris id nibh mattis imperdiet. Curabitur posuere imperdiet tempus. Donec pretium ipsum nisi.",
          "telega",
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
        //color: Constants.backgroundColor,
        // margin: EdgeInsets.only(bottom: 0, top: 0, right: 2, left: 2),
        child: CustomScrollView(
      slivers: [
        MySliverAppBar(
          darkModeOn: darkModeOn,
          text: "Find groups",
          imagePath: "assets/images/group_pic.png",
        ),
        SliverList(
          delegate: SliverChildListDelegate(testList.map((Group group) {
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
        )
      ],
    ));
  }
}
