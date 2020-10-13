import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/tags_horizontal.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';

class GroupCardDialog extends StatelessWidget {
  Group group;

  GroupCardDialog(Group group) {
    this.group = group;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of s
    //print("test "+entity.preferences.length.toString());
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.05, horizontal: 15),
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              NameOfGroup(group: group),
              SizedBox(height: size.height * 0.01),
              TagsHorizontalScroll(
                list: group.tags,
              ),
              SizedBox(height: size.height * 0.01),
              GroupCardPage_preferences(group: group),
              GroupCardPagedescription(group: group),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: RoundedButton(
                    text: "Apply",
                    press: () {
                      Navigator.of(context).pop(true);
                    },
                    color: Constants.kPrimaryColor,
                  )
                  // child: FlatButton(
                  //   // borderSide: BorderSide(color: Constants.primary, width: 2),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(25)),
                  //   child: Ink(
                  //       decoration: BoxDecoration(
                  //           gradient: constants.gradient(),
                  //           borderRadius: BorderRadius.circular(30.0)),
                  //       child: Container(
                  //           constraints:
                  //               BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                  //           alignment: Alignment.center,
                  //           child: Text(
                  //             "Apply",
                  //             style: TextStyle(color: Colors.white),
                  //           ))),
                  //   onPressed: () {
                  //     Navigator.of(context).pop(true);
                  //   },
                  // ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupCardPagedescription extends StatelessWidget {
  const GroupCardPagedescription({
    Key key,
    @required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of s
    return Expanded(
        // height: size.height * 0.4,
        //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: SingleChildScrollView(
      child: Text(
        group.groupDescription,
        //textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    ));
  }
}

class GroupCardPage_preferences extends StatelessWidget {
  const GroupCardPage_preferences({
    Key key,
    @required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: group.preferences.map((String pref) {
        return Text(
          "#" + pref + "\t",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        );
      }).toList(),
    );
  }
}

class NameOfGroup extends StatelessWidget {
  const NameOfGroup({
    Key key,
    @required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Text(
      group.groupName,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
