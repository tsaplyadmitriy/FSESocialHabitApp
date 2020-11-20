import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/components/users_list.dart';








class NewUsers extends StatefulWidget {
  NewUsers({Key key, this.group}) : super(key: key);
  final GroupEntity group;

  @override
  _NewUsersState createState() => _NewUsersState(this.group);
}

class _NewUsersState extends State<NewUsers> {
  GroupEntity group;
  _NewUsersState(this.group) : super();


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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit users'),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text("New applications:"),
          UserList(
            mode: "new",
            group: group,
            copyTelegram: false,

          ),
          Text("Current users:"),
          UserList(
            mode: "existing",
            group: group,
            copyTelegram: false,

          ),
        ]),
      )),
    );
  }
}
