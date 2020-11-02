import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/screens/profile/editing_profile.dart';

class ProfileData {
  String name;
  String telegram;
  String aboutMe;
  List<String> tags;
  ProfileData(this.name, this.telegram, this.aboutMe);
  ProfileData.withtags(this.name, this.telegram, this.aboutMe, this.tags);
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

//List<Group> testList = [];
ProfileData profile = new ProfileData.withtags(
    "Pavel Durov",
    "@durov",
    "As I’m turning 36, some people ask how I manage to look younger than my age. I’ve asked the same question of many people who age well (from Jared Leto to a random fitness trainer who looks like 25 at 50). Here’s what all of these young-looking individuals do (and don’t):",
    ["tag1", "tag2"]);

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: Constants.gradient(),
              ),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,

                  crossAxisAlignment: WrapCrossAlignment.center,
                  //alignment: WrapAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                      radius: 50.0,
                    ),
                    SizedBox(height: size.height * 0.01),
                    ProfileNameTelegramCard(),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width,
                      child: Center(
                        child: TagsHorizontalScroll(
                          list: profile.tags,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "About me:",
                      style: Theme.of(context).textTheme.headline1.apply(
                            color: Theme.of(context).accentColor,
                          ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${profile.aboutMe}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SmallButton(
                text: "Edit",
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                press: () async {
                  await _editingResult(context);
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class ProfileNameTelegramCard extends StatelessWidget {
  const ProfileNameTelegramCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(children: [
          Text(
            "${profile.name}",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/telegram.svg",
                  height: 25,
                ),
                SizedBox(width: 5),
                Text(
                  "${profile.telegram}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ]),
        ]),
      ),
    );
  }
}

_editingResult(BuildContext context) async {
  ProfileData saved = profile;
  profile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfileEditing()),
  );

  if (profile == null) {
    profile = saved;
  } else {
    if (profile.name == "") {
      profile.name = saved.name;
      // print("backup1");
    }
    if (profile.telegram == "") {
      profile.telegram = saved.telegram;
      //  print("backup2");
    }
    if (profile.aboutMe == "") {
      profile.aboutMe = saved.aboutMe;
      // print("backup3");
    }
  }

  //  print(profile.name + " " + profile.telegram + " " + profile.aboutMe);
}
