import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/groupcardpage/group_card_page.dart';

class FindGroupScreen extends StatefulWidget {
  FindGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FindGroupScreen createState() => _FindGroupScreen();
}


List<String> testList = [];


class _FindGroupScreen extends State<FindGroupScreen>{

  @override
  Widget build(BuildContext context) {
   testList.clear();
    for(int i = 0;i<10;i++){
     testList.add("Card"+i.toString()) ;
   }
    return Container(
      color: constants.backgroundColor,
        margin: EdgeInsets.only(bottom: 5, top: 10, right: 2, left: 2),
        child: SingleChildScrollView(

      child:
      Column(

        children: testList.map((String string) {
          return  Container(
              width: double.infinity,
              height: 100,
              child:

              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                  child:
                      InkWell(
                        onTap:()async{

                          await   showDialog(context: context,
                              builder: (BuildContext buildContext)=>GroupCardDialog(string));
                        } ,
                        child:
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 15, right: 10, left: 15),
                          child:
                          Text(string,style: TextStyle(fontSize: 16, fontWeight:FontWeight.w400 ),),

                        ))

              )

          );
        }).toList()
      ),
    ));




     }



}