package com.backend.entity;

import org.springframework.data.annotation.Id;

import java.util.*;

public class UserEntity {
    @Id
    private String login;
    private String password;
    private String token;
    private String name = "DefaultName";
    private String tgAlias = "DefaulTg";
    private String description;
    private List<String> tags;
    private int age = 18;
    private List<String> userGroups;
    public UserEntity(String login, String password, String name, String tgAlias, String description, List<String> tags, int age) {
        this.login = login;
        this.password = password;
        this.name = name;
        this.tgAlias = tgAlias;
        this.age = age;
        token = UUID.randomUUID().toString();
        userGroups = new ArrayList<>();
        if (tags == null) {
            this.tags = new ArrayList<>();
        }
        else this.tags = tags;
        this.description = description;
    }

    public void addGroup(String groupId) {
        if (!userGroups.contains(groupId)) {
            userGroups.add(groupId);
        }
    }

    public void removeGroup(String groupId) {
        if (userGroups.contains(groupId)) {
            userGroups.remove(groupId);
        }
    }

    public boolean isMemberOfGroup(String groupId) {
        return userGroups.contains(groupId);
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getLogin() {
        return login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public String getToken() {
        return this.token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getName(){return name;}

    public void setName(String name){this.name = name;}

    public String getTgAlias(){return tgAlias;}

    public void setTgAlias(String tgAlias){this.tgAlias = tgAlias;}

    public int getAge(){return age;}

    public void setAge(int age){this.age = age;}

    public List<String> getUserGroups(){return userGroups;}

    public void setUserGroups(List<String> userGroups) {this.userGroups = userGroups;}

    public String getDescription(){return description;}

    public void setDescription(String description){this.description = description;}

    public List<String> getTags(){return tags;};

    public void setTags(List<String> tags) {this.tags = tags;}
}
