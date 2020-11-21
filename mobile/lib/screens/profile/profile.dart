import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:flutter/services.dart';

import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/components/users_list.dart';
import 'package:social_habit_app/constants.dart';

import 'package:social_habit_app/screens/profile/editing_profile.dart';

import 'package:shake/shake.dart';

class ProfileDataKeeper {
  static ProfileData profile = new ProfileData.withtags(
      UserSession().getUserentity.name,
      UserSession().getUserentity.tgAlias,
      UserSession().getUserentity.login,
      List<String>.from(UserSession().getUserentity.tags));
}

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
bool easterEggShown = false;

class _ProfileScreen extends State<ProfileScreen> {
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      // Do stuff on phone shake
      //print("shake detected");
      if (!easterEggShown) {
        easterEggShown = true;
        showDialog(
            context: context,
            builder: (BuildContext buildContext) => EasterEggDialog());
      }
    });

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    print("tags:" + UserSession().getUserentity.tags.toString());
    Size size = MediaQuery.of(context).size; // h and w of
    return Scaffold(
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
                      backgroundImage:
                          AssetImage("assets/images/male_avatar.png"),
                      radius: 50.0,
                    ),
                    SizedBox(height: size.height * 0.01),
                    ProfileNameTelegramCard(),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width,
                      child: Center(
                        child: TagsHorizontalScroll(
                          list: List<String>.from(
                              UserSession().getUserentity.tags),
                          tag: true,
                        ),
                      ),
                    )
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
                      "${ProfileDataKeeper.profile.aboutMe}",
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
            "${ProfileDataKeeper.profile.name}",
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
                  "${ProfileDataKeeper.profile.telegram}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ]),
        ]),
      ),
    );
  }
}

_editingResult(BuildContext context) async {
  ProfileData saved = ProfileDataKeeper.profile;
  ProfileDataKeeper.profile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfileEditing()),
  );

  if (ProfileDataKeeper.profile == null) {
    ProfileDataKeeper.profile = saved;
  } else {
    if (ProfileDataKeeper.profile.name == "") {
      ProfileDataKeeper.profile.name = saved.name;
      // print("backup1");
    }
    if (ProfileDataKeeper.profile.telegram == "") {
      ProfileDataKeeper.profile.telegram = saved.telegram;
      //  print("backup2");
    }
    if (ProfileDataKeeper.profile.aboutMe == "") {
      ProfileDataKeeper.profile.aboutMe = saved.aboutMe;
      // print("backup3");
    }
  }

  //  print(profile.name + " " + profile.telegram + " " + profile.aboutMe);
}

class EasterEggDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    Size size = MediaQuery.of(context).size; // h and w of
    bool darkModeOn = brightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin:
            EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: 0),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
          color: darkModeOn ? Constants.dInactiveColor : Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeveloperCard(
                name: "Gleb Osotov",
                imagePath: "assets/easteregg/osotov.png",
                description: "Front-end",
                telegram: "@glebosotov",
              ),
              DeveloperCard(
                  name: "Dmitry Tsaplya",
                  imagePath: "assets/easteregg/tsaplya.png",
                  description: "Full-stack",
                  telegram: "@dimtsaplia"),
              DeveloperCard(
                  name: "Alexei Rakov",
                  imagePath: "assets/easteregg/rakov.png",
                  description: "Back-end",
                  telegram: "@AlexDest"),
              DeveloperCard(
                  name: "Ehsan Shagaei",
                  imagePath: "assets/easteregg/ehsan.png",
                  description: "@EhsanSH2754",
                  telegram: "@EhsanSH2754"),
              DeveloperCard(
                  name: "Evgeny Panov",
                  imagePath: "assets/easteregg/panov.png",
                  description: "Assets design",
                  telegram: "@Kayzera"),
              SmallButton(
                text: "Cool",
                press: () {
                  easterEggShown = false;
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String description;
  final String telegram;
  final String imagePath;
  const DeveloperCard({
    Key key,
    this.name,
    this.description,
    this.telegram,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      margin: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: telegram));
          Flushbar(
            message: "Developer's telegram was copied to your clipboard",
            duration: Duration(seconds: 3),
          )..show(context);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.headline1),
                Text(description),
                Text(telegram),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
