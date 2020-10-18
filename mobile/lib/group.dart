class Group {
  String groupName;
  String groupDescription;
  List<String> tags;
  List<String> preferences;
  int participants;
  int maxParticipants;
  String telegramLink;

  Group(
      String groupName,
      String groupDescription,
      String telegram,
      List<String> tags,
      List<String> preferences,
      int participants,
      int maxParticipants) {
    this.groupName = groupName;
    this.groupDescription = groupDescription;
    this.tags = tags;
    telegramLink = telegram;
    this.preferences = preferences;
    this.participants = participants;
    this.maxParticipants = maxParticipants;
  }
}
