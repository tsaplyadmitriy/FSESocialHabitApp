import 'package:flutter/material.dart';
import 'package:social_habit_app/constants.dart';

class MySliverAppBar extends StatelessWidget {
  @required
  final String text;
  @required
  final String imagePath;
  const MySliverAppBar({
    Key key,
    @required this.darkModeOn,
    this.text,
    this.imagePath,
  }) : super(key: key);

  final bool darkModeOn;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 8,
      floating: true,
      snap: true,
      stretch: true,
      backgroundColor:
          darkModeOn ? Constants.kSecondaryColor : Constants.kPrimaryLightColor,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        title: Text(text,
            style: Theme.of(context).textTheme.headline5.merge(TextStyle(
                  color: Colors.white,
                ))),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.fitHeight),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
