import 'package:flutter/material.dart';
import 'package:social_habit_app/components/users_list.dart';
import 'package:social_habit_app/group.dart';

class NewUsers extends StatefulWidget {
  NewUsers({Key key, this.group}) : super(key: key);
  final Group group;

  @override
  _NewUsersState createState() => _NewUsersState(this.group);
}

class _NewUsersState extends State<NewUsers> {
  Group group;
  _NewUsersState(this.group) : super();

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
