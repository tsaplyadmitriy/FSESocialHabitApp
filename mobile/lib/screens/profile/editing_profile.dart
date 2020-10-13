import 'package:flutter/material.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/profile/profile.dart';

class ProfileEditing extends StatefulWidget {
  ProfileEditing({Key key}) : super(key: key);

  @override
  _ProfileEditing createState() => _ProfileEditing();
}

class _ProfileEditing extends State<ProfileEditing> {
  // TODO: integrate this with API so the tags are being passed here
  ProfileData profile =
      new ProfileData.withtags("", "", "", ["item1", "item2"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                      child: Row(
                        children: [
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
                                        Constants.kPrimaryLightColor,
                                    label: Text(tag),
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
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Colors.black,
                            onPressed: () async {
                              String newTag = await _newTag(context);
                              print(newTag);
                              setState(() {
                                if (newTag != "" && newTag != null)
                                  profile.tags.add(newTag);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ]),
              Container(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                  text: "Save",
                  press: () {
                    print(profile.name);
                    // TODO: integrate this with API

                    Navigator.pop(context, profile);
                  },
                ),
              ),
            ],
          ),
        ));
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
Future<String> _newTag(BuildContext context) async {
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
        new FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            }),
        new FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              //print(editTag);
              Navigator.pop(context, editTag);
            })
      ],
    ),
  );
  return editTag;
}
