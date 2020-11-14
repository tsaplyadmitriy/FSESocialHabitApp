import 'package:social_habit_app/api/api_requests.dart';

class UserSession {
  static final UserSession _singleton = UserSession._internal();

  UserEntity currentEntity;
  List<String> categoriesList;

  factory UserSession() {
    return _singleton;
  }


  set setUserEntity(UserEntity userEntity)=> this.currentEntity = userEntity;
  UserEntity get getUserentity =>  this.currentEntity;
  set setCategoriesList(List<String> list)=> this.categoriesList = list;
  List<String> get getCategoryList =>  this.categoriesList;

  UserSession._internal(){

  } //private constructor



}