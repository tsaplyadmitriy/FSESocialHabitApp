import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/constants.dart';
import 'package:social_habit_app/screens/creategroup/creategroup.dart';
import 'package:social_habit_app/screens/findgroup/filter.dart';
import 'package:social_habit_app/screens/findgroup/findgroup.dart';
import 'package:social_habit_app/screens/mygroups/mygroups.dart';
import 'package:social_habit_app/screens/profile/profile.dart';
import 'package:social_habit_app/constants.dart' as constants;
class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<String> pageHeaders = [
    "Search",
    "Create",
    "My groups",
    "Profile"
  ];
  static final  List<Widget> _widgetOptions = <Widget>[
    FindGroupScreen(),
    CreateGroupScreen(),
    MyGroupsScreen(),
    ProfileScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.




    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
      appBar: AppBar(

        title: Text(pageHeaders.elementAt(_selectedIndex)),

        actions: (_selectedIndex == 0)
            ?[
          IconButton(
            onPressed: () async{

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterTab()),
              );
             // showSearch(context: context, delegate: Search(UserSession().getCategoryList));
            },
            icon: Icon(Icons.search),
          )]

            : (_selectedIndex == 3)
            ? <Widget>[
              Row(
                children:[
                  Text("Log out"),
                   IconButton(


                    icon: Icon(Icons.arrow_forward),
                    onPressed: () async{
                      await Navigator.pushReplacementNamed(context, constants.Constants.logIn);
                 })
             ] )]
            : [],
      ),


      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text('Create'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            title: Text('My Groups'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,

        onTap:
            onItemTapped, // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ));
  }
}
