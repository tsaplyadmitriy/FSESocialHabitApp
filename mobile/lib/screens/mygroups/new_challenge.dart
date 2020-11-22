import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/text_field_container.dart';
import 'package:social_habit_app/screens/mygroups/my_group_page.dart';

class NewChallengeScreen extends StatefulWidget {
  final int participants;
  final GroupEntity group;

  const NewChallengeScreen({Key key, this.participants,this.group}) : super(key: key);
  @override
  _NewChallengeScreenState createState() =>
      _NewChallengeScreenState(this.participants,this.group);
}

class _NewChallengeScreenState extends State<NewChallengeScreen> {
  double sliderGoal = 5;
  int participants;
  GroupEntity groupEntity;
  _NewChallengeScreenState(this.participants,this.groupEntity) : super();
  //int participants = 0;
  Challenge newChallenge = new Challenge(5, "placeholder", 1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of
    newChallenge.participants = participants;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('New challenge'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedInputField(
                              hintText: "Name of the challenge",
                              icon: Icons.star_rate,
                              width: 0.9,
                              onChanged: (name) {
                                setState(() {
                                  newChallenge.name = name;
                                });
                              },
                            ),
                            TextFieldContainer(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Container(
                                        width: size.width * 0.7,
                                        child: Slider(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          inactiveColor: Theme.of(context)
                                              .unselectedWidgetColor,
                                          divisions: 10,
                                          min: 4,
                                          max: 14,
                                          onChanged: (double value) {
                                            setState(() {
                                              sliderGoal = value;
                                              newChallenge.goal =
                                                  sliderGoal.toInt();
                                            });
                                          },
                                          value: sliderGoal,
                                          label: "${sliderGoal.toInt()}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Duration of the challenge in days",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            RoundedButton(
                                text: "Save",
                                press: () async{
                                  print(newChallenge.name);

                                  await APIRequests().addChallenge(groupEntity, newChallenge.name, newChallenge.name);
                                  Navigator.pop(context, newChallenge);
                                })
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ));
  }
}
