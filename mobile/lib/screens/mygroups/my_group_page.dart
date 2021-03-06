import 'dart:io';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/components/group_card.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/components/users_list.dart';

import 'package:social_habit_app/screens/creategroup/creategroup.dart';
import 'package:social_habit_app/screens/mygroups/challenge_card.dart';
import 'package:social_habit_app/screens/mygroups/new_challenge.dart';
import 'package:social_habit_app/screens/mygroups/new_users.dart';
import 'package:social_habit_app/screens/mygroups/user_list_holder.dart';

import 'list.dart';

class Challenge {
  int goal;
  String name;
  int participants;
  List<int> currentProgress;
  Challenge(this.goal, this.name, this.participants) {
    currentProgress = [];
    for (var i = 0; i < participants; i++) {
      currentProgress.add(0);
    }
  }
}

class MyGroupPage extends StatefulWidget {
  final GroupEntity group;

  const MyGroupPage({Key key, this.group}) : super(key: key);
  @override
  _MyGroupPageState createState() => _MyGroupPageState(this.group);
}

List<Challenge> challengeList = [];

class _MyGroupPageState extends State<MyGroupPage> {
  GroupEntity group;
  bool admin = true;

  Challenge demoChallenge = new Challenge(7, "Dont smoke for a week", 5);

  _MyGroupPageState(this.group) : super();
  @override
  Widget build(BuildContext context) {
    if (challengeList.length == 0) {
      challengeList.add(demoChallenge);
    }

    Size size = MediaQuery.of(context).size; // h and w of s    return Card(
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(group.groupName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              TagsHorizontalScroll(
                list: [group.groupCategory],
                tag: false,
              ),
              TagsHorizontalScroll(
                list: group.groupTags,
                tag: true,
              ),
              Visibility(
                visible: admin,
                child: Column(
                  children: [
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/male_avatar.png"),
                            radius: size.width * 0.15,
                          ),
                          Column(
                            children: [
                              SmallButton(
                                text: "Edit group",
                                press: () {
                                  // TODO when API is ready: Catch edits here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return CreateGroupScreen();
                                    }),
                                  );
                                },
                                widthModifier: 0.4,
                              ),
                              SizedBox(height: size.height * 0.01),
                              SmallButton(
                                text: "New challenge",
                                press: () async {
                                  await _getNewChallenge(context);
                                  setState(() {});
                                },
                                widthModifier: 0.4,
                              ),
                              SizedBox(height: size.height * 0.01),
                              SmallButton(
                                text: "New users",
                                press: () async {
                                  //TODO: refresh current users after popping
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return NewUsers(
                                        group: group,
                                      );
                                    }),
                                  );
                                },
                                widthModifier: 0.4,
                              ),
                            ],
                          )
                        ]),
                  ],
                ),
              ),
              Divider(),
              Text("Challenges", style: Theme.of(context).textTheme.headline1),
              SizedBox(height: size.height * 0.01),
              Column(
                  children: challengeList.map((Challenge challenge) {
                return ChallengeCard(demoChallenge: challenge, size: size);
              }).toList()),
              SizedBox(height: size.height * 0.1),
              Text("Users", style: Theme.of(context).textTheme.headline1),
              UserList(
                mode: "view",
                group: group,
                copyTelegram: true,
                users: UserListHolder.members,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_getNewChallenge(BuildContext context) async {
  Challenge newChallenge;
  newChallenge = await Navigator.push(
    context,
    //TODO insert groups participants here with API
    MaterialPageRoute(
        builder: (context) => NewChallengeScreen(
              participants: 5,
            )),
  );
  if (newChallenge != null) challengeList.add(newChallenge);
}
