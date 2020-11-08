import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/components/existing_account_check.dart';
import 'package:social_habit_app/components/rounded_button.dart';
import 'package:social_habit_app/components/rounded_input_field.dart';
import 'package:social_habit_app/components/rounded_password_field.dart';
import 'package:social_habit_app/screens/bottomnav/bottomnav.dart';
import 'package:social_habit_app/screens/login/components/background.dart';
import 'package:social_habit_app/screens/login/components/data_keeper.dart';
import 'package:social_habit_app/screens/signup/signup_screen.dart';

import '../splash_login.dart';





class Body extends StatelessWidget {



   Body({
    Key key,
  }) : super(key: key);





  @override
  Widget build(BuildContext context) {







    Size size = MediaQuery.of(context).size; // h and w of screen

    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Login",
            onChanged: (value) {

              DataKeeper.login = value;

            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              DataKeeper.password = value;

            },
            hintText: "Password",
          ),
          RoundedButton(
            text: "LOGIN",
            textColor: Colors.white,

            press: () async {

              await  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    LoginSplash( DataKeeper.login, DataKeeper.password)),
              );


            },
          ),
          ExistingAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }),
              );
            },
          ),
        ],
      ),
    ));
  }

   bool validateEmail(String value) {
     Pattern pattern =
         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
     RegExp regex = new RegExp(pattern);
     return (!regex.hasMatch(value)) ? false : true;
   }

}
