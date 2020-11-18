import 'package:social_habit_app/api/api_requests.dart';
import 'package:social_habit_app/api/user_session.dart';

class Group {
  String groupName;
  String groupDescription;
  String category;
  List<String> preferences;
  int participants;
  int maxParticipants;
  String telegramLink;
  List<String> groupParticipants;
  List<String> pendingUsers;
  Group(
      String groupName,
      String groupDescription,
      String telegram,
      String category,
      List<String> preferences,
      List<String> groupParticipants,
      int participants,
      int maxParticipants,
       List<String> pendingUsers
      )  {
    this.groupName = groupName;
    this.groupDescription = groupDescription;
    this.category = category;
    telegramLink = telegram;
    this.preferences = preferences;
    this.participants = participants;
    this.maxParticipants = maxParticipants;
    this.groupParticipants = groupParticipants;
    this.pendingUsers = pendingUsers;
    // this.groupParticipants = groupParticipants.map((e) async => await APIRequests().getUserByLogin(UserSession().getUserentity.token,
    //     e)).cast<UserEntity>();
    // this.pendingUsers = pendingUsers.map((e) async => await APIRequests().getUserByLogin(UserSession().getUserentity.token,
    //     e)).cast<UserEntity>();
  }



}
