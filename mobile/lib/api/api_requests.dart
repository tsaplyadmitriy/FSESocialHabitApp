import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:rest_data/rest_data.dart';
import 'package:social_habit_app/api/user_session.dart';
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


  class CategoryEntity{

     String categoryName;
    CategoryEntity({this.categoryName});


    factory CategoryEntity.fromJson(Map<String,dynamic> json){

      return CategoryEntity(
        categoryName: json['categoryName']

      );

     }


  }

 class UserEntity {
    String login;
   String password;
   String token;
   String name = "DefaultFirstName";
   String tgAlias = "DefaultLastName";
   String description = "Default Description";
   List<dynamic> tags;

   List<dynamic> userGroups;
   String age = '18';


   UserEntity({String login, String password, String token,String name, String description,String tgAlias, String age,List<dynamic> tags,List<dynamic> userGroups}) {
    this.login = login;
    this.password = password;
    this.token = token;
    this.name = name;
    this.age = age;
    this.tags = tags;
    this.userGroups = userGroups;
    this.description = description;



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
        tags: json['tags'],
          description: json['description']
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
    List<dynamic>  pendingUsers;


   GroupEntity({this.groupName, this.groupDescription,
     this.membersLimit,this.members,
     this.groupTags,this.owner,this.groupCategory, this.id,this.groupTgLink,this.challenges,this.pendingUsers});

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
       challenges: json['challenges'],
         pendingUsers: json['pendingUsers']
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
      'name':name,'tgAlias':"sampleAlias",'description':"sampleDescription",'tags':[],'userGroups':[],'age':18}));

    print(response.toString());
    final responseJson = jsonDecode(response.body);

    return UserEntity.fromJson(responseJson);
  }


  Future<GroupEntity> createUserGroup(String token,String login,String groupName, String groupDescription, String groupTGLink,int membersLimit,

      List<String>groupTags, String groupCategory,List<String> pendingUsers) async{
    var url = Constants.apiLink+"/api/addGroup";
    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader: token},body:jsonEncode({'owner': login,
      'groupCategory':groupCategory,'groupName': groupName,'groupTGLink':groupTGLink,'groupDescription':groupDescription,'membersLimit':membersLimit,
      'groupTags':groupTags,'pendingUsers':pendingUsers}));

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


  Future<List<GroupEntity>> getGroupByCategoryList(String category,String token) async{
    var url = Constants.apiLink+'/api/findGroups/category?category='+category;
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader : token});
    print("resp: \n"+jsonDecode(response.body).toString());
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

  Future<UserEntity>  getUserByLogin (String token,String login) async{
    String req =  Constants.apiLink+'/api/userByLogin?login='+login;
    print(req);
    final response = await http.get(req,headers: {HttpHeaders.authorizationHeader: token});
    final responseJson = jsonDecode(response.body);

    return UserEntity.fromJson(responseJson);
  }


  Future<List<CategoryEntity>> getCategoriesList(String token) async{
    var url = Constants.apiLink+'/api/categories';
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader : token});

    Iterable l = jsonDecode(response.body);

    List<CategoryEntity>list = (json.decode(response.body) as List).map((i) =>CategoryEntity.fromJson(i)).toList();
    return  list;

  }

  Future<List<CategoryEntity>> addCategory(String token, String category) async {

    var url = Constants.apiLink+"/api/addCategory";
    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader : token}
                          ,body:jsonEncode({'category': category}));
    Iterable l = jsonDecode(response.body);

    List<CategoryEntity>list = (json.decode(response.body) as List).map((i) =>CategoryEntity.fromJson(i)).toList();
    return  list;


  }

  Future<UserEntity> updateUserInfo(String token) async {
    var url = Constants.apiLink+"/api/updateUser";
    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader : token}
        ,body:jsonEncode({
          'login': UserSession().getUserentity.login,
          'password': UserSession().getUserentity.password,
          'name':UserSession().getUserentity.name,
          'tgAlias':UserSession().getUserentity.tgAlias,
          'description':UserSession().getUserentity.description,
          'tags':UserSession().getUserentity.tags,
          'userGroups':UserSession().getUserentity.userGroups,
          'age':18}));
    final responseJson = jsonDecode(response.body);
    return UserEntity.fromJson(responseJson);


  }


  Future<GroupEntity> addPendingUser(String token, GroupEntity groupEntity) async{

    var url = Constants.apiLink+"/api/addGroup";
     groupEntity.pendingUsers.add(UserSession().getUserentity.login);
    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader: token},body:jsonEncode({
      'owner': groupEntity.owner,
    'groupCategory':groupEntity.groupCategory,
      'groupName': groupEntity.groupName,
      'groupTGLink':groupEntity.groupTgLink,
      'groupDescription':groupEntity.groupDescription,
      'membersLimit':groupEntity,
    'groupTags':groupEntity.groupTags,
      'pendingUsers':groupEntity.pendingUsers}));


    final responseJson = jsonDecode(response.body);


    return GroupEntity.fromJson(responseJson);


  }







}








