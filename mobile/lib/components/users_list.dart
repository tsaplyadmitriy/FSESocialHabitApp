import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';

class UserList extends StatefulWidget {
  const UserList({
    Key key,
    @required this.group,
    @required this.mode,
    @required this.copyTelegram,
  }) : super(key: key);

  final Group group;
  final bool copyTelegram;
  final String mode;

  @override
  _UserListState createState() => _UserListState(this.group, this.mode);
}

class _UserListState extends State<UserList> {
  Group group;
  String mode;

  _UserListState(this.group, this.mode) : super();

  final List<UserEntity> users = [
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Dima Tsaplia",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login2",
        password: "password2",
        token: "token2",
        name: "Gleb Osotov",
        description: "Description2",
        tgAlias: "tg2",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Alexey Rakov",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Ethan Shaghaie",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Evgeny Panov",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Ivan Konyukhov",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
    new UserEntity(
        login: "login1",
        password: "password1",
        token: "token1",
        name: "Giancarlo Succi",
        description: "Description1",
        tgAlias: "tg1",
        age: "18",
        tags: [],
        userGroups: []),
  ];

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // h and w of
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text("Users:"),
            Column(
                children: users.map((UserEntity user) {
              return GestureDetector(
                onTap: () {
                  if (widget.copyTelegram) {
                    Clipboard.setData(ClipboardData(text: user.tgAlias));
                    showSnackBar(context, user.name);
                  }
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  margin: EdgeInsets.all(3),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AvatarRound(size: size),
                            SizedBox(width: 5),
                            //TODO: pass admin here so user know who to write
                            //user.admin? Text(user.name) : Text(user.name + " 👑"),
                            Text(user.name)
                          ],
                        ),
                        Row(children: [
                          Visibility(
                            visible: mode == "new",
                            child: IconButton(
                                icon: new Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  users.remove(user);
                                  //TODO: API here

                                  setState(() {});
                                }),
                          ),
                          Visibility(
                            visible: mode == "existing",
                            child: IconButton(
                                icon: new Icon(Icons.remove_circle_outline),
                                onPressed: () async {
                                  String deleted = await _editUser(
                                      context,
                                      darkModeOn,
                                      "Do you want to delete user " +
                                          user.name +
                                          "?");
                                  print(deleted);
                                  if (deleted == "true") {
                                    users.remove(user);
                                    //TODO: API here
                                    setState(() {});
                                  }
                                }),
                          ),
                          Visibility(
                            visible: mode == "new",
                            child: IconButton(
                                icon: new Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  users.remove(user);
                                  //TODO: API here
                                  setState(() {});
                                }),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
          ],
        ),
      ),
    );
  }
}

class AvatarRound extends StatelessWidget {
  AvatarRound({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300.0),
        child: Image.asset(
          "assets/images/female_avatar.png",
          width: size.width * 0.07,
          //alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String name) {
  name += "'s telegram was copied to your clipboard";
  final snackBar = SnackBar(
    content: Text(name),
    backgroundColor: Constants.kSecondaryColor,
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 2),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}

Future<String> _editUser(BuildContext context, bool dark, String text) async {
  String result = "";
  await showDialog<String>(
    context: context,
    child: new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[new Expanded(child: Text(text))],
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
              result = "false";
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
              result = "true";
              //print(editTag);
              Navigator.pop(context, "true");
            })
      ],
    ),
  );
  return result;
}
