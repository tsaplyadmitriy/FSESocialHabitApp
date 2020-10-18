import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';
import 'package:social_habit_app/screens/profile/profile.dart';

class CreateGroupScreen extends StatefulWidget {
  CreateGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateGroupScreen createState() => _CreateGroupScreen();
}

class _CreateGroupScreen extends State<CreateGroupScreen> {
  ProfileData profile =
      new ProfileData.withtags("", "", "", ["item1", "item2"]);
  double sliderParticipants = 5;
  Group newGroup = new Group("name", "description", "telega", ["tag1", "tag2"],
      ["pref1", "pref2"], 1, 7);
  @override
  Widget build(BuildContext context) {
    newGroup.tags = profile.tags;

    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // h and w of
    return Scaffold(
        //backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedInputField(
                              hintText: "Name of the group",
                              icon: Icons.star_rate,
                              width: 0.9,
                              onChanged: (name) {
                                newGroup.groupName = name;
                              },
                            ),
                            RoundedInputField(
                              hintText: "telegram chat",
                              icon: Icons.message,
                              width: 0.9,
                              maxCharacters: 30,
                              onChanged: (telegram) {
                                newGroup.telegramLink = telegram;
                              },
                            ),
                            RoundedInputField(
                              hintText: "Group description",
                              icon: Icons.description,
                              resizable: true,
                              exactLines: 10,
                              width: 0.9,
                              maxCharacters: 300,
                              onChanged: (description) {
                                newGroup.groupDescription = description;
                              },
                            ),
                            TextFieldContainer(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Container(
                                        width: size.width * 0.6,
                                        child: Slider(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          inactiveColor: Theme.of(context)
                                              .unselectedWidgetColor,
                                          divisions:
                                              newGroup.maxParticipants - 2,
                                          min: 2,
                                          max: newGroup.maxParticipants
                                              .toDouble(),
                                          onChanged: (double value) {
                                            setState(() {
                                              sliderParticipants = value;
                                              newGroup.participants =
                                                  sliderParticipants.toInt();
                                            });
                                          },
                                          value: sliderParticipants,
                                          label:
                                              "${sliderParticipants.toInt()}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Specify number of participants",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: newGroup.tags.map((String tag) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Chip(
                                      backgroundColor:
                                          Theme.of(context).primaryColorLight,
                                      label: Text(
                                        tag,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      //label: Text("test"),
                                      onDeleted: () {
                                        setState(() {
                                          newGroup.tags.remove(tag);
                                          print(newGroup.tags.length);
                                        });
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton.icon(
                                    style: TextButton.styleFrom(
                                      //backgroundColor: Constants.kPrimaryColor,
                                      shape: StadiumBorder(),
                                    ),
                                    label: Text("New tag",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
                                    ),
                                    onPressed: () async {
                                      String newTag =
                                          await _newTag(context, darkModeOn);
                                      print(newTag);
                                      setState(() {
                                        if (newTag != "" && newTag != null)
                                          newGroup.tags.add(newTag);
                                      });
                                    },
                                  ),
                                  SizedBox(width: size.width * 0.05),
                                  OutlinedButton.icon(
                                    style: TextButton.styleFrom(
                                      shape: StadiumBorder(),
                                    ),
                                    label: Text("Add avatar",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
                                    ),
                                    onPressed: () async {},
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            GroupCreationSaveButton(groupData: newGroup),
            SizedBox(height: size.height * 0.01),
          ],
        ));
  }
}

class GroupCreationSaveButton extends StatelessWidget {
  const GroupCreationSaveButton({
    Key key,
    @required this.groupData,
  }) : super(key: key);

  final Group groupData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      alignment: Alignment.bottomCenter,
      child: SmallButton(
        text: "Save",
        widthModifier: 0.94,
        press: () {
          // TODO: integrate this with API

          Navigator.pop(context, profile);
        },
      ),
    );
  }
}

/*
class ProfileEditingTextFields extends StatelessWidget {
  const ProfileEditingTextFields({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
            hintText: "Name",
            icon: Icons.person,
            width: 0.9,
            onChanged: (name) {
              profile.name = name;
            },
          ),
          RoundedInputField(
            hintText: "telegram",
            icon: Icons.message,
            width: 0.9,
            onChanged: (telegram) {
              profile.telegram = telegram;
            },
          ),
          RoundedInputField(
            hintText: "About me",
            icon: Icons.star,
            resizable: true,
            exactLines: 10,
            width: 0.9,
            onChanged: (aboutMe) {
              profile.aboutMe = aboutMe;
            },
          ),
        ]);
  }
}
*/
Future<String> _newTag(BuildContext context, bool dark) async {
  String editTag;
  await showDialog<String>(
    context: context,
    child: new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              onChanged: (newTag) {
                editTag = newTag;
                //print(newTag);
              },
              decoration: new InputDecoration(
                  labelText: 'Enter your interest', hintText: 'e.g. Running'),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new OutlinedButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: dark ? Colors.white : Colors.black),
            ),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        new OutlinedButton(
            child: Text(
              'Ok',
              style: TextStyle(color: dark ? Colors.white : Colors.black),
            ),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(
                width: 2,
                color: dark
                    ? Constants.kPrimaryLightColor
                    : Constants.kPrimaryColor,
              ),
            ),
            onPressed: () {
              //print(editTag);
              Navigator.pop(context, editTag);
            })
      ],
    ),
  );
  return editTag;
}
