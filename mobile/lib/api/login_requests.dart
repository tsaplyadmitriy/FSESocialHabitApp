import 'dart:convert';
import 'dart:io';

import 'package:rest_data/rest_data.dart';
import 'package:social_habit_app/constants.dart';

import 'package:http/http.dart' as http;


class LoginRequest  {
  final int error;
  final String token;
  final String message;

  LoginRequest({this.error, this.token, this.message});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      error: json['error'],
      token: json['token'],
      message: json['message'],
    );
  }



  }

  //Singleton class
class APIRequests{
  static final APIRequests _singleton = APIRequests._internal();

  factory APIRequests() {

    return _singleton;
  }

  APIRequests._internal(){
  }//private constructor

  Future<LoginRequest> getUserToken(String login, String password)async{

    String req =  Constants.apiLink+'/login?login='+login+'&password='+password;
    print(req);
    final response = await http.get(req);
    final responseJson = jsonDecode(response.body);

    return LoginRequest.fromJson(responseJson);

  }

  void signUpUser(){


  }

}








