
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';




class GroupCardDialog extends StatelessWidget {
  String entity;


  GroupCardDialog(String entity) {
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
    return Stack(
      children: <Widget>[
        Container(

          padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          margin: EdgeInsets.only(top: 10),
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
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                entity,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                entity,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              SizedBox(height: 124.0),

              Align(
                alignment: Alignment.bottomCenter,
                child:FlatButton(

                  // borderSide: BorderSide(color: Constants.primary, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
                  ),
                  child:
                  Ink(

                      decoration: BoxDecoration(color: constants.kPrimaryColor, borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child:
                          Text(
                            "Enter",
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