import 'package:flutter/material.dart';
import 'package:social_habit_app/api/api_requests.dart';

class UserList extends StatelessWidget {
  List<UserEntity> users = [
    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Dima Tsaplia",
      description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),

    new UserEntity(login:"login2",password:"password2",token:"token2",name:"Gleb Osotov",
        description:"Description2",tgAlias:"tg2",age:"18",tags:[],userGroups:[]),
    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Alexey Rakov",
        description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),
    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Ethan Shaghaie",
        description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),
    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Evgeny Panov",
        description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),
    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Ivan Konyukhov",
        description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),

    new UserEntity(login:"login1",password:"password1",token:"token1",name:"Giancarlo Succi",
        description:"Description1",tgAlias:"tg1",age:"18",tags:[],userGroups:[]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
