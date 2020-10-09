import 'package:flutter/cupertino.dart';

class MyGroupsScreen extends StatefulWidget {
  MyGroupsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyGroupsScreen createState() => _MyGroupsScreen();
}





class _MyGroupsScreen extends State<MyGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("test"),);
  }
}