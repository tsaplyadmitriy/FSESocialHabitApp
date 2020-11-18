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
    private List<UserEntity> membersLogins = null;
    private List<String> groupTags = null;
    private String owner;
    private String groupCategory;
    private List<ChallengeEntity> challenges;
    private List<UserEntity> pendingUsers;

    public GroupEntity(){
        this.id = UUID.randomUUID().toString();
        membersLogins = new ArrayList<>();
        groupTags = new ArrayList<>();
        challenges = new ArrayList<>();
        pendingUsers = new ArrayList<>();
    }

    public GroupEntity(String id, String owner, String groupName, int membersLimit, String groupCategory, String groupDescription,
                       String groupTgLink, List<String> groupTags, List<UserEntity> pendingUsers, List<ChallengeEntity> challenges, List<UserEntity> membersLogins) {
        if (id == null) {
            this.id = UUID.randomUUID().toString();
        }
        else this.id = id;
        this.owner = owner;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.groupTgLink = groupTgLink;
        this.groupCategory = groupCategory;
        this.membersLimit = membersLimit;
        this.membersLogins = membersLogins;
        this.groupTags = new ArrayList<>();
        this.groupTags = groupTags;
        this.challenges = challenges;
        this.pendingUsers = pendingUsers;
    }

    public GroupEntity(String id, String owner, String groupName, String groupCategory, String groupTgLink, int membersLimit) {
        if (id == null) {
            this.id = UUID.randomUUID().toString();
        }
        else this.id = id;
        this.owner = owner;
        this.groupName = groupName;
        this.groupTgLink = groupTgLink;
        this.groupCategory = groupCategory;
        this.membersLimit = membersLimit;
        membersLogins = new ArrayList<>();
        groupTags = new ArrayList<>();
        challenges = new ArrayList<>();
    }



    public GroupEntity(String id, String owner, String groupName, int membersLimit, String groupCategory) {
        if (id == null) {
            this.id = UUID.randomUUID().toString();
        }
        else this.id = id;
        this.owner = owner;
        this.groupName = groupName;
        this.membersLimit = membersLimit;
        this.groupCategory = groupCategory;
        this.membersLogins = new ArrayList<>();
        this.groupTags = new ArrayList<>();
    }

    public void addMember(UserEntity user) {
        for (int i = 0; i < membersLogins.size(); i++) {
            if (membersLogins.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                return;
            }
        }

        membersLogins.add(user);
        for (int i = 0; i < challenges.size(); i++) {
            challenges.get(i).addCounter(user.getLogin());
        }
        removePendingUser(user);
    }

    public void removeUser(UserEntity user) {
        for(int i = 0; i < membersLogins.size(); i++) {
            if(membersLogins.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                membersLogins.remove(i);
            }
        }

        for (int i = 0; i < challenges.size(); i++) {
            challenges.get(i).deleteCounter(user.getLogin());
        }
    }

    public void addPendingUser(UserEntity user) {
        for (int i = 0; i < pendingUsers.size(); i++) {
            if (pendingUsers.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                return;
            }
        }
        pendingUsers.add(user);
    }

    public void removePendingUser(UserEntity user) {
        for (int i = 0; i < pendingUsers.size(); i++) {
            if (pendingUsers.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                pendingUsers.remove(i);
                return;
            }
        }
    }

    public void updateUserInfo(UserEntity user) {
        for (int i = 0; i < membersLogins.size(); i++) {
            if (membersLogins.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                membersLogins.remove(i);
                membersLogins.add(i, user);
                break;
            }
        }

        for (int i = 0; i < pendingUsers.size(); i++) {
            if (pendingUsers.get(i).getLogin().compareTo(user.getLogin()) == 0) {
                pendingUsers.remove(i);
                pendingUsers.add(i, user);
                break;
            }
        }
    }
    public void addNewChallenge(String challengeName, String challengeDescription) {
        ChallengeEntity challengeEntity = new ChallengeEntity(challengeName, challengeDescription);
        for (int i = 0; i < membersLogins.size(); i++) {
            challengeEntity.addCounter(membersLogins.get(i).getLogin());
        }
        challenges.add(challengeEntity);
    }

    public int getMembersNumber() {return membersLogins.size();}

    public boolean isValid() {
        if (owner == null || membersLimit < 1 || groupName == null
                || !groupName.matches("\\w.*") || !groupCategory.matches("\\w.*")) {
            return false;
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

    public List<UserEntity> getMembersLogins() {
        return membersLogins;
    }

    public void setMembersLogins(List<UserEntity> membersLogins) {
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

    public List<UserEntity> getPendingUsers(){return pendingUsers;}

    public void setPendingUsers(List<UserEntity> pendingUsers) {this.pendingUsers = pendingUsers;}

    public List<ChallengeEntity> getChallenges() {
        return challenges;
    }

    public void setChallenges(List<ChallengeEntity> challenges) {
        this.challenges = challenges;
    }
}
