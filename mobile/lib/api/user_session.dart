import 'package:social_habit_app/api/api_requests.dart';

class UserSession {
  static final UserSession _singleton = UserSession._internal();

  UserEntity currentEntity;

  factory UserSession() {
    return _singleton;
  }


  void set setUserEntity(UserEntity userEntity)=> this.currentEntity = userEntity;
  UserEntity get getUserentity =>  this.currentEntity;

  UserSession._internal(){

  } //private constructor



}