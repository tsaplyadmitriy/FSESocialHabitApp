package com.backend.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Document("group")
public class GroupEntity {
    private @Id String id;
    private String groupName;
    private String groupDescription = "Default description";
    private int membersLimit;
    private List<String> members = null;
    private List<String> groupTags = null;
    private String owner;
    private String groupCategory;

    public GroupEntity(){
        this.id = UUID.randomUUID().toString();
        members = new ArrayList<>();
        groupTags = new ArrayList<>();
    }

    public GroupEntity(String owner, String groupName, int membersLimit, String groupCategory, String groupDescription, List<String> groupTags) {
        this.id = UUID.randomUUID().toString();
        this.owner = owner;
        this.groupName = groupName;
        this.groupDescription = groupDescription;
        this.groupCategory = groupCategory;
        this.membersLimit = membersLimit;
        this.members = new ArrayList<>();
        this.groupTags = new ArrayList<>();
        this.groupTags = groupTags;
        try {
            this.ifOwner(owner).addMember(owner);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public GroupEntity(String owner, String groupName, int membersLimit, String groupCategory) {
        this.id = UUID.randomUUID().toString();
        this.owner = owner;
        this.groupName = groupName;
        this.membersLimit = membersLimit;
        this.groupCategory = groupCategory;
        this.members = new ArrayList<>();
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
        if (members.size() >= membersLimit) {
            throw new Exception("Limit of members is exceeded!");
        }
        members.add(login);
        return this;
    }

    private boolean isOwner(String owner) {
        return owner.compareTo(this.owner) == 0;
    }

    public int getMembersNumber() {return members.size();}

    public void addTag(String tag) {
        if (this.groupTags.contains(tag)) {
            return;
        }
        groupTags.add(tag);
    }

    public void deleteMember(String owner, String login) throws Exception {
        if (!members.contains(login)) {
            throw new Exception("No user with login=" + login + " in this group!");
        }
        if (!isOwner(owner)) {
            throw new Exception("You are not an owner of this group!");
        }
        members.remove(login);
    }

    public boolean isValid() {
        if (owner == null || membersLimit < 1 || groupName == null
                || !groupName.matches("\\w.*") || !groupCategory.matches("\\w.*")) {
            return false;
        }
        if (!members.contains(owner)) {
            this.members.add(owner);
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

    public List<String> getMembers() {
        return members;
    }

    public void setMembers(List<String> members) {
        this.members = members;
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

}
