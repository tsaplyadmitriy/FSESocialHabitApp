import 'package:flutter/cupertino.dart';

class CreateGroupScreen extends StatefulWidget {
  CreateGroupScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateGroupScreen createState() => _CreateGroupScreen();
}





class _CreateGroupScreen extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("test"),);
  }
}