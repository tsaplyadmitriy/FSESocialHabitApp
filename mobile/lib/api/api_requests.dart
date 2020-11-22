import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:rest_data/rest_data.dart';
import 'package:social_habit_app/api/user_session.dart';
import 'package:social_habit_app/constants.dart';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:social_habit_app/screens/mygroups/my_group_page.dart';


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
    Map<String, dynamic> toJson() => _$UserEntityToJson(this);
    Map<String, dynamic> _$UserEntityToJson(UserEntity instance) => <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'token': instance.token,
      'name':instance.name,
      'age': int.parse(age),
      'userGroups': instance.userGroups,
      'tags': instance.tags,
      'description':instance.description
    };
}

@JsonSerializable(nullable:false)
 class GroupEntity {

    String id;
   String groupName;
   String groupDescription;
   String groupTgLink;
   int membersLimit;
   List<UserEntity> members;
   List<String>groupTags;
   String owner;
   int memberNumber;
   String groupCategory;
    List<ChallengeEntity> challenges;
    List<UserEntity>  pendingUsers;


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
       members: (json['membersLogins'] as List).map((i) =>UserEntity.fromJson(i)).toList(),
       groupTags: (json['groupTags'] as List).map((i) =>i.toString()).toList(),
         owner: json['owner'],
         groupCategory: json['groupCategory'],
       challenges: (json['challenges'] as List).map((i) =>ChallengeEntity.fromJson(i)).toList(),
         pendingUsers: (json['pendingUsers']as List).map((i) =>UserEntity.fromJson(i)).toList()
     );
   }





}



class ChallengeEntity{

  String challengeName;
  String challengeDescription;
  List<ChallengeCounter> challengeCounters;
  String challengeDateOfStarting;

  ChallengeEntity({this.challengeName,this.challengeDescription,this.challengeCounters,this.challengeDateOfStarting});

  factory ChallengeEntity.fromJson(Map<String,dynamic>json){
    return ChallengeEntity(
        challengeName: json['challengeName'],
        challengeDescription: json['challengeDescription'],
        challengeDateOfStarting: json['challengeDateOfStarting'],
        challengeCounters: (json['challengeCounters'] as List).map((i) =>ChallengeCounter.fromJson(i)).toList(),


    );


  }


}


class ChallengeCounter{
  String user;
  int counter;

  ChallengeCounter({this.user, this.counter});

  factory ChallengeCounter.fromJson(Map<String,dynamic> json){

    return ChallengeCounter(
      user: json['user'],
      counter: json['counter']

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

      List<String>groupTags, String groupCategory) async{
    var url = Constants.apiLink+"/api/addGroup";



    var response = await http.post(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader: token},body:jsonEncode({'owner': login,
      'groupCategory':groupCategory,'groupName': groupName,'groupTgLink':groupTGLink,'groupDescription':groupDescription,'membersLimit':membersLimit,
      'groupTags':groupTags,'membersLogins':[],'pendingUsers':[],'challenges':[]}));

    print("NAME:  "+UserSession().getUserentity.name);
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



    List<CategoryEntity>list = (json.decode(response.body) as List).map((i) =>CategoryEntity.fromJson(i)).toList();
    return  list;

  }

  Future<List<CategoryEntity>> addCategory(String token, String category) async {

    var url = Constants.apiLink+"/api/addCategory";
    var response = await http.post(url, headers:{HttpHeaders.authorizationHeader : token}
                          ,body:{'category': category});
    Iterable l = jsonDecode(response.body);

    List<CategoryEntity>list = (json.decode(response.body) as List).map((i) =>CategoryEntity.fromJson(i)).toList();
    return  list;


  }

  Future<List<GroupEntity>> getUserGroups()async {

    print(UserSession().getUserentity.userGroups.toString());
    var url = Constants.apiLink+'/api/findGroups/getUserGroups?token='+UserSession().getUserentity.token;
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader : UserSession().getUserentity.token});
    print(response.body.toString());


    List<GroupEntity>list = (json.decode(response.body) as List).map((i) =>GroupEntity.fromJson(i)).toList();
    return  list;


  }


  Future<UserEntity> updateUserInfo(String token) async {
    var url = Constants.apiLink+"/api/updateUser";
    print(UserSession().getUserentity.login+"/"+UserSession().getUserentity.token);

    var response = await http.put(url, headers:{'Content-type':'application/json',HttpHeaders.authorizationHeader : UserSession().getUserentity.token}
        ,body:jsonEncode({
          'token':UserSession().getUserentity.token,
          'name':UserSession().getUserentity.name,
          'tgAlias':UserSession().getUserentity.tgAlias,
          'description':UserSession().getUserentity.description,
          'tags':UserSession().getUserentity.tags,
          }));
    print("resp update:"+response.body.toString());
    final responseJson = jsonDecode(response.body);
    return UserEntity.fromJson(responseJson);


  }


  Future<GroupEntity> addPendingUser(String token, GroupEntity groupEntity) async{

    var url = Constants.apiLink+"/api/addPending";
    print(UserSession().getUserentity.login+"/"+groupEntity.id);
     groupEntity.pendingUsers.add(UserSession().getUserentity);
    var response = await http.put(url, headers:{HttpHeaders.authorizationHeader : UserSession().getUserentity.token}
        ,body:{'groupId':groupEntity.id.toString(),'token':UserSession().getUserentity.token.toString()});

    final responseJson = jsonDecode(response.body);
    print(responseJson.toString());

    return GroupEntity.fromJson(responseJson);


  }

  Future<GroupEntity> addUser(String token, GroupEntity groupEntity) async{
    var url = Constants.apiLink+"/api/addMember";

    groupEntity.pendingUsers.add(UserSession().getUserentity);
    var response = await http.put(url, headers:{HttpHeaders.authorizationHeader : UserSession().getUserentity.token}
        ,body:{'groupId':groupEntity.id.toString(),'token':token});

    final responseJson = jsonDecode(response.body);
    print(responseJson.toString());

    return GroupEntity.fromJson(responseJson);

  }

  
  Future<GroupEntity> deleteUserFromGroup(String token, GroupEntity groupEntity)async {
    
    var url = Constants.apiLink+"/api/removeUserFromGroup?groupId="+groupEntity.id+"&token="+token;
    var response  = await http.delete(url,headers: {HttpHeaders.authorizationHeader : UserSession().getUserentity.token});

    print(response.body.toString());
    final responseJson = jsonDecode(response.body);


    return GroupEntity.fromJson(responseJson);
    
  }


  Future<ChallengeEntity> addChallenge(GroupEntity groupEntity,String challengeName,String challengeDescription) async {
    var url = Constants.apiLink+"/api/addChallenge";


    var response = await http.put(url, headers:{HttpHeaders.authorizationHeader : UserSession().getUserentity.token}
        ,body:{'groupId':groupEntity.id.toString(),'challengeName':challengeName,'challengeDescription':challengeDescription});

    final responseJson = jsonDecode(response.body);
    print(responseJson.toString());

    return ChallengeEntity.fromJson(responseJson);

  }






}








