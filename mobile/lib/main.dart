import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Habit App',
      home: BottomNavigator(),
    );
  }
}

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavigator> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Search',style: optionStyle,),
    Text('Create',style: optionStyle,),
    Text('My Groups',style: optionStyle,),
    Text('Profile',style: optionStyle,),

  ];


  void onItemTapped(int index){
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
    return Scaffold(
      appBar: AppBar(

          title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Create'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('My Groups'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Profile'),
          ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.grey[800],

      onTap: onItemTapped,// This trailing comma makes auto-formatting nicer for build methods.
    ),);
  }
}
