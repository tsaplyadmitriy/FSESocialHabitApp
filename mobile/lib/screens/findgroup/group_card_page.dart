
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


          child:dialogContent(context),
    );
  }


  dialogContent(BuildContext context) {
    print("test "+entity.preferences.length.toString());
    return Stack(

      children: <Widget>[
        Container(

          padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 15,
            right: 15,
          ),
          margin: EdgeInsets.only(top: 10,left: 15,right: 15),
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(


                  children:
                  entity.tags.map((String string) {
                    return Container(
                        margin: EdgeInsets.only(right:5 ),

                        decoration: BoxDecoration(gradient: constants.gradient(),borderRadius:BorderRadius.circular(10.0) ),

                        child:
                        Card(


                            margin: EdgeInsets.only(bottom: 3, top: 3, right: 8, left: 8),
                            color: Colors.transparent,
                            elevation: 0,
                            child:
                            Container(
                              // decoration: BoxDecoration(gradient: constants.gradient()),
                              child:
                              Text(string,style: TextStyle(fontSize: 12, fontWeight:FontWeight.w400 ,color: Colors.white),),
                            )
                        ));

                  }).toList()
              ),
              SizedBox(height: 16.0),
              Row(children: entity.preferences.map((String pref) {
                return Text("#"+pref+" ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12, fontWeight:FontWeight.w300),);

              }).toList(),),
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child:Text(

                entity.groupDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),

              SizedBox(height: 124.0),




              Align(
                alignment: Alignment.bottomCenter,
                child:FlatButton(

                  // borderSide: BorderSide(color: Constants.primary, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
                  ),
                  child:
                  Ink(

                      decoration: BoxDecoration(gradient: constants.gradient(), borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child:
                          Text(
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