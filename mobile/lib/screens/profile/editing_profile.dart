import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/image_picker.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/profile/profile.dart';

class ProfileEditing extends StatefulWidget {
  ProfileEditing({Key key}) : super(key: key);

  @override
  _ProfileEditing createState() => _ProfileEditing();
}

class _ProfileEditing extends State<ProfileEditing> {
  // TODO: integrate this with API so the tags and image are being passed here
  ProfileData profile =
      new ProfileData.withtags("", "", "", ["item1", "item2"]);
  File _image;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // h and w of
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              profile = null;

              Navigator.pop(context, profile);
            },
          ),
          title: Text('Edit profile'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImagePicker(
                      //TODO pass image here
                      initialImage: null,
                      imageCallback: (image) {
                        print("reached callback");
                        if (image != null) _image = image;
                      },
                    ),
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
                      maxCharacters: 30,
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
                      maxCharacters: 300,
                      onChanged: (aboutMe) {
                        profile.aboutMe = aboutMe;
                      },
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: profile.tags.map((String tag) {
                          return Container(
                            margin: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Chip(
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              label: Text(
                                tag,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              //label: Text("test"),
                              onDeleted: () {
                                setState(() {
                                  profile.tags.remove(tag);
                                  print(profile.tags.length);
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
                                style: Theme.of(context).textTheme.bodyText1),
                            icon: Icon(
                              Icons.add_circle,
                              color: Theme.of(context).unselectedWidgetColor,
                            ),
                            onPressed: () async {
                              String newTag =
                                  await _newTag(context, darkModeOn);
                              print(newTag);
                              setState(() {
                                if (newTag != "" && newTag != null)
                                  profile.tags.add(newTag);
                              });
                            },
                          ),
                          // SizedBox(width: size.width * 0.05),
                          // OutlinedButton.icon(
                          //   style: TextButton.styleFrom(
                          //     shape: StadiumBorder(),
                          //   ),
                          //   label: Text("New avatar",
                          //       style: Theme.of(context).textTheme.bodyText1),
                          //   icon: Icon(
                          //     Icons.edit,
                          //     color: Theme.of(context).unselectedWidgetColor,
                          //   ),
                          //   onPressed: () async {},
                          // ),
                        ],
                      ),
                    ),
                  ]),
              ProfileEditingSaveButton(profile: profile),
            ],
          ),
        ));
  }
}

class ProfileEditingSaveButton extends StatelessWidget {
  const ProfileEditingSaveButton({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SmallButton(
        text: "Save",
        widthModifier: 0.6,
        press: () {
          print(profile.name);

          UserSession().getUserentity.name = profile.name;

          UserSession().getUserentity.tgAlias = profile.telegram;
          UserSession().getUserentity.tags = profile.tags;
          UserSession().getUserentity.description = profile.aboutMe;

          // TODO: integrate this with API
          // new avatar is in _image

          Navigator.pop(context, profile);
        },
      ),
    );
  }
}


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
