import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';

class UserList extends StatelessWidget {
  UserList({
    Key key,
    @required this.group,
    this.copyTelegram,
  }) : super(key: key);

  final Group group;
  bool copyTelegram = false;

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
                  if (copyTelegram) {
                    Clipboard.setData(ClipboardData(text: user.tgAlias));
                    showSnackBar(context, user.name);
                  }
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.all(3),
                  child: Container(
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        AvatarRound(size: size),
                        SizedBox(width: 5),
                        //TODO: pass admin here so user know who to write
                        //user.admin? Text(user.name) : Text(user.name + " 👑"),
                        Text(user.name)
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
