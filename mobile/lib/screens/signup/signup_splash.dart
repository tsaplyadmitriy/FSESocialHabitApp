import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/constants.dart' as constants;
import 'package:social_habit_app/screens/signup/signup_keeper.dart';


class SignUpSplash extends StatelessWidget{

  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  String login = "";
  String password = "";
  String name  = "";

  SignUpSplash(String login,String password,String name){
    this.login = login;
    this.password = password;
    this.name   = name;

  }


  Future<UserEntity> auth(String login, String password,String name) async {
    UserEntity user = await APIRequests().signUpUser(login,password,name);
    UserSession().setUserEntity = user;
      return user;
    }


  @override
  Widget build(BuildContext context) {

    //Future<LoginRequest> loginRequest = APIRequests().getUserToken(login, password);

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await auth(login,password,name) ,
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => loginLogic(data, context),
    );

    return new Scaffold(
      appBar: new AppBar(title: buildAppBarTitle('Signing up...')),
      body: new Center(child: _asyncLoader),
    );
  }

  buildAppBarTitle(String title) {
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Text(title),
    );
  }

  Widget getNoConnectionWidget(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        new Text("No Internet Connection"),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    );
  }

  Widget loginLogic(UserEntity entity, BuildContext context){





      SchedulerBinding.instance.addPostFrameCallback((_) {



        Navigator.pushReplacementNamed(context,constants.Constants.loginDone);
      });

      return Text("Successfully signed up!");





  }

}