import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:social_habit_app/screens/mygroups/my_group_page.dart';

class ChallengeCard extends StatefulWidget {
  final Size size;
  final Challenge demoChallenge;

  const ChallengeCard({Key key, this.size, this.demoChallenge})
      : super(key: key);
  @override
  _ChallengeCardState createState() =>
      _ChallengeCardState(this.size, this.demoChallenge);
}

class _ChallengeCardState extends State<ChallengeCard> {
  final Size size;
  Challenge demoChallenge;
  _ChallengeCardState(this.size, this.demoChallenge) : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: 30,
                    child: Marquee(
                      text: demoChallenge.name,
                      style: Theme.of(context).textTheme.bodyText2,
                      blankSpace: 15.0,
                      velocity: 50.0,
                      pauseAfterRound: Duration(seconds: 3),
                      startPadding: 10.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width * 0.21,
                      child: CircularPercentIndicator(
                        radius: size.width * 0.2,
                        lineWidth: 10.0,
                        animation: true,
                        percent: demoChallenge.currentProgress[0] /
                            demoChallenge.goal,
                        //TODO: this shows participant 0, with when API is ready
                        center: Text(
                            "${demoChallenge.currentProgress[0]}/${demoChallenge.goal}",
                            style: Theme.of(context).textTheme.headline1),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).accentColor,
                        animateFromLastPercent: true,

                        backgroundColor:
                            Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shape: StadiumBorder(),
                      ),
                      child: Text("Success for today"),
                      onPressed: () {
                        setState(() {
                          if (demoChallenge.currentProgress[0] <
                              demoChallenge.goal)
                            demoChallenge.currentProgress[0]++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            LinearPercentIndicator(
              width: size.width * 0.8,
              lineHeight: 10.0,
              animation: true,
              percent: demoChallenge.currentProgress.reduce((a, b) => a + b) /
                  (demoChallenge.goal * demoChallenge.participants),
              backgroundColor: Theme.of(context).unselectedWidgetColor,
              progressColor: Theme.of(context).primaryColorLight,
              animateFromLastPercent: true,
            ),
            SizedBox(height: size.height * 0.01),
            Text("Group's progress",
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
