import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/constants.dart';

import 'findgroup.dart';

class FilterTab extends StatefulWidget{

  final List<String> list = ['category','category 1','category 2'];

  @override
  _FilterTab createState() => _FilterTab();



}

class _FilterTab extends State<FilterTab>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Search Bar'),
      ),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            widget.list[index],
          ),
        ),
      ),
    );
  }

}

class Search extends SearchDelegate {

  static FindGroupScreen findGroupScreen;
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    if(!recentList.contains(selectedResult)){
      recentList.add(selectedResult);
    }
    return Container(
      child: Center(
        child: RoundedButton(
            text:"Find "+selectedResult,
          press:() async{

            groupList = await APIRequests().getGroupByCategoryList
              (selectedResult, UserSession().getUserentity.token);
            for(GroupEntity g in groupList){

              print("group size"+groupList.length.toString());

            }

            Navigator.pushReplacementNamed(context,Constants.loginDone);
        },
        ),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.toLowerCase().contains(query.toLowerCase()),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}