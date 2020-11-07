class Group {
  String groupName;
  String groupDescription;
  String category;
  List<String> preferences;
  int participants;
  int maxParticipants;
  String telegramLink;
  List<String> groupParticipants;
  Group(
      String groupName,
      String groupDescription,
      String telegram,
      String category,
      List<String> preferences,
      List<String> groupParticipants,
      int participants,
      int maxParticipants) {
    this.groupName = groupName;
    this.groupDescription = groupDescription;
    this.category = category;
    telegramLink = telegram;
    this.preferences = preferences;
    this.participants = participants;
    this.maxParticipants = maxParticipants;
    this.groupParticipants = groupParticipants;
  }




}
