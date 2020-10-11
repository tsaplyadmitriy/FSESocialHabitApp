import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

List<Group> testList = [];

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    testList.clear();
    for (int i = 0; i < 10; i++) {
      testList.add(new Group(
          "Group " + i.toString(),
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue interdum dolor, et ultricies urna ullamcorper eget. Morbi tempor, odio sit amet suscipit posuere, mi lacus condimentum nisl, vitae sagittis velit arcu eu nunc. Curabitur fringilla tortor ac eros iaculis placerat. Maecenas ultricies accumsan turpis, et cursus neque ullamcorper nec. Proin ut fringilla magna, eget sodales lacus. Donec massa erat, interdum vel ultrices ut, ullamcorper eget velit. Pellentesque tincidunt quam ut lorem laoreet, ac cursus mauris dignissim. Proin sit amet dignissim eros. Vestibulum ut ex sit amet arcu finibus posuere. Duis vestibulum dignissim mauris, convallis faucibus metus feugiat et. Sed venenatis mauris id nibh mattis imperdiet. Curabitur posuere imperdiet tempus. Donec pretium ipsum nisi.",
          [
            "smoking",
            "alcohol",
            "junk food",
          ],
          ["IT", "JS", "SU"],
          3,
          7));
    }
    Size size = MediaQuery.of(context).size; // h and w of
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Constants.kPrimaryColor,
                  Constants.kSecondaryColor
                ])),
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
                  Card(
                    elevation: 10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(children: [
                        Text(
                          "Name Surname",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
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
                              Text("@durov"),
                            ]),
                      ]),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: Center(
                      child: TagsHorizontalScroll(
                        list: [
                          "test",
                          "test",
                          "test",
                          "test",
                          "test",
                          "test",
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "About me:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'My name is Alice and I am  a freelance mobile app developper.\n'
                    'if you need any mobile app for your company then contact me for more informations',
                    style: TextStyle(
                      fontSize: 22.0,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      //letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: RoundedButton(
              text: "Edit",
              color: Constants.kPrimaryColor,
              press: () {},
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
