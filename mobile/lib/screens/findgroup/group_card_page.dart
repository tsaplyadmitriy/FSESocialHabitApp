import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/group.dart';

class GroupCardDialog extends StatelessWidget {
  Group entity;

  GroupCardDialog(Group entity) {
    this.entity = entity;
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
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
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
              Text(
                entity.groupName,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                  children: entity.tags.map((String string) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        gradient: constants.gradient(),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        color: Colors.transparent,
                        elevation: 5,
                        child: Container(
                          // decoration: BoxDecoration(gradient: constants.gradient()),
                          child: Text(
                            string,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        )));
              }).toList()),
              SizedBox(height: 16.0),
              Row(
                children: entity.preferences.map((String pref) {
                  return Text(
                    "#" + pref + "\t",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  );
                }).toList(),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    entity.groupDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )),
              SizedBox(height: size.height * 0.05),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  // borderSide: BorderSide(color: Constants.primary, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Ink(
                      decoration: BoxDecoration(
                          gradient: constants.gradient(),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Apply",
                            style: TextStyle(color: Colors.white),
                          ))),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
