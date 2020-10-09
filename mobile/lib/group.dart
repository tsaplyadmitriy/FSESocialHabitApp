class Group{

  String groupName;
  String groupDescription;
  List<String> tags;
  List<String>preferences;
  int participants;
  int maxParticipants;

  Group(String groupName,String groupDescription, List<String >tags,
      List<String>preferences, int participants, int maxParticipants){

    this.groupName = groupName;
    this.groupDescription = groupDescription;
    this.tags  = tags;
    this.preferences = preferences;
    this.participants = participants;
    this.maxParticipants = maxParticipants;

  }






}