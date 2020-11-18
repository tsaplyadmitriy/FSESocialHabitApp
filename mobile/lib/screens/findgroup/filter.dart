import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/smallButton.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/constants.dart';

import 'findgroup.dart';

class FilterTab extends StatefulWidget {
  @override
  _FilterTab createState() => _FilterTab();
}

class _FilterTab extends State<FilterTab> {
  double sliderParticipants = 1;
  bool searchByName = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of s

    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    String category = "";
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[


          ],
          centerTitle: true,
          title: Text('Search'),
        ),
        // body: ListView.builder(
        //   itemCount: UserSession().getCategoryList.length,
        //   itemBuilder: (context, index) => ListTile(
        //     title: Text(
        //       UserSession().getCategoryList[index],
        //     ),
        //   ),
        // ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RoundedInputField(
                  hintText: "Enter your request",
                  icon: (Icons.search),
                  onChanged: (change){
                    category = change;

                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButton(
                      text: "Names",
                      bold: searchByName,
                      widthModifier: 0.4,
                      press: () {
                        setState(() {
                          searchByName = true;
                          print(searchByName);
                        });
                      },
                      color: !searchByName
                          ? Constants.kPrimaryColor
                          : (darkModeOn
                              ? Constants.dSecondaryColor
                              : Constants.kSecondaryColor),
                    ),
                    SmallButton(
                      text: "Categories",
                      widthModifier: 0.4,
                      bold: !searchByName,
                      press: () {
                        setState(() {
                          searchByName = false;
                          print(searchByName);
                        });
                      },
                      color: searchByName
                          ? Constants.kPrimaryColor
                          : (darkModeOn
                              ? Constants.dSecondaryColor
                              : Constants.kSecondaryColor),
                    ),
                  ],
                ),
                TextFieldContainer(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          Container(
                            width: size.width * 0.6,
                            child: Slider(
                              activeColor: Theme.of(context).primaryColor,
                              inactiveColor:
                                  Theme.of(context).unselectedWidgetColor,
                              divisions: 6,
                              min: 1,
                              max: 7,
                              onChanged: (double value) {
                                setState(() {
                                  sliderParticipants = value;
                                  //TODO: get participants filter here
                                });
                              },
                              value: sliderParticipants,
                              label: "${sliderParticipants.toInt()}",
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Minumum number of participants",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                SmallButton(
                    text: "Search",

                    press: () async {
                      groupList = await APIRequests().getGroupByCategoryList(
                          category, UserSession().getUserentity.token);

                      if (!UserSession().getCategoryList.contains(category)) {

                          UserSession().setCategoriesList = (await APIRequests().addCategory(
                            UserSession().getUserentity.token, category)).map((e) => e.categoryName).toList();

                      }

                      doWeNeedToRefresh = true;

                      Navigator.pushReplacementNamed(context, Constants.loginDone);
                    }),
              ]),
        ));
  }
}

class Search extends SearchDelegate {
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
    if (selectedResult == '') {
      selectedResult = query;
    }
    if (!recentList.contains(selectedResult)) {
      recentList.add(selectedResult);
    }

    return Container(
      child: Center(
        child: RoundedButton(
          text: "Find " + selectedResult,
          press: () async {
            groupList = await APIRequests().getGroupByCategoryList(
                selectedResult, UserSession().getUserentity.token);

            if (!UserSession().getCategoryList.contains(selectedResult)) {

              UserSession().getCategoryList.add(selectedResult);
              await APIRequests().addCategory(
                  UserSession().getUserentity.token, selectedResult);
            }

            doWeNeedToRefresh = true;

            Navigator.pushReplacementNamed(context, Constants.loginDone);
          },
        ),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = [];

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
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
