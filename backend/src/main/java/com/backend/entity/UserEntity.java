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
    private int age = 18;
    private List<String> userGroups;
    public UserEntity(String login, String password, String name, String tgAlias, int age) {
        this.login = login;
        this.password = password;
        this.name = name;
        this.tgAlias = tgAlias;
        this.age = age;
        token = UUID.randomUUID().toString();
        userGroups = new ArrayList<>();
    }

    public void addGroup(String groupId) {
        userGroups.add(groupId);
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

    public String name(){return name;}

    public void name(String name){this.name = name;}

    public String getTgAlias(){return tgAlias;}

    public void setTgAlias(String tgAlias){this.tgAlias = tgAlias;}

    public int getAge(){return age;}

    public void setAge(int age){this.age = age;}

    public List<String> getUserGroups(){return userGroups;}

    public void setUserGroups(List<String> userGroups) {this.userGroups = userGroups;}
}
