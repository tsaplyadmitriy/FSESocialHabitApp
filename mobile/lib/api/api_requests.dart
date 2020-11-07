import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:rest_data/rest_data.dart';
import 'package:social_habit_app/constants.dart';

import 'package:http/http.dart' as http;
import 'package:social_habit_app/group.dart';


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


 class UserEntity {
    String login;
   String password;
   String token;
   String name = "DefaultFirstName";
   String tgAlias = "DefaultLastName";
   List<dynamic> tags;

   List<dynamic> userGroups;
   String age = '18';


   UserEntity({login, String password, String token,String name, String tgAlias, String age,List<dynamic> tags,List<dynamic> userGroups}) {
    this.login = login;
    this.password = password;
    this.token = token;
    this.name = name;
    this.age = age;
    this.tags = tags;
    this.userGroups = userGroups;



  }




    factory UserEntity.fromJson(Map<String, dynamic> json) {
     print(json['age']);
      return UserEntity(
        login: json['login'],
        password: json['password'],
        token: json['token'],
        name: json['name'],
        age: json['age'].toString(),
        userGroups: json['userGroups'],
        tags: json['tags']
      );
    }
}

 class GroupEntity {

    String id;
   String groupName;
   String groupDescription;
   String groupTgLink;
   int membersLimit;
   List<dynamic> members;
   List<dynamic>groupTags;
   String owner;
   String groupCategory;
    List<dynamic> challenges;

   GroupEntity({this.groupName, this.groupDescription,
     this.membersLimit,this.members,
     this.groupTags,this.owner,this.groupCategory, this.id,this.groupTgLink,this.challenges});

   factory GroupEntity.fromJson(Map<String, dynamic> json) {

     return GroupEntity(
       id:json['id'],
       groupName: json['groupName'],
       groupTgLink: json['groupTgLink'],
       groupDescription: json['groupDescription'],
       membersLimit: json['membersLimit'],
       members: json['membersLogins'],
       groupTags: json['groupTags'],
         owner: json['owner'],
         groupCategory: json['groupCategory'],
       challenges: json['challenges']
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

  Future<UserEntity> signUpUser(String login, String password,String name) async{
    var url = Constants.apiLink+"/signup";
    var response = await http.post(url, headers:{'Content-type':'application/json'},body:jsonEncode({'login': login, 'password': password,
      'name':name,'tgAlias':"sampleAlias",'tags':["tag1"],'userGroups':[],'age':18}));

    print(response.toString());
    final responseJson = jsonDecode(response.body);

    return UserEntity.fromJson(responseJson);
  }


  Future<GroupEntity> createUserGroup(String token,String login,String groupName, String groupDescription, String groupTGLink,int membersLimit,
       List<String>groupTags, String groupCategory) async{
    var url = Constants.apiLink+"/api/addGroup";
    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader: token},body:jsonEncode({'owner': login,
      'groupCategory':groupCategory,'groupName': groupName,'groupTGLink':groupTGLink,'groupDescription':groupDescription,'membersLimit':membersLimit,
      'groupTags':groupTags}));

    print(response.toString());
    final responseJson = jsonDecode(response.body);
    print(responseJson.toString());

    return GroupEntity.fromJson(responseJson);

  }

  Future<List<GroupEntity>> getGroupList(String token) async{
    var url = Constants.apiLink+'/api/groups';
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader : token});
     Iterable l = jsonDecode(response.body);

     List<GroupEntity>list = (json.decode(response.body) as List).map((i) =>GroupEntity.fromJson(i)).toList();
     print(list.toString());
     return  list;

  }


  Future<UserEntity>  getUserByToken (String token) async{
    String req =  Constants.apiLink+'/api/user?token='+token;
    print(req);
    final response = await http.get(req,headers: {HttpHeaders.authorizationHeader: token});
    final responseJson = jsonDecode(response.body);

    return UserEntity.fromJson(responseJson);
  }

}








