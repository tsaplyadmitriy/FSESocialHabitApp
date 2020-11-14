import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/constants.dart' as constants;
import 'components/data_keeper.dart';

class LoginSplash extends StatelessWidget{

  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  String login = "";
  String password = "";

  LoginSplash(String login,String password){
    this.login = login;
    this.password = password;

  }


  Future<LoginRequest> auth(String login, String password) async {
    LoginRequest loginRequest = await APIRequests().getUserToken(
        login, password);

    if (loginRequest.error == 0) {
      UserSession().setUserEntity =
      await APIRequests().getUserByToken(loginRequest.token);
      UserSession().setCategoriesList = (
      await APIRequests().getCategoriesList(loginRequest.token)).map((e) => e.categoryName).toList();

      print("token: "+UserSession().getUserentity.token);
      //print("user name: "+UserSession().getUserentity.name);
      print("check");


    }
    return loginRequest;
  }

  @override
  Widget build(BuildContext context) {

    //Future<LoginRequest> loginRequest = APIRequests().getUserToken(login, password);

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await auth(login,password) ,
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => loginLogic(data, context),
    );

    return new Scaffold(
      appBar: new AppBar(title: buildAppBarTitle('Logging in...')),
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

  Widget loginLogic(LoginRequest request, BuildContext context){



    print(request);
    if(request.error == 0){


      SchedulerBinding.instance.addPostFrameCallback((_) {

        // add your code here.

        Navigator.pushReplacementNamed(context, constants.Constants.loginDone);
      });

        return Text("Logged in  succesfully!");

    }else{
      SchedulerBinding.instance.addPostFrameCallback((_) {

        // add your code here.

        Navigator.pushReplacementNamed(context, "/log_in");
      });

      return Text("Login failed :(");
    }




  }

}