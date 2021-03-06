import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/mygroups/user_list_holder.dart';


class UserList extends StatefulWidget {
  const UserList({
    Key key,
    @required this.group,
    @required this.mode,
    @required this.copyTelegram,
    @required  this.users
  }) : super(key: key);

  final GroupEntity group;
  final bool copyTelegram;
  final String mode;
  final List<UserEntity>users;

  @override
  _UserListState createState() => _UserListState(this.group, this.mode,this.users);
}

class _UserListState extends State<UserList> {
  GroupEntity group;
  String mode;
  List<UserEntity> users;

  _UserListState(this.group, this.mode,this.users) : super();



  @override
  Widget build(BuildContext context) {
    if(mode=="new"){
      users = UserListHolder.pending;
    }
    if(mode=="existing"||mode=="view"){

      users = UserListHolder.members;
    }
    print("Namebuild:"+group.members.map((e) => e.login).toList().toString()+"/"
        +group.pendingUsers.map((e) => e.login).toList().toString());


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

                  print("name:"+user.name+" "+UserSession().getUserentity.name);
              return GestureDetector(
                onTap: () {
                  if (widget.copyTelegram) {
                    Clipboard.setData(ClipboardData(text: user.tgAlias));
                    showSnackBar(context, user.tgAlias);
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
                            !(user.login==group.owner)? Text(user.name) : Text(user.name + " 👑"),
                            //Text(user.name)
                          ],
                        ),
                        Row(children: [
                          Visibility(
                            visible: mode == "new",
                            child: IconButton(
                                icon: new Icon(Icons.add_circle_outline),
                                onPressed: () async{

                                  String deleted = await _editUser(
                                      context,
                                      darkModeOn,
                                      "Do you want to add user " +
                                          user.name +
                                          "?");
                                  print(deleted);
                                  if (deleted == "true") {


                                  GroupEntity g = await APIRequests().addUser(user.token, group);
                                 // group = g;
                                  UserListHolder.members.add(user);
                                  UserListHolder.pending.remove(user);


                                  Navigator.pop(context);
                                }}),
                          ),
                          Visibility(
                            visible: mode == "existing",
                            child: !(user.login==UserSession().getUserentity.login)?IconButton(
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
                                    UserListHolder.members.remove(user);
                                    await APIRequests().deleteUserFromGroup(user.token, group);
                                    Navigator.pop(context);
                                  }
                                }):SizedBox(height: 50,),
                          ),
                          Visibility(
                            visible: mode == "new",
                            child: IconButton(
                                icon: new Icon(Icons.remove_circle_outline),
                                onPressed: () async{
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
