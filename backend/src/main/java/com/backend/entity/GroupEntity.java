package com.backend.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Document("group")
public class GroupEntity {
    private @Id String id;
    private String groupName;
    private String groupDescription = "Default description";
    private String groupTgLink;
    private int membersLimit;
    private List<String> membersLogins = null;
    private List<String> groupTags = null;
    private String owner;
    private String groupCategory;
    private List<ChallengeEntity> challenges;

    public GroupEntity(){
        this.id = UUID.randomUUID().toString();
        membersLogins = new ArrayList<>();
        groupTags = new ArrayList<>();
        challenges = new ArrayList<>();
    }

    public GroupEntity(String owner, String groupName, int membersLimit, String groupCategory, String groupDescription, String groupTgLink, List<String> groupTags) {
        this.id = UUID.randomUUID().toString();
        this.owner = owner;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.groupTgLink = groupTgLink;
        this.groupCategory = groupCategory;
        this.membersLimit = membersLimit;
        this.membersLogins = new ArrayList<>();
        this.groupTags = new ArrayList<>();
        this.groupTags = groupTags;
        try {
            this.ifOwner(owner).addMember(owner);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        challenges = new ArrayList<>();
    }

    public GroupEntity(String owner, String groupName, String groupCategory, String groupTgLink, int membersLimit) {
        this.id = UUID.randomUUID().toString();
        this.owner = owner;
        this.groupName = groupName;
        this.groupTgLink = groupTgLink;
        this.groupCategory = groupCategory;
        this.membersLimit = membersLimit;
        try {
            this.ifOwner(owner).addMember(owner);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        membersLogins = new ArrayList<>();
        groupTags = new ArrayList<>();
        challenges = new ArrayList<>();
    }

    public void addNewChallenge(String challengeName, String challengeDescription) throws Exception {
        if (challenges.contains(challengeName)) {
            throw new Exception("Challenge with name " + challengeName + " exists");
        }
        ChallengeEntity tempChallenge = new ChallengeEntity(challengeName, challengeDescription);
        for (int i = 0; i < membersLogins.size(); i++) {
            tempChallenge.addCounterForNewMember(membersLogins.get(i));
        }
        challenges.add(tempChallenge);
    }

    private void addNewMemberToChallenges(String login) {
        for (int i = 0; i < challenges.size(); i++) {
            challenges.get(i).addCounterForNewMember(login);
        }
    }

    private void deleteMemberFromChallenges(String login) {
        for (int i = 0; i < challenges.size(); i++) {
            if (challenges.get(i).getChallengeCounters().containsKey(login)) {
                challenges.get(i).deleteCounterOfMember(login);
            }
        }
    }

    public GroupEntity(String owner, String groupName, int membersLimit, String groupCategory) {
        this.id = UUID.randomUUID().toString();
        this.owner = owner;
        this.groupName = groupName;
        this.membersLimit = membersLimit;
        this.groupCategory = groupCategory;
        this.membersLogins = new ArrayList<>();
        this.groupTags = new ArrayList<>();

        try {
            this.ifOwner(owner).addMember(owner);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public GroupEntity ifOwner(String user) {
        if (user.compareTo(this.owner) == 0) {
            return this;
        }
        return null;
    }

    public GroupEntity addMember(String login) throws Exception {
        if (membersLogins.size() >= membersLimit) {
            throw new Exception("Limit of members is exceeded!");
        }
        membersLogins.add(login);
        this.addNewMemberToChallenges(login);
        return this;
    }

    private boolean isOwner(String owner) {
        return owner.compareTo(this.owner) == 0;
    }

    public int getMembersNumber() {return membersLogins.size();}

    public void addTag(String tag) {
        if (this.groupTags.contains(tag)) {
            return;
        }
        groupTags.add(tag);
    }

    public void deleteMember(String owner, String login) throws Exception {
        if (!membersLogins.contains(login)) {
            throw new Exception("No user with login=" + login + " in this group!");
        }
        if (!isOwner(owner)) {
            throw new Exception("You are not an owner of this group!");
        }
        membersLogins.remove(login);
        this.deleteMemberFromChallenges(login);
    }

    public boolean isValid() {
        if (owner == null || membersLimit < 1 || groupName == null
                || !groupName.matches("\\w.*") || !groupCategory.matches("\\w.*")) {
            return false;
        }
        if (!membersLogins.contains(owner)) {
            this.membersLogins.add(owner);
        }
        return true;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupDescription() {
        return groupDescription;
    }

    public void setGroupDescription(String groupDescription) {
        this.groupDescription = groupDescription;
    }

    public int getMembersLimit() {
        return membersLimit;
    }

    public void setMembersLimit(int membersLimit) {
        this.membersLimit = membersLimit;
    }

    public List<String> getMembersLogins() {
        return membersLogins;
    }

    public void setMembersLogins(List<String> membersLogins) {
        this.membersLogins = membersLogins;
    }

    public List<String> getGroupTags() {
        return groupTags;
    }

    public void setGroupTags(List<String> groupTags) {
        this.groupTags = groupTags;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getGroupCategory() {
        return groupCategory;
    }

    public void setGroupCategory(String groupCategory) {
        this.groupCategory = groupCategory;
    }

    public String getGroupTgLink(){return groupTgLink;}

    public void setGroupTgLink(String groupTgLink){this.groupTgLink = groupTgLink;}

}
